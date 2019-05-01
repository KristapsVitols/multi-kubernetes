docker build -t kristapsvitols/multi-client:latest -t kristapsvitols/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kristapsvitols/multi-server:latest -t kristapsvitols/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kristapsvitols/multi-worker:latest -t kristapsvitols/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kristapsvitols/multi-client:latest
docker push kristapsvitols/multi-server:latest
docker push kristapsvitols/multi-worker:latest
docker push kristapsvitols/multi-client:$SHA
docker push kristapsvitols/multi-server:$SHA
docker push kristapsvitols/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kristapsvitols/multi-server:$SHA
kubectl set image deployments/client-deployment client=kristapsvitols/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kristapsvitols/multi-worker:$SHA