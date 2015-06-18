############################################################
# Dockerfile to build Adaptec storman (MaxView) container
# Based on Centos 6
# Start resulting image as privileged contained, e.g.:
# docker run -d --privileged --user root --name storman -p 8443:8443 storman
############################################################
FROM centos:6
MAINTAINER Nick Heinemans (nick@hostlogic.nl)
ENV JAVA_HOME /usr/StorMan/jre
RUN yum install -y perl unzip tar net-tools \
&& yum clean all
RUN echo "root:root" | chpasswd
RUN curl -s http://download.adaptec.com/raid/storage_manager/msm_linux_x64_v1_08_21375.tgz | tar -zx -C /tmp \
&& /tmp/manager/StorMan-1.08-21375.x86_64.bin --silent root root \
&& mv /tmp/cmdline/arcconf/arcconf /bin/ \
&& rm -Rf /tmp/* \
&& yum clean all
ENTRYPOINT /etc/init.d/stor_agent start && /etc/init.d/stor_cimserver start && /usr/StorMan/apache-tomcat-7.0.26/bin/catalina.sh run
