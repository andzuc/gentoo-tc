FROM andzuc/gentoo-stage3amd64

ENV HOST_FEATURES="-sandbox -usersandbox"
ENV TC_TARGET=avr

RUN lscpu
RUN echo "MAKEOPTS='-j `lscpu|grep "Thread(s) per core:"|sed 's/^.*: *\(.*\)$/\1/'`'" >>/etc/portage/make.conf
RUN echo "FEATURES='${HOST_FEATURES}'" >>/etc/portage/make.conf

COPY portage/package.use /etc/portage/package.use

# emerging:
RUN time emerge -v \
    sys-devel/crossdev \
    dev-embedded/avrdude

COPY portage/repos.conf /etc/portage/repos.conf
RUN mkdir -p /usr/local/portage-crossdev/{profiles,metadata} \
    && echo 'crossdev' > /usr/local/portage-crossdev/profiles/repo_name \
    && echo 'masters = gentoo' > /usr/local/portage-crossdev/metadata/layout.conf \
    && chown -R portage:portage /usr/local/portage-crossdev
RUN time crossdev \
    --stable \
    --target "${TC_TARGET}" \
    --ov-output /usr/local/portage-crossdev
