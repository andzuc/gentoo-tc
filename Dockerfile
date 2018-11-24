FROM andzuc/gentoo-armqemu
ENV TARGET armv6z-hardfloat-linux-gnueabi

RUN emerge -v sys-devel/crossdev
COPY etc etc
RUN mkdir -p /usr/local/portage-crossdev
RUN chown -R portage:portage /usr/local/portage-crossdev
RUN crossdev --stable \
	     --target ${TARGET} \
       	     --init-target \
	     --ov-output /usr/local/portage-crossdev
RUN crossdev --stable \
	     --target ${TARGET} \
	     --portage "-v" \
       	     --stage4
