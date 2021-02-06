### EKS CLI wrapper

#### Synopsis

```shell
$ ./create_cluster.sh -h
Usage: ./create_cluster.sh [-h help] [-d dry run] [-D delete a cluster]
```

This tool is meant to aid Support/SEs in creating and deleting (simple) EKS clusters for testing purposes.

If you wish to add additional configuration options (cf. `eksctl -h`, or `eksctl create cluster -h` for further 
information), you may pass a `-d` (dry run) flag to the script to dump the command to `stdout` for further 
modification or review.

#### Prerequisites

This script requires `ossp-uuid` (Mac, or `uuid` on Linux), as well as a working `eksctl` installation. Refer to the [AWS
docs](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html) to install the latter utility.

#### Examples

*Create a cluster with all defaults*
```shell
$ ./create_cluster.sh
Cluster name (optional): 
WARNING: Defaulting to support-test-30910b16-6818-11eb-a8bc-186590df6e23
Your name (for tagging purposes, defaults to `Support`): 
WARNING: Defaulting to Support
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

Creating EKS cluster

[ℹ]  eksctl version 0.31.0
[ℹ]  using region us-east-2
[ℹ]  setting availability zones to [us-east-2c us-east-2a us-east-2b]
[ℹ]  subnets for us-east-2c - public:192.168.0.0/19 private:192.168.96.0/19
[ℹ]  subnets for us-east-2a - public:192.168.32.0/19 private:192.168.128.0/19
[ℹ]  subnets for us-east-2b - public:192.168.64.0/19 private:192.168.160.0/19
[ℹ]  nodegroup "test" will use "ami-0b9bf042ba04abfa6" [AmazonLinux2/1.18]
[ℹ]  using Kubernetes version 1.18
[ℹ]  creating EKS cluster "support-test-30910b16-6818-11eb-a8bc-186590df6e23" in "us-east-2" region with un-managed nodes
[ℹ]  will create 2 separate CloudFormation stacks for cluster itself and the initial nodegroup
[ℹ]  if you encounter any issues, check CloudFormation console or try 'eksctl utils describe-stacks --region=us-east-2 --cluster=support-test-30910b16-6818-11eb-a8bc-186590df6e23'
[ℹ]  CloudWatch logging will not be enabled for cluster "support-test-30910b16-6818-11eb-a8bc-186590df6e23" in "us-east-2"
[ℹ]  you can enable it with 'eksctl utils update-cluster-logging --enable-types={SPECIFY-YOUR-LOG-TYPES-HERE (e.g. all)} --region=us-east-2 --cluster=support-test-30910b16-6818-11eb-a8bc-186590df6e23'
[ℹ]  Kubernetes API endpoint access will use default of {publicAccess=true, privateAccess=false} for cluster "support-test-30910b16-6818-11eb-a8bc-186590df6e23" in "us-east-2"
[ℹ]  2 sequential tasks: { create cluster control plane "support-test-30910b16-6818-11eb-a8bc-186590df6e23", 2 sequential sub-tasks: { tag cluster, create nodegroup "test" } }
[ℹ]  building cluster stack "eksctl-support-test-30910b16-6818-11eb-a8bc-186590df6e23-cluster"
[ℹ]  deploying stack "eksctl-support-test-30910b16-6818-11eb-a8bc-186590df6e23-cluster"
[✔]  tagged EKS cluster (Owner=Support)
[ℹ]  building nodegroup stack "eksctl-support-test-30910b16-6818-11eb-a8bc-186590df6e23-nodegroup-test"
[ℹ]  deploying stack "eksctl-support-test-30910b16-6818-11eb-a8bc-186590df6e23-nodegroup-test"
[ℹ]  waiting for the control plane availability...
[✔]  saved kubeconfig as "/Users/brandondoyle/.kube/eksctl/clusters/support-test-30910b16-6818-11eb-a8bc-186590df6e23"
[ℹ]  no tasks
[✔]  all EKS cluster resources for "support-test-30910b16-6818-11eb-a8bc-186590df6e23" have been created
[ℹ]  adding identity "arn:aws:iam::317200895319:role/eksctl-support-test-30910b16-6818-NodeInstanceRole-MIJ6NVV7F35D" to auth ConfigMap
[ℹ]  nodegroup "test" has 0 node(s)
[ℹ]  waiting for at least 2 node(s) to become ready in "test"
[ℹ]  nodegroup "test" has 2 node(s)
[ℹ]  node "ip-192-168-52-218.us-east-2.compute.internal" is ready
[ℹ]  node "ip-192-168-95-8.us-east-2.compute.internal" is ready
[ℹ]  kubectl command should work with "/Users/brandondoyle/.kube/eksctl/clusters/support-test-30910b16-6818-11eb-a8bc-186590df6e23", try 'kubectl --kubeconfig=/Users/brandondoyle/.kube/eksctl/clusters/support-test-30910b16-6818-11eb-a8bc-186590df6e23 get nodes'
[✔]  EKS cluster "support-test-30910b16-6818-11eb-a8bc-186590df6e23" in "us-east-2" region is ready
```
*Delete a cluster*
```shell
$ ./create_cluster.sh -D
Cluster region (defaults to `us-east-2`): 
WARNING: Defaulting to us-east-2
NAME							REGION
support-test-7f6cd7ee-6811-11eb-bf06-186590df6e23	us-east-2
Select a cluster from the above list to delete: support-test-7f6cd7ee-6811-11eb-bf06-186590df6e23
[ℹ]  eksctl version 0.31.0
[ℹ]  using region us-east-2
[ℹ]  deleting EKS cluster "support-test-7f6cd7ee-6811-11eb-bf06-186590df6e23"
[ℹ]  1 task: { delete cluster control plane "support-test-7f6cd7ee-6811-11eb-bf06-186590df6e23" [async] }
[ℹ]  will delete stack "eksctl-support-test-7f6cd7ee-6811-11eb-bf06-186590df6e23-cluster"
[✔]  all cluster resources were deleted
```