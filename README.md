### `eksctl` CLI wrapper

This tool is meant to aid Support in creating and deleting (simple) EKS clusters for test environments.

#### Prerequisites

This script requires `ossp-uuid` (Mac, or `uuid` on Linux), as well as a working `eksctl` installation. Refer to the [AWS
docs](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html) to install this utility.

#### Examples

```text
$ ./create_cluster.sh 
Cluster name:
```