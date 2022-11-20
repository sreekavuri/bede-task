install-addons: ##Install required addons for minikube cluster
	@echo "Installing minikube dependencies"
	@minikube addons enable ingress
	@minikube addons enable metrics-server

install-chart: install-addons
	@helm upgrade --install $(app_name) $(chart_loc)

uninstall-chart:
	@ helm uninstall $(app_name)


### To run this file run below command and replace the last dir from bede-takehome-task/ to actual place where the helm chart code resides.
## make install-chart app_name=bede-app chart_loc=bede-takehome-task/

