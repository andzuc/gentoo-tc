FROM andzuc/gentoo-armqemu

ENV TARGET armv6z-hardfloat-linux-gnueabi
RUN lscpu
RUN echo "MAKEOPTS='-j `lscpu|grep "Thread(s) per core:"|sed 's/^.*: *\(.*\)$/\1/'`'" >>/etc/portage/make.conf

RUN emerge -v sys-devel/crossdev
COPY etc etc
RUN mkdir -p /usr/local/portage-crossdev
RUN chown -R portage:portage /usr/local/portage-crossdev
RUN crossdev \
    --stable \
    --target ${TARGET} \
    --init-target \
    --ov-output /usr/local/portage-crossdev
