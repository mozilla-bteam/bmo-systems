FROM centos:6.9
MAINTAINER Dylan William Hardison <dylan@mozilla.com>

RUN yum update -y && \
    yum install -y perl perl-core mod_perl httpd wget tar openssl mysql-libs gd && \
    curl -L https://cpanmin.us > /usr/local/bin/cpanm && \
    chmod 755 /usr/local/bin/cpanm && \
    mkdir -p /opt/bmo/build && \
    rpm -qa > /tmp/rpms.list && \
    yum install -y gcc mod_perl-devel && \
    cpanm -l /opt/bmo/build --notest Apache2::SizeLimit && \
    yum erase -y $(rpm -qa | diff -u - /tmp/rpms.list | sed -n '/^-[^-]/ s/^-//p') && \
    rm -rf /opt/bmo/build/lib/perl5/{CPAN,Parse,JSON,ExtUtils} && \
    mkdir /usr/local/share/perl5 && \
    mv /opt/bmo/build/lib/perl5/x86_64-linux-thread-multi/ /usr/local/lib64/perl5/ && \
    mv /opt/bmo/build/lib/perl5/Linux /usr/local/share/perl5/ && \
    rm -vfr /opt/bmo/build && \
    rm /tmp/rpms.list /usr/local/bin/cpanm && \
    yum clean all -y && \
    useradd -u 10001 -U app -m && \
    mkdir /app

COPY bmo/ /opt/bmo/

RUN awk '{print $1}' < /app/LIBS.txt \
         | perl -nE 'chomp; unless (-f $_) { $missing++; say $_ } END { exit 1 if $missing }' && \
    chown -R app:app /app /opt/bmo
