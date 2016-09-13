# ciphrtxt-test
FROM ubuntu:14.04

# TODO: Put the maintainer name in the image metadata
MAINTAINER Joseph deBlaquiere <jadeblaquiere@yahoo.com>

# TODO: Rename the builder environment variable to inform users about application you provide them
ENV BUILDER_VERSION 0.1

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="" \
      io.k8s.display-name="ciphrtxt 0.2" \
      io.openshift.expose-services="7754:http,7764/tcp:ctcd" \
      io.openshift.tags="golang,python3,tornado,leveldb"

# TODO: Install required packages here:
RUN echo "installing packages..."
RUN apt-get update -y && apt-get install git golang -y

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./.s2i/bin/ /usr/libexec/s2i

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
RUN chown -R 1001:1001 /opt/app-root

# create a non-priv user
RUN useradd --create-home --user-group --uid 1001 gouser
USER 1001

# TODO: Set the default port for applications built using this image
# EXPOSE 8080

# TODO: Set the default CMD for the image
# CMD ["usage"]

ENV GOPATH /opt/app-root
