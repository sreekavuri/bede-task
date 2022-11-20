1. This project will deploy `yesinteractive/dadjokes` image into kubernetes cluster.

2. It will create `namespace`, `deployment`, `service`, `horizontal pod autoscalar`, `ingress` components into the cluster.

3. All our components will get deploy into `sre-techtask` namespace as we have mentioned the same in `values.yaml` file.

4. If we are going to run this stack on minikube, then we need to enable ingress & metrics-server addon on minikube. to do that run below command.
```
$ minikube addons enable ingress
$ minikube addons enable metric-server
```

5. To deploy this helm chart with default values, you can simply run `helm install <app name> <chart location>`

**Note:** app name can be anything this is a reference to helm and the same name used to create resources as well.

```
$ helm install bedeapp sumanth-task/
```

6. If you want to deploy this chart with custom values, you can use `override-values.yaml` file while deploying. In this override file you can mention only the values you want to override. remaing will be taken from default values.

```
$ helm install bedeapp sumanth-task/ -f sumanth-task/override-values.yaml
```

7. To verify the created resources, you can run `kubectl` command `kubectl get all -n <namespace name>`. Here provide the namespace name which you have used in values file. This will show all resources except ingress component. to view ingress, run `kubectl get ing -n <namespace name>`
```
$ kubectl get all -n sre-techtask
$ kubectl get ing -n sre-techtask
```

8. Since we have given dummy url for ingress host, we need to map local dns for the same. Then only our application will work on url. for that run get ingress comand and append the hostname and IP address in `/etc/hosts` file.

**Note:** Sometimes it will take couple of mints time to show the IP address after the deployment. so please check in 1 or 2 mints to see the IP address. 

```
$ k get ing -n sre-techtask

NAME                CLASS   HOSTS          ADDRESS        PORTS   AGE
bedeapp-bede-task   nginx   bedeapp.info   192.168.49.2   80      22m
```

```
$ cat /etc/hosts

127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.49.2	bedeapp.info
```
9. Now we are all set to test the application. We can use curl command to test the applcation.
```
$ curl bedeapp.info
```
**Output looks like below:**
```
{"Joke":{"Opener":"Why did the kid cross the playground? ","Punchline":"To get to the other slide.","Processing Time":"0.000799"},"RequestEcho":{"Headers":{"Host":"bedeapp.info","X-Request-ID":"ba46f776767adfe0a5d8d91ad87bc211","X-Real-IP":"192.168.49.1","X-Forwarded-For":"192.168.49.1","X-Forwarded-Host":"bedeapp.info","X-Forwarded-Port":"80","X-Forwarded-Proto":"http","X-Forwarded-Scheme":"http","X-Scheme":"http","User-Agent":"curl/7.29.0","Accept":"*/*"},"Method":"GET","Origin":"172.17.0.4","URI":"/","Arguments":[],"Data":"","URL":"http://bedeapp.info/"},"DadJokesInfo":{"SourceCode":"https://github.com/yesinteractive/dadjokes","Version":"20211111"}}
```

10. To deploy all these with single command, we can run make command as like below,
```
make install-chart app_name=bede-app chart_loc=bede-takehome-task/
```
