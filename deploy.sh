docker build -t pdxc/multi-client:latest -t pdxc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pdxc/multi-server:latest -t pdxc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pdxc/multi-worker:latest -t pdxc/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pdxc/multi-client:latest
docker push pdxc/multi-server:latest
docker push pdxc/multi-worker:latest

docker push pdxc/multi-client:$SHA
docker push pdxc/multi-server:$SHA
docker push pdxc/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=pdxc/multi-client:$SHA
kubectl set image deployments/server-deployment server=pdxc/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=pdxc/multi-worker:$SHA
