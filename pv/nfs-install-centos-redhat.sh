#!/bin/bash
echo "*** Installing NFS ***"
yum -y install nfs-utils
systemctl start nfs
systemctl start rpcbind
echo "*** Configuring NFS ***"
mkdir /nfs
chmod 777 /nfs
echo '/nfs *(rw,no_root_squash)' >> /etc/exports
exportfs -a
setsebool -P virt_use_nfs 1
cat <<EOF >> /etc/sysconfig/nfs
LOCKD_TCPPORT=32803
LOCKD_UDPPORT=32769
MOUNTD_PORT=892
EOF
systemctl restart rpcbind
systemctl restart nfs
iptables -I INPUT -p udp -s 0/0 -d 0/0 -m multiport --dport 111,42819,45216,20048,2049,42261,58086 -j ACCEPT
iptables -I INPUT -p tcp -s 0/0 -d 0/0 -m multiport --dport 111,42819,45216,20048,2049,42261,58086 -j ACCEPT
firewall-cmd --add-service=nfs --permanent
firewall-cmd --add-service=mountd --permanent
firewall-cmd --add-service=rpc-bind --permanent
firewall-cmd --reload
firewall-cmd --list-all
showmount -e localhost
echo "Done!"