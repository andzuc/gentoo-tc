FROM andzuc/gentoo-stage3amd64

ENV HOST_FEATURES="-sandbox -usersandbox"
ENV TC_TARGET=armv6z-hardfloat-linux-gnueabi

RUN lscpu
RUN echo "MAKEOPTS='-j `lscpu|grep "Thread(s) per core:"|sed 's/^.*: *\(.*\)$/\1/'`'" >>/etc/portage/make.conf
RUN echo "FEATURES='${HOST_FEATURES}'" >>/etc/portage/make.conf

# emerging:
# - crossdev: to further build the toolchain
# - go: used to compile resin-xbuild.go from https://github.com/balena-io-library/armv7hf-debian-qemu
RUN time emerge -v \
    sys-devel/crossdev \
    dev-lang/go

COPY etc etc
RUN mkdir -p /usr/local/portage-crossdev
RUN chown -R portage:portage /usr/local/portage-crossdev
RUN crossdev \
    --stable \
    --target "${TC_TARGET}" \
    --init-target \
    --ov-output /usr/local/portage-crossdev
