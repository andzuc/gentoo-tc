FROM andzuc/gentoo-stage3amd64

ENV HOST_FEATURES="-sandbox -usersandbox"
ENV TC_TARGET=armv6z-hardfloat-linux-gnueabi

RUN lscpu
RUN echo "MAKEOPTS='-j `lscpu|grep "Thread(s) per core:"|sed 's/^.*: *\(.*\)$/\1/'`'" >>/etc/portage/make.conf
RUN echo "FEATURES='${HOST_FEATURES}'" >>/etc/portage/make.conf

COPY portage/package.use /etc/portage/package.use

# emerging:
# - go: used to compile resin-xbuild.go from https://github.com/balena-io-library/armv7hf-debian-qemu
# - crossdev: to further build the toolchain
RUN time emerge -v \
    dev-vcs/git \
    dev-lang/go \
    sys-devel/crossdev

COPY portage/repos.conf /etc/portage/repos.conf
RUN mkdir -p /usr/local/portage-crossdev \
    && chown -R portage:portage /usr/local/portage-crossdev \
    && crossdev \
	   --stable \
	   --target "${TC_TARGET}" \
	   --init-target \
	   --ov-output /usr/local/portage-crossdev
