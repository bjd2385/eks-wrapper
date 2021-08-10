### Removing an existing nodegroup from an existing cluster

```shell
$ ./cluster.sh -r
Cluster region (defaults to `us-east-2`):
WARNING: Defaulting to us-east-2
NAME		REGION
brandon-test	us-east-2
Select a cluster from the above list to remove a node group from: brandon-test
CLUSTER		NODEGROUP	STATUS		CREATED			MIN SIZE	MAX SIZE	DESIRED CAPACITY	INSTANCE TYPE	IMAGE ID
brandon-test	test		CREATE_COMPLETE	2021-02-06T09:47:04Z	2		3		0			t3.medium	ami-0b9bf042ba04abfa6
brandon-test	test2		CREATE_COMPLETE	2021-02-06T09:56:16Z	2		3		0			t3.medium	ami-0b9bf042ba04abfa6
Select a nodegroup (name) from the above list to remove from cluster brandon-test: test2

Deleting nodegroup test2 from cluster brandon-test

[ℹ]  eksctl version 0.31.0
[ℹ]  using region us-east-2
[ℹ]  1 nodegroup (test2) was included (based on the include/exclude rules)
[ℹ]  will drain 1 nodegroup(s) in cluster "brandon-test"
[ℹ]  cordon node "ip-192-168-35-95.us-east-2.compute.internal"
[ℹ]  cordon node "ip-192-168-86-164.us-east-2.compute.internal"
[!]  ignoring DaemonSet-managed Pods: kube-system/aws-node-k2vtg, kube-system/kube-proxy-spn7t, monitoring/datadog-agent-jdx2j, threatstack/threatstack-agent-q7mjd
[!]  ignoring DaemonSet-managed Pods: kube-system/aws-node-bbmfr, kube-system/kube-proxy-ttgcg, monitoring/datadog-agent-8p5ld, threatstack/threatstack-agent-w7pjn
[!]  ignoring DaemonSet-managed Pods: kube-system/aws-node-bbmfr, kube-system/kube-proxy-ttgcg, monitoring/datadog-agent-8p5ld, threatstack/threatstack-agent-w7pjn
[!]  ignoring DaemonSet-managed Pods: kube-system/aws-node-bbmfr, kube-system/kube-proxy-ttgcg, monitoring/datadog-agent-8p5ld, threatstack/threatstack-agent-w7pjn
[!]  ignoring DaemonSet-managed Pods: kube-system/aws-node-bbmfr, kube-system/kube-proxy-ttgcg, monitoring/datadog-agent-8p5ld, threatstack/threatstack-agent-w7pjn
[!]  ignoring DaemonSet-managed Pods: kube-system/aws-node-bbmfr, kube-system/kube-proxy-ttgcg, monitoring/datadog-agent-8p5ld, threatstack/threatstack-agent-w7pjn
[!]  ignoring DaemonSet-managed Pods: kube-system/aws-node-bbmfr, kube-system/kube-proxy-ttgcg, monitoring/datadog-agent-8p5ld, threatstack/threatstack-agent-w7pjn
[!]  ignoring DaemonSet-managed Pods: kube-system/aws-node-bbmfr, kube-system/kube-proxy-ttgcg, monitoring/datadog-agent-8p5ld, threatstack/threatstack-agent-w7pjn
[!]  ignoring DaemonSet-managed Pods: kube-system/aws-node-bbmfr, kube-system/kube-proxy-ttgcg, monitoring/datadog-agent-8p5ld, threatstack/threatstack-agent-w7pjn
[!]  ignoring DaemonSet-managed Pods: kube-system/aws-node-bbmfr, kube-system/kube-proxy-ttgcg, monitoring/datadog-agent-8p5ld, threatstack/threatstack-agent-w7pjn
[!]  ignoring DaemonSet-managed Pods: kube-system/aws-node-bbmfr, kube-system/kube-proxy-ttgcg, monitoring/datadog-agent-8p5ld, threatstack/threatstack-agent-w7pjn
[!]  ignoring DaemonSet-managed Pods: kube-system/aws-node-bbmfr, kube-system/kube-proxy-ttgcg, monitoring/datadog-agent-8p5ld, threatstack/threatstack-agent-w7pjn
[!]  ignoring DaemonSet-managed Pods: kube-system/aws-node-bbmfr, kube-system/kube-proxy-ttgcg, monitoring/datadog-agent-8p5ld, threatstack/threatstack-agent-w7pjn
[!]  ignoring DaemonSet-managed Pods: kube-system/aws-node-bbmfr, kube-system/kube-proxy-ttgcg, monitoring/datadog-agent-8p5ld, threatstack/threatstack-agent-w7pjn
[!]  ignoring DaemonSet-managed Pods: kube-system/aws-node-bbmfr, kube-system/kube-proxy-ttgcg, monitoring/datadog-agent-8p5ld, threatstack/threatstack-agent-w7pjn
[!]  ignoring DaemonSet-managed Pods: kube-system/aws-node-bbmfr, kube-system/kube-proxy-ttgcg, monitoring/datadog-agent-8p5ld, threatstack/threatstack-agent-w7pjn
[!]  ignoring DaemonSet-managed Pods: kube-system/aws-node-bbmfr, kube-system/kube-proxy-ttgcg, monitoring/datadog-agent-8p5ld, threatstack/threatstack-agent-w7pjn
[!]  ignoring DaemonSet-managed Pods: kube-system/aws-node-bbmfr, kube-system/kube-proxy-ttgcg, monitoring/datadog-agent-8p5ld, threatstack/threatstack-agent-w7pjn
[!]  ignoring DaemonSet-managed Pods: kube-system/aws-node-bbmfr, kube-system/kube-proxy-ttgcg, monitoring/datadog-agent-8p5ld, threatstack/threatstack-agent-w7pjn
[!]  pod eviction error ("pods \"threatstack-agent-kubernetes-api-64c5ff7d48-4t6sd\" not found") on node ip-192-168-86-164.us-east-2.compute.internal – will retry after delay of 5s
[!]  ignoring DaemonSet-managed Pods: kube-system/aws-node-bbmfr, kube-system/kube-proxy-ttgcg, monitoring/datadog-agent-8p5ld, threatstack/threatstack-agent-w7pjn
[✔]  drained nodes: [ip-192-168-35-95.us-east-2.compute.internal ip-192-168-86-164.us-east-2.compute.internal]
[ℹ]  will delete 1 nodegroups from cluster "brandon-test"
[ℹ]  1 task: { delete nodegroup "test2" [async] }
[ℹ]  will delete stack "eksctl-brandon-test-nodegroup-test2"
[ℹ]  will delete 1 nodegroups from auth ConfigMap in cluster "brandon-test"
[ℹ]  removing identity "arn:aws:iam::317200895319:role/eksctl-brandon-test-nodegroup-tes-NodeInstanceRole-QN4HUTMK7KOF" from auth ConfigMap (username = "system:node:{{EC2PrivateDNSName}}", groups = ["system:bootstrappers" "system:nodes"])
[✔]  deleted 1 nodegroup(s) from cluster "brandon-test"

$ ./cluster.sh -r
Cluster region (defaults to `us-east-2`):
WARNING: Defaulting to us-east-2
NAME		REGION
brandon-test	us-east-2
Select a cluster from the above list to remove a node group from: brandon-test
CLUSTER		NODEGROUP	STATUS			CREATED			MIN SIZE	MAX SIZE	DESIRED CAPACITY	INSTANCE TYPE	IMAGE ID
brandon-test	test		CREATE_COMPLETE		2021-02-06T09:47:04Z	2		3		0			t3.medium	ami-0b9bf042ba04abfa6
brandon-test	test2		DELETE_IN_PROGRESS	2021-02-06T09:56:16Z	2		3		0			t3.medium	ami-0b9bf042ba04abfa6
Select a nodegroup (name) from the above list to remove from cluster brandon-test: ^C
```
