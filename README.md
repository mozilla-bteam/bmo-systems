<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#org3a06ac4">1. How-To</a>
<ul>
<li><a href="#org9680f18">1.1. Add perl dependencies to BMO</a></li>
<li><a href="#orgc03bb40">1.2. Upgrade perl dependencies</a></li>
</ul>
</li>
<li><a href="#org01e4ec3">2. Configuration</a></li>
<li><a href="#org20035cc">3. docker jobs</a>
<ul>
<li><a href="#org27341b4">3.1. bmo-base</a></li>
<li><a href="#org0acc5d2">3.2. bmo-ci</a></li>
<li><a href="#orgc16a5b5">3.3. bmo-slim</a></li>
</ul>
</li>
<li><a href="#orgeb2d450">4. bundle jobs</a>
<ul>
<li><a href="#org69a5b1b">4.1. centos 6 job</a></li>
<li><a href="#org6432376">4.2. ubuntu 14.04 job</a></li>
<li><a href="#org8906005">4.3. upload job</a></li>
</ul>
</li>
<li><a href="#org98724c6">5. Other pieces of code</a>
<ul>
<li><a href="#org79909d9">5.1. build<sub>bundles</sub> steps</a></li>
<li><a href="#org953f99f">5.2. build<sub>bundles</sub> environmental variables</a></li>
<li><a href="#org95cb4d7">5.3. docker build / push stanza</a></li>
</ul>
</li>
</ul>
</div>
</div>
bmo-systems repo is responsible for:

1.  generating tarballs of the perl dependencies ("vendor bundles")
2.  uploading the above to an amazon s3 bucket
3.  generating several related docker images


<a id="org3a06ac4"></a>

# How-To


<a id="org9680f18"></a>

## Add perl dependencies to BMO

Adding dependencies to BMO (or bugzilla in general) involves adding them to Makefile.PL.
Getting these dependencies deployed to our infrastructure is more complicated.

You will need (at least) a centos 6 install, and an ubuntu 14.04 install. On
each, you will want to checkout the BMO code and an unpacked copy of the
vendor tarball for that platform.

    perl Makefile.PL
    make cpanfile GEN_CPANFILE_ARGS="-D bmo"
    carton install

After this, file cpanfile and cpanfile.snapshot should be added to bundle/PLATFORM/ and those changes commited.


<a id="orgc03bb40"></a>

## Upgrade perl dependencies

This is the same as adding a dependency, except instead of "carton install" you run "carton upgrade".


<a id="org01e4ec3"></a>

# Configuration


<a id="org20035cc"></a>

# docker jobs

jobs that build docker containers (bmo-base, bmo-ci, etc)


<a id="org27341b4"></a>

## bmo-base


<a id="org0acc5d2"></a>

## bmo-ci


<a id="orgc16a5b5"></a>

## bmo-slim


<a id="orgeb2d450"></a>

# bundle jobs

All the jobs below are used to build collections of the perl dependencies that BMO needs.


<a id="org69a5b1b"></a>

## centos 6 job

This job creates the 'bmo' bundle, which is for use on centos 6 or RHEL 6 machines.
This is what production, vagrant, CI, and so on use.


<a id="org6432376"></a>

## ubuntu 14.04 job

This job creates the 'mozreview' bundle, which is used by the version-control-tools bmoweb container.
It is used for mozreview and probably some other systems and is a huge burden that makes me sad.


<a id="org8906005"></a>

## upload job

This job just collects vendor.tar.gzs from other jobs and uploads them to an amazon S3 bucket.


<a id="org98724c6"></a>

# Other pieces of code

Some bits of configuration used in multiple locations


<a id="org79909d9"></a>

## build<sub>bundles</sub> steps

The following list of steps are used on all jobs that build vendor tarballs.


<a id="org953f99f"></a>

## build<sub>bundles</sub> environmental variables

the following block are used as default environmental variables for the jobs where bundles are built.


<a id="org95cb4d7"></a>

## docker build / push stanza

