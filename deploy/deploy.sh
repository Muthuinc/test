#! /bin/bash



a=$(aws ec2 describe-instances --region ap-south-1 --filters "Name=tag:Env,Values=prod" --query 'Reservations[].Instances[].PublicIpAddress' --output text)

ssh -o StrictHostKeyChecking=no -i "$SSH_KEY" "$ubuntu"@$a <<EOF


sudo GIT_COMMIT=$GIT_COMMIT docker-compose up -d


if curl localhost:80
then
  echo "success"
fi

EOF
