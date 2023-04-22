# Grant kubectl proxy to provide full access to the Dashboard UI & api
kubectl proxy --port=33458 --address='0.0.0.0' --accept-hosts='^.*' &
