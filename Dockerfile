############################################################
# Dockerfile to build Adaptec storman (MaxView) container
# Based on Centos 6
# Start resulting image as privileged contained, e.g.:
# docker run -d --privileged --user root --name storman -p 8443:8443 storman
# 
# This container is based on Centos 6, because the agent/cimserver doesn't seem to work properly in Centos 7.
# However, the install scripts contain some Centos 7 specific commands (e.g. the service command), which cause some error messages.
# The resulting container seems to work fine, I will try to fix the error messages at a later time.
############################################################
FROM centos:6
MAINTAINER Nick Heinemans (nick@hostlogic.nl)
ENV JAVA_HOME /usr/StorMan/jre
RUN yum install -y perl unzip tar sysvinit-tools\
&& echo "root:root" | chpasswd \
&& curl -s http://download.adaptec.com/raid/storage_manager/msm_linux_x64_v2_00_21811.tgz | tar -zx -C /tmp \
&& /tmp/manager/StorMan-2.00-21811.x86_64.bin --silent root root \
&& mv /tmp/cmdline/arcconf/arcconf /bin/ \
&& rm -Rf /tmp/* \
&& yum clean all
ENTRYPOINT /etc/init.d/stor_agent start && /etc/init.d/stor_cimserver start && /usr/StorMan/apache-tomcat-7.0.26/bin/catalina.sh run
