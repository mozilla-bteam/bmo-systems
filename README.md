<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#org68b93a4">1. How-To</a>
<ul>
<li><a href="#org95d937b">1.1. Add perl dependencies to BMO</a></li>
<li><a href="#org7bde51c">1.2. Upgrade perl dependencies</a></li>
</ul>
</li>
<li><a href="#org9356a76">2. Configuration</a></li>
<li><a href="#orgc0f281b">3. docker jobs</a>
<ul>
<li><a href="#orgcdb8eb5">3.1. bmo-base</a></li>
<li><a href="#orgad0a113">3.2. bmo-ci</a></li>
<li><a href="#orgaf2d876">3.3. bmo-slim</a></li>
<li><a href="#org355a4de">3.4. docker-centos6</a></li>
<li><a href="#org8436886">3.5. docker-ubuntu14</a></li>
</ul>
</li>
<li><a href="#orgd4b5d2f">4. bundle jobs</a>
<ul>
<li><a href="#orga3a5739">4.1. centos 6 job</a></li>
<li><a href="#org3b14077">4.2. ubuntu 14.04 job</a></li>
<li><a href="#org7134d79">4.3. upload job</a></li>
</ul>
</li>
<li><a href="#orgf73dacc">5. Other pieces of code</a>
<ul>
<li><a href="#org04f9b2e">5.1. build<sub>bundles</sub> steps</a></li>
</ul>
</li>
</ul>
</div>
</div>
bmo-systems repo is responsible for:

1.  generating tarballs of the perl dependencies ("vendor bundles")
2.  uploading the above to an amazon s3 bucket
3.  generating several related docker images


<a id="org68b93a4"></a>

# How-To


<a id="org95d937b"></a>

## Add perl dependencies to BMO

Adding dependencies to BMO (or bugzilla in general) involves adding them to Makefile.PL.
Getting these dependencies deployed to our infrastructure is more complicated.

For each type of bundle we produce, you need to run the docker container mozillabteam/PLATFORM.
Currently PLATFORM is centos6 and ubuntu14.
From inside the container, run the following:

    source /build/env.sh
    git clone --depth 1 https://github.com/mozillabteam/bmo.git
    cd bmo
    cp ../cpanfile.snapshot .
    $PERL Makefile.PL
    make cpanfile GEN_CPANFILE_ARGS="-D bmo"
    $PERL $CARTON install

After that, use 'docker cp' to copy *build/bmo/cpanfile and /build/bmo/cpanfile.snapshot to bundle/PLATFORM* and commit them.


<a id="org7bde51c"></a>

## Upgrade perl dependencies

This is the same as adding a dependency, except instead of "$PERL $CARTON install" you run "$PERL $CARTON upgrade".


<a id="org9356a76"></a>

# Configuration


<a id="orgc0f281b"></a>

# docker jobs

jobs that build docker containers (bmo-base, bmo-ci, etc)


<a id="orgcdb8eb5"></a>

## bmo-base


<a id="orgad0a113"></a>

## bmo-ci


<a id="orgaf2d876"></a>

## bmo-slim


<a id="org355a4de"></a>

## docker-centos6


<a id="org8436886"></a>

## docker-ubuntu14


<a id="orgd4b5d2f"></a>

# bundle jobs

All the jobs below are used to build collections of the perl dependencies that BMO needs.


<a id="orga3a5739"></a>

## centos 6 job

This job creates the 'bmo' bundle, which is for use on centos 6 or RHEL 6 machines.
This is what production, vagrant, CI, and so on use.


<a id="org3b14077"></a>

## ubuntu 14.04 job

This job creates the 'mozreview' bundle, which is used by the version-control-tools bmoweb container.
It is used for mozreview and probably some other systems and is a huge burden that makes me sad.


<a id="org7134d79"></a>

## upload job

This job just collects vendor.tar.gzs from other jobs and uploads them to an amazon S3 bucket.


<a id="orgf73dacc"></a>

# Other pieces of code

Some bits of configuration used in multiple locations


<a id="org04f9b2e"></a>

## build<sub>bundles</sub> steps

The following list of steps are used on all jobs that build vendor tarballs.

