docker build -t prashantkumarjha1/multi-client:latest -t prashantkumarjha1/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t prashantkumarjha1/multi-server:latest -t prashantkumarjha1/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t prashantkumarjha1/multi-worker:latest -t prashantkumarjha1/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push prashantkumarjha1/multi-client:latest
docker push prashantkumarjha1/multi-server:latest
docker push prashantkumarjha1/multi-worker:latest

docker push prashantkumarjha1/multi-client:$SHA
docker push prashantkumarjha1/multi-server:$SHA
docker push prashantkumarjha1/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=prashantkumarjha1/multi-server:$SHA
kubectl set image deployments/client-deployment client=prashantkumarjha1/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=prashantkumarjha1/multi-worker:$SHA