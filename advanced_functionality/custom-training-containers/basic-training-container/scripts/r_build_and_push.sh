ACCOUNT_ID=$1
REGION=$2
REPO_NAME=$3
TAG_NAME=$4

docker build -f ../docker/Dockerfile-20 -t $REPO_NAME ../docker

docker tag $REPO_NAME $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO_NAME:$TAG_NAME

# $(aws ecr get-login --no-include-email --registry-ids $ACCOUNT_ID)
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com

aws ecr describe-repositories --repository-names $REPO_NAME || aws ecr create-repository --repository-name $REPO_NAME

docker push $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO_NAME:$TAG_NAME
