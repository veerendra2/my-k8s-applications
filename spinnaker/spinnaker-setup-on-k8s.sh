#!/bin/bash
# Author: Veerendra Kakumanu
# Description: Deploys spinnaker on K8s cluster as micro services. 
# Please specify below configuration details and run the script.
#

USERNAME=""
REPOSITORIES="library/mongo uric/nodecellar veerendrav2/mysql veerendrav2/php-application"
ADDRESS=index.docker.io
accessKeyId=rebaca123
region=us-east
nodeportip="" # Specify Node IP of any minion in K8s cluster. Used to access service via NodePort


echo "Installing kubeclt binary"
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.8.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
echo "[*] Installing Halyard"
curl -O https://raw.githubusercontent.com/spinnaker/halyard/master/install/stable/InstallHalyard.sh
sudo bash InstallHalyard.sh

hal config deploy edit --type distributed
hal config storage edit --type redis
hal config storage s3 edit --access-key-id $accessKeyId --secret-access-key --region $region --endpoint http://minio-service.spinnaker:9000
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
hal config version edit --version $VERSION
echo "host: 0.0.0.0" | tee \
    ~/.hal/default/service-settings/gate.yml \
    ~/.hal/default/service-settings/deck.yml
hal config security ui edit --override-base-url http://$nodeportip:30900 #Deck
hal config security api edit --override-base-url http://$nodeportip:30808 #Gate
hal deploy apply
echo "[*] Patching spin-gate & spin-deck service"
kubectl patch svc spin-gate -p '{"spec":{"type":"NodePort"}}'
kubectl patch svc spin-gate -p '{"spec":"ports":["nodePort":"30808"]}'
kubectl patch svc spin-deck -p '{"spec":{"type":"NodePort"}}'
kubectl patch svc spin-deck -p '{"spec":"ports":["nodePort":"30900"]}'
echo "Now you able to access spinnaker UI at http://NODEIP:30900"