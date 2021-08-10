### Deploy an application

```shell
$ ./cluster.sh -g
Cluster region (defaults to `us-east-2`):
WARNING: Defaulting to us-east-2
NAME		REGION
brandon-test	us-east-2
Select a cluster from the above list to generate `update-kubeconfig` command on: brandon-test

Execute the following command to connect to your new cluster:

$ sudo aws eks --region us-east-2 update-kubeconfig --name brandon-test

$ sudo aws eks --region us-east-2 update-kubeconfig --name brandon-test
Password:
Updated context arn:aws:eks:us-east-2:317200895319:cluster/brandon-test in /Users/brandondoyle/.kube/config
...
# k create -f ns.yaml
namespace/monitoring created
namespace/threatstack created
(base) TS-C02TT3DBG8WN:helm_try brandondoyle$ tf apply -auto-approve
module.threatstack-agent.helm_release.threatstack: Refreshing state... [id=threatstack-agent]
module.datadog-agent.helm_release.datadog-agent: Refreshing state... [id=datadog-agent]
module.threatstack-agent.helm_release.threatstack: Creating...
module.datadog-agent.helm_release.datadog-agent: Creating...
module.threatstack-agent.helm_release.threatstack: Still creating... [10s elapsed]
module.datadog-agent.helm_release.datadog-agent: Still creating... [10s elapsed]
module.threatstack-agent.helm_release.threatstack: Creation complete after 17s [id=threatstack-agent]
module.datadog-agent.helm_release.datadog-agent: Still creating... [20s elapsed]
module.datadog-agent.helm_release.datadog-agent: Still creating... [30s elapsed]
module.datadog-agent.helm_release.datadog-agent: Still creating... [40s elapsed]
module.datadog-agent.helm_release.datadog-agent: Still creating... [50s elapsed]
module.datadog-agent.helm_release.datadog-agent: Creation complete after 58s [id=datadog-agent]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
# k get ns
NAME              STATUS   AGE
default           Active   19m
kube-node-lease   Active   19m
kube-public       Active   19m
kube-system       Active   19m
monitoring        Active   73s
threatstack       Active   73s
# k get pods -n threatstack
NAME                                                READY   STATUS    RESTARTS   AGE
threatstack-agent-bsqtj                             1/1     Running   0          67s
threatstack-agent-crmcr                             1/1     Running   0          67s
threatstack-agent-kubernetes-api-64c5ff7d48-4t6sd   1/1     Running   0          67s
threatstack-agent-q7mjd                             1/1     Running   0          67s
threatstack-agent-w7pjn                             1/1     Running   0          67s
# k exec -it threatstack-agent-bsqtj -n threatstack -- tsagent status
  UP Threat Stack Agent Daemon
  UP Threat Stack Backend Connection
  UP Threat Stack Docker Monitoring
  UP Threat Stack Heartbeat Service
  UP Threat Stack Login Collector
  UP Threat Stack Log Scan Service
  UP Threat Stack Vulnerability Scanner
  UP Threat Stack File Integrity Monitor
```
