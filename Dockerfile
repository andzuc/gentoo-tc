FROM andzuc/gentoo-stage3amd64

ENV DOCKER_FEATURES="-sandbox -usersandbox"
ENV DOCKER_TARGET=armv6z-hardfloat-linux-gnueabi

RUN lscpu
RUN echo "MAKEOPTS='-j `lscpu|grep "Thread(s) per core:"|sed 's/^.*: *\(.*\)$/\1/'`'" >>/etc/portage/make.conf
RUN echo "FEATURES='${DOCKER_FEATURES}'" >>/etc/portage/make.conf

RUN emerge -v sys-devel/crossdev
COPY etc etc
RUN mkdir -p /usr/local/portage-crossdev
RUN chown -R portage:portage /usr/local/portage-crossdev
RUN crossdev \
    --stable \
    --target "${DOCKER_TARGET}" \
    --init-target \
    --ov-output /usr/local/portage-crossdev
