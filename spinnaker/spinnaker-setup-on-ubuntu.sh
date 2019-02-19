#!/bin/bash
# Author: Veerendra Kakumanu
# Description: Installs spinnaker on ubuntu server
# Please specify below configuration details and run the script.
#

USERNAME=veerendrav2
REPOSITORIES="library/mongo uric/nodecellar veerendrav2/mysql veerendrav2/php-application"
ADDRESS=index.docker.io
region=east
accessKeyId=""
serverip="" #IP addess of ubuntu server which currently your deploying spinnaker
minionnodeport="" #NodePort of Minio service. kubectl get svc -n namespace | grep minio
nodeportip="" # # Specify Node IP of any minion in K8s cluster. Used to access service via NodePort

echo "Installing kubeclt binary"
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.8.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
echo "[*] Installing Halyard"
curl -O https://raw.githubusercontent.com/spinnaker/halyard/master/install/stable/InstallHalyard.sh
sudo bash InstallHalyard.sh

hal config deploy edit --type distributed
hal config storage edit --type redis
hal config storage s3 edit --access-key-id $accessKeyId --secret-access-key --region $region --endpoint http://$nodeportip:$minionnodeport
hal config storage edit --type s3
hal config provider docker-registry enable
hal config provider docker-registry account add my-docker-registry --address $ADDRESS --repositories $REPOSITORIES --username $USERNAME --password
hal config provider kubernetes enable
hal config provider kubernetes account add my-k8s-account --docker-registries my-docker-registry
hal config deploy edit --account-name my-k8s-account --type distributed
hal version list 
read version
if [ -z "$version" ]
then
	echo ""
else
	echo $version>version.tmp
	break
fi
done
hal config version edit --version `cat version.tmp`
echo "host: 0.0.0.0" | tee \
    ~/.hal/default/service-settings/gate.yml \
    ~/.hal/default/service-settings/deck.yml
hal config security ui edit --override-base-url http://$serverip:9000 #Deck
hal config security api edit --override-base-url http://$serverip:8084 #Gate
hal deploy apply