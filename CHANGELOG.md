## Changelog

This changelog notes important changes with each minor release.

### v0.2

*02/06/2021*

* Ability to add and remove nodegroups.
* Dump the AWS CLI `update-kubeconfig` command to connect to your cluster (must be ran as root).
* Show cluster details, including attached nodegroups.
* Various fixes to make the interface more user-friendly.
  
#### TODOs following this release:
* Identified a problem with gathering node groups on clusters that don't currently have any (cf. `FIXME`s in `eks.sh`). This could be fixed in a later version of `eksctl`, however. I am testing with `v0.31.0`.
* I need to fix the portion about adding additional nodegroups following cluster creation; currently broken.

### v0.1

*02/05/2021*

* Basic EKS cluster creation and deletion in AWS regions.