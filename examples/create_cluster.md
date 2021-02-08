### Creating a cluster

```shell
$ ./cluster.sh -s
Cluster region (defaults to `us-east-2`): 
WARNING: Defaulting to us-east-2
ERROR: No clusters found
$ ./cluster.sh -c
Cluster name (optional): brandon-test
Your name (for tagging purposes, defaults to `Support`): Brandon
Override K8s version (defaults to 1.18): 
WARNING: Defaulting to 1.18
Cluster region (default `us-east-2`): 
WARNING: Defaulting to us-east-2
Min number of worker nodes (default is 2): 
WARNING: Defaulting to 2
Max number of worker nodes (default is 2 + 1 = 3): 
WARNING: Defaulting to 3
Instance size (default is `t3.medium`): 
WARNING: Defaulting to t3.medium
Instance volume size (default 80 (GB)): 
WARNING: Defaulting to 80
Nodegroup name (default `test`): 
WARNING: Defaulting to test
Nodegroup labels (default `env=test`; must be in format key1=val1,key2=val2): env=test,agent=2-3-1

Creating EKS Cluster

[ℹ]  eksctl version 0.31.0
[ℹ]  using region us-east-2
[ℹ]  setting availability zones to [us-east-2a us-east-2c us-east-2b]
[ℹ]  subnets for us-east-2a - public:192.168.0.0/19 private:192.168.96.0/19
[ℹ]  subnets for us-east-2c - public:192.168.32.0/19 private:192.168.128.0/19
[ℹ]  subnets for us-east-2b - public:192.168.64.0/19 private:192.168.160.0/19
[ℹ]  nodegroup "test" will use "ami-0b9bf042ba04abfa6" [AmazonLinux2/1.18]
[ℹ]  using Kubernetes version 1.18
[ℹ]  creating EKS cluster "brandon-test" in "us-east-2" region with un-managed nodes
[ℹ]  will create 2 separate CloudFormation stacks for cluster itself and the initial nodegroup
[ℹ]  if you encounter any issues, check CloudFormation console or try 'eksctl utils describe-stacks --region=us-east-2 --cluster=brandon-test'
[ℹ]  CloudWatch logging will not be enabled for cluster "brandon-test" in "us-east-2"
[ℹ]  you can enable it with 'eksctl utils update-cluster-logging --enable-types={SPECIFY-YOUR-LOG-TYPES-HERE (e.g. all)} --region=us-east-2 --cluster=brandon-test'
[ℹ]  Kubernetes API endpoint access will use default of {publicAccess=true, privateAccess=false} for cluster "brandon-test" in "us-east-2"
[ℹ]  2 sequential tasks: { create cluster control plane "brandon-test", 2 sequential sub-tasks: { tag cluster, create nodegroup "test" } }
[ℹ]  building cluster stack "eksctl-brandon-test-cluster"
[ℹ]  deploying stack "eksctl-brandon-test-cluster"
[✔]  tagged EKS cluster (Owner=Brandon)
[ℹ]  building nodegroup stack "eksctl-brandon-test-nodegroup-test"
[ℹ]  deploying stack "eksctl-brandon-test-nodegroup-test"
[ℹ]  waiting for the control plane availability...
[✔]  saved kubeconfig as "/Users/brandondoyle/.kube/eksctl/clusters/brandon-test"
[ℹ]  no tasks
[✔]  all EKS cluster resources for "brandon-test" have been created
[ℹ]  adding identity "arn:aws:iam::317200895319:role/eksctl-brandon-test-nodegroup-tes-NodeInstanceRole-1P8YDQ0AOQQRW" to auth ConfigMap
[ℹ]  nodegroup "test" has 0 node(s)
[ℹ]  waiting for at least 2 node(s) to become ready in "test"
[ℹ]  nodegroup "test" has 2 node(s)
[ℹ]  node "ip-192-168-38-21.us-east-2.compute.internal" is ready
[ℹ]  node "ip-192-168-83-107.us-east-2.compute.internal" is ready
[ℹ]  kubectl command should work with "/Users/brandondoyle/.kube/eksctl/clusters/brandon-test", try 'kubectl --kubeconfig=/Users/brandondoyle/.kube/eksctl/clusters/brandon-test get nodes'
[✔]  EKS cluster "brandon-test" in "us-east-2" region is ready

EKS Cluster brandon-test created. Moving on to optional additional compute

Would you like to add further nodegroups? [y/n]: n
```