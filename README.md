### EKS CLI wrapper

#### Synopsis

```shell
$ ./cluster.sh -h
Usage: ./cluster.sh { -h help | -c create a cluster | -d dry run | -D delete a cluster | -a add node group to existing cluster | -r remove node group from existing cluster | -g get kubeconfig command | -s show cluster and cluster nodegroups }
```

This tool is meant to aid Support/SEs in creating and deleting (VERY simple) EKS clusters for testing purposes. Most flags are left to the defaults as of this release.

> **WARNING:** do not put spaces, underscores (`_`) or periods (`.`) in any of these input fields (dashes `-` are okay, however). Chances are, it will end up costing you a lot of time before `eksctl` errors out.

If you wish to add additional configuration options (cf. `eksctl -h`, or `eksctl create cluster -h` for further 
information), you may pass a `-d` (dry run) flag to the script to dump the command to `stdout` for further 
modification or review.
```shell
$ ./cluster.sh -d
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
Nodegroup name (default `test`, no duplicates): 
WARNING: Defaulting to test
Nodegroup labels (default `env=test`; must be in format key1=val1,key2=val2): env=test,agent=2-3-1

Dry run output:

eksctl create cluster --name brandon-test --tags "Owner=Brandon" --region us-east-2 --version 1.18 --timeout "60m0s" --nodegroup-name test --node-type t3.medium --nodes-min 2 --nodes-max 3 --node-volume-size 80 --node-labels "env=test,agent=2-3-1" --full-ecr-access --asg-access --alb-ingress-access --auto-kubeconfig

```

#### Prerequisites

This script is intended to be executed with `bash` and requires `ossp-uuid` (Mac, or `uuid` on Linux), a working `eksctl` installation (>= v0.31.0), and the AWS CLI. Refer to the [AWS
docs](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html) to install the latter utilities.

#### Examples

Because output can be rather extensive, I've opted to link to various examples to take you through a cluster's lifecycle ~

* [Creating a cluster](examples/create_cluster.md)
* [Adding a nodegroup](examples/add_nodegroup.md)
* [Deploying an application](examples/deploy_application.md)
* [Removing a nodegroup](examples/remove_nodegroup.md)
* [Deleting a cluster](examples/delete_cluster.md)

#### Updates

See the [Changelog](CHANGELOG.md) for fixes and updates by version.