# Machine Learning Prediction in Real-Time Using Docker, Python Rest APIs With Flask and Kubernetes: 

#### Build Image From Docker File
```cmd
docker build -t ml-model-api  -f Dockerfile .
```

#### Run Container From the Created Image
```cmd
docker run -it -p 5000:5000 ml-model-api python3 api.py
```


#### To Enter into container
```cmd
docker run -it -p 5000:5000 ml-model-api /bin/bash
```
## Output
```md
(base) jovyan@3cc785f94af4:~/app$ ls
api.py  base  csv_to_json.py  data  Dockerfile  inference.py  model  README.md  requirements.txt  train.py
(base) jovyan@3cc785f94af4:~/app$ cd ..
(base) jovyan@3cc785f94af4:~$ ls
app  work
(base) jovyan@3cc785f94af4:~$ cd ..
(base) jovyan@3cc785f94af4:/home$ ls
jovyan
(base) jovyan@3cc785f94af4:/home$ cd jovyan
(base) jovyan@3cc785f94af4:~$ ls
app  work
(base) jovyan@3cc785f94af4:~$ cd app
(base) jovyan@3cc785f94af4:~/app$ ls
api.py  base  csv_to_json.py  data  Dockerfile  inference.py  model  README.md  requirements.txt  train.py
(base) jovyan@3cc785f94af4:~/app$ ls model
clf_lda.joblib  clf_nn.joblib
(base) jovyan@3cc785f94af4:~/app$ ls base
deployment.yaml  kustomization.yaml  namespace.yaml  service.yaml
(base) jovyan@3cc785f94af4:~/app$ ls data
test.csv  test.json  train.csv
(base) jovyan@3cc785f94af4:~/app$
```

### If Container is running and you want to enter
```cmd
docker exec -it container_name /bin/bash
```


# Push Image to Docker Hub
```cmd
docker login
docker tag ml-model-api:latest triloknathsharma/ml-model-api:latest
docker push triloknathsharma/ml-model-api:latest
```

## Docker Hub Image
```cmd
https://hub.docker.com/r/triloknathsharma/ml-model-api
```


## Now image is ready and we can proceed to Kubernetes
- I have created some files 
    - `base/deployments.yaml`
    - `base/service.yaml`
    - `base/namespace.yaml`
    - `base/kustomization.yaml`


**if you have kubernetes cluster already setup then you need to use this single command**
```cmd
kubectl apply --kustomize=${PWD}/base/ --record=true
```

**You will see the below output**

```md
C:\Users\xyz\Desktop\ToDo\ML-Model-Deployment-Kubernetes>kubectl apply --kustomize=.\base\ --record=true
Flag --record has been deprecated, --record will be removed in the future
namespace/mlops created
service/my-app created
deployment.apps/my-app created

C:\Users\xyz\Desktop\ToDo\ML-Model-Deployment-Kubernetes>kubectl get ns
NAME              STATUS   AGE
default           Active   7d22h
development       Active   45h
kube-node-lease   Active   7d22h
kube-public       Active   7d22h
kube-system       Active   7d22h
mlops             Active   91s

C:\Users\xyz\Desktop\ToDo\ML-Model-Deployment-Kubernetes>kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   7d22h

C:\Users\xyz\Desktop\ToDo\ML-Model-Deployment-Kubernetes>kubectl get svc -n mlops
NAME     TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
my-app   LoadBalancer   10.102.117.80   localhost     5000:30462/TCP   114s

C:\Users\xyz\Desktop\ToDo\ML-Model-Deployment-Kubernetes>kubectl get deploy -n mlops
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
my-app   2/2     2            2           2m27s
```

To Learn Each Component in Detail you can checkout my Docker and Kubernetes repo.


# Reference
https://medium.com/geekculture/machine-learning-prediction-in-real-time-using-docker-python-rest-apis-with-flask-and-kubernetes-fae08cd42e67