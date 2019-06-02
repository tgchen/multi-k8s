docker build -t wynetech/multi-client:latest -t wynetech/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t wynetech/multi-server:latest -t wynetech/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t wynetech/multi-worker:latest -t wynetech/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push wynetech/multi-client:latest
docker push wynetech/multi-server:latest
docker push wynetech/multi-worker:latest

docker push wynetech/multi-client:$SHA
docker push wynetech/multi-server:$SHA
docker push wynetech/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=wynetech/multi-server:$SHA
kubectl set image deployment/client-deployment client=wynetech/multi-client:$SHA
kubectl set image deployment/worker-deployment woker=wynetech/multi-worker:$SHA