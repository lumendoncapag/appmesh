TAG=$1

aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 058264531735.dkr.ecr.us-east-2.amazonaws.com

docker build -t "flamencoapp:$TAG" ./flamencoapp/
docker tag "flamencoapp:$TAG" "058264531735.dkr.ecr.us-east-2.amazonaws.com/flamencoapp:$TAG"
docker push "058264531735.dkr.ecr.us-east-2.amazonaws.com/flamencoapp:$TAG"

docker build -t "operaapp:$TAG" ./operaapp/
docker tag "operaapp:$TAG" "058264531735.dkr.ecr.us-east-2.amazonaws.com/operaapp:$TAG"
docker push "058264531735.dkr.ecr.us-east-2.amazonaws.com/operaapp:$TAG"

docker build -t "musicboxapp:$TAG" ./musicboxapp/
docker tag "musicboxapp:$TAG" "058264531735.dkr.ecr.us-east-2.amazonaws.com/musicboxapp:$TAG"
docker push "058264531735.dkr.ecr.us-east-2.amazonaws.com/musicboxapp:$TAG"
