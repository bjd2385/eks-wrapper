## Changelog

This changelog notes important changes with each minor release.

### v1.0.0

*08/08/2021*

* Added automations to generate releases and docker image builds.

### v0.4.1

*02/08/2021*

* Fixed synopsis in README.

### v0.4

*02/08/2021*

* Resolved the fact that later versions of `eksctl` seem to add additional verbosity on versioning.
* Fixed `Usage:` string to show that only one flag can be passed in at a time.
* Minor code readability fixes.

### v0.3

*02/07/2021*

* Found that the problem with gathering node groups on clusters that don't currently have any was fixed in a later
  `eksctl` version than 0.31.0 (tested with v0.37.0, the latest). Will keep these fixes in-place, however, for those
  using an earlier `eksctl` version.
* Fixed the portion about adding additional nodegroups following cluster creation. Was formerly broken. Now you may add as many nodegroups as you would like while building a cluster.

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
