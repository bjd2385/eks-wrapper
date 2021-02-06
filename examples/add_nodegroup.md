### Adding a nodegroup to an existing cluster

```shell
$ ./cluster.sh -a
Cluster region (defaults to `us-east-2`): 
WARNING: Defaulting to us-east-2
NAME		REGION
brandon-test	us-east-2
Select a cluster from the above list to add a node group to: brandon-test
Your name (for tagging purposes, defaults to `Support`): Brandon
CLUSTER		NODEGROUP	STATUS		CREATED			MIN SIZE	MAX SIZE	DESIRED CAPACITY	INSTANCE TYPE	IMAGE ID
brandon-test	test		CREATE_COMPLETE	2021-02-06T09:47:04Z	2		3		0			t3.medium	ami-0b9bf042ba04abfa6
Min number of worker nodes (default is 2): 
WARNING: Defaulting to 2
Max number of worker nodes (default is 2 + 1 = 3): 
WARNING: Defaulting to 3
Instance size (default is `t3.medium`): 
WARNING: Defaulting to t3.medium
Instance volume size (default 80 (GB)): 
WARNING: Defaulting to 80
Nodegroup name (default `test`): test2
Nodegroup labels (default `env=test`; must be in format key1=val1,key2=val2): 
WARNING: Defaulting to env=test

Creating EKS Nodegroup

[ℹ]  eksctl version 0.31.0
[ℹ]  using region us-east-2
[ℹ]  will use version 1.18 for new nodegroup(s) based on control plane version
[ℹ]  nodegroup "test2" present in the given config, but missing in the cluster
[ℹ]  nodegroup "test" present in the cluster, but missing from the given config
[ℹ]  1 existing nodegroup(s) (test) will be excluded
[ℹ]  nodegroup "test2" will use "ami-0b9bf042ba04abfa6" [AmazonLinux2/1.18]
[ℹ]  1 nodegroup (test2) was included (based on the include/exclude rules)
[ℹ]  will create a CloudFormation stack for each of 1 nodegroups in cluster "brandon-test"
[ℹ]  2 sequential tasks: { fix cluster compatibility, 1 task: { 1 task: { create nodegroup "test2" } } }
[ℹ]  checking cluster stack for missing resources
[ℹ]  cluster stack has all required resources
[ℹ]  building nodegroup stack "eksctl-brandon-test-nodegroup-test2"
[ℹ]  deploying stack "eksctl-brandon-test-nodegroup-test2"
[ℹ]  no tasks
[ℹ]  adding identity "arn:aws:iam::317200895319:role/eksctl-brandon-test-nodegroup-tes-NodeInstanceRole-QN4HUTMK7KOF" to auth ConfigMap
[ℹ]  nodegroup "test2" has 0 node(s)
[ℹ]  waiting for at least 2 node(s) to become ready in "test2"
[ℹ]  nodegroup "test2" has 2 node(s)
[ℹ]  node "ip-192-168-35-95.us-east-2.compute.internal" is ready
[ℹ]  node "ip-192-168-86-164.us-east-2.compute.internal" is ready
[✔]  created 1 nodegroup(s) in cluster "brandon-test"
[✔]  created 0 managed nodegroup(s) in cluster "brandon-test"
[ℹ]  checking security group configuration for all nodegroups
[ℹ]  all nodegroups have up-to-date configuration

CLUSTER		NODEGROUP	STATUS		CREATED			MIN SIZE	MAX SIZE	DESIRED CAPACITY	INSTANCE TYPE	IMAGE ID
brandon-test	test		CREATE_COMPLETE	2021-02-06T09:47:04Z	2		3		0			t3.medium	ami-0b9bf042ba04abfa6
brandon-test	test2		CREATE_COMPLETE	2021-02-06T09:56:16Z	2		3		0			t3.medium	ami-0b9bf042ba04abfa6

```