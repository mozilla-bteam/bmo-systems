- [How-To](#org46222a5)
  - [Add perl dependencies to BMO](#orgc0b3968)
  - [Upgrade perl dependencies](#org1c70e6d)
  - [Make a new release of bmo-slim](#orgf7f04d6)
- [Configuration](#org7db10a6)
- [docker jobs](#org08bf005)
  - [bmo-slim](#org0b54b47)
  - [docker-centos6](#orga08f0c4)
  - [docker-ubuntu14](#orgba02448)
- [bundle jobs](#orgb13321b)
  - [centos 6 job](#org2c5304b)
  - [ubuntu 14.04 job](#org6681a8f)
  - [upload job](#org04ed59f)
- [Other pieces of code](#org99f6e5d)
  - [build<sub>bundles</sub> steps](#org307d300)

bmo-systems repo is responsible for:

1.  generating tarballs of the perl dependencies ("vendor bundles")
2.  uploading the above to an amazon s3 bucket
3.  generating several related docker images


<a id="org46222a5"></a>

# How-To


<a id="orgc0b3968"></a>

## Add perl dependencies to BMO

Adding dependencies to BMO (or bugzilla in general) involves adding them to Makefile.PL.

Assuming you have the modified Makefile.PL on a branch of a particular user, you can use "make" to get the updated cpanfile and cpanfile.snapshot files.

The example below is how we added some extra dependencies.

```bash
make BRANCH=report-ping-simple-docid REPO=dylanwh/bmo all
```

Typically if any dependencies are removed in this step, it means they're improperly specified in Makefile.PL. You'll want to figure out if they're really needed or not.


Commit the updated cpanfile and cpanfile.snapshot -- but review the changes carefully!


<a id="org1c70e6d"></a>

## Upgrade perl dependencies

This is the same as adding a dependency.

Commit the updated cpanfile and cpanfile.snapshot -- but review the changes carefully!


<a id="orgf7f04d6"></a>

## Make a new release of bmo-slim

You need to tag releases of bmo-slim after updating or adding any dependency.

CircleCI will build all pushes the master branch (and it ignores all others). If all the jobs are passing and complete, execute the following:

```bash
   docker pull mozillabteam/bmo-slim:latest
   docker tag mozillabteam/bmo-slim:latest mozillabteam/bmo-slim:$(date date +%Y%m%d.1)
   docker push mozillabteam/bmo-slim:$(date +%Y%m%d.1)
```

Afterwards, update the image in Dockerfile and .circleci/config.yml in <https://github.com/mozilla-bteam/bmo>


<a id="org7db10a6"></a>

# Configuration


<a id="org08bf005"></a>

# docker jobs

jobs that build docker containers


<a id="org0b54b47"></a>

## bmo-slim


<a id="orga08f0c4"></a>

## docker-centos6


<a id="orgba02448"></a>

## docker-ubuntu14


<a id="orgb13321b"></a>

# bundle jobs

All the jobs below are used to build collections of the perl dependencies that BMO needs.


<a id="org2c5304b"></a>

## centos 6 job

This job creates the 'bmo' bundle, which is for use on centos 6 or RHEL 6 machines. This is what production, vagrant, CI, and so on use.


<a id="org6681a8f"></a>

## ubuntu 14.04 job

This job creates the 'mozreview' bundle, which is used by the version-control-tools bmoweb container. It is used for mozreview and probably some other systems and is a huge burden that makes me sad.


<a id="org04ed59f"></a>

## upload job

This job just collects vendor.tar.gzs from other jobs and uploads them to an amazon S3 bucket.


<a id="org99f6e5d"></a>

# Other pieces of code

Some bits of configuration used in multiple locations


<a id="org307d300"></a>

## build<sub>bundles</sub> steps

The following list of steps are used on all jobs that build vendor tarballs.
