docker build -t shengcer/multi-client:latest -t shengcer/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shengcer/multi-server:latest -t shengcer/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shengcer/multi-worker:latest -t shengcer/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shengcer/multi-client:latest
docker push shengcer/multi-server:latest
docker push shengcer/multi-worker:latest
docker push shengcer/multi-client:$SHA
docker push shengcer/multi-server:$SHA
docker push shengcer/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=shengcer/multi-server:$SHA
kubectl set image deployments/client-deployment client=shengcer/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=shengcer/multi-worker:$SHA