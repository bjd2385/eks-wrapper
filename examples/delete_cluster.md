### Deleting a cluster

```shell
$ ./cluster.sh -D
Cluster region (defaults to `us-east-2`): 
WARNING: Defaulting to us-east-2
NAME		REGION
brandon-test	us-east-2
Select a cluster from the above list to delete: brandon-test

Starting delete of cluster brandon-test

[ℹ]  eksctl version 0.31.0
[ℹ]  using region us-east-2
[ℹ]  deleting EKS cluster "brandon-test"
[ℹ]  deleted 0 Fargate profile(s)
[ℹ]  cleaning up AWS load balancers created by Kubernetes objects of Kind Service or Ingress
[ℹ]  2 sequential tasks: { 2 parallel sub-tasks: { delete nodegroup "test2", delete nodegroup "test" }, delete cluster control plane "brandon-test" [async] }
[ℹ]  will delete stack "eksctl-brandon-test-nodegroup-test"
[ℹ]  waiting for stack "eksctl-brandon-test-nodegroup-test" to get deleted
[ℹ]  will delete stack "eksctl-brandon-test-nodegroup-test2"
[ℹ]  waiting for stack "eksctl-brandon-test-nodegroup-test2" to get deleted
[ℹ]  will delete stack "eksctl-brandon-test-cluster"
[✔]  all cluster resources were deleted
.................................................................................................................................................................................... should be good to go now!
```