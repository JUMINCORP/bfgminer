FROM ubuntu:18.04 as builder

{% if target == "amd" %}
	RUN mkdir /amd
	COPY amdgpu-pro*.tar.xz /amd

	RUN \
		cd /amd && \
		apt-get update && \
		apt-get install -y xz-utils && \
		tar --strip-components=1 -xJvf amdgpu-pro-*.tar.xz && \
		./amdgpu-install -y --opencl=legacy --headless && \
		apt-get update && \
		apt-get install -y opencl-amdgpu-pro-dev libopencl1-amdgpu-pro opencl-amdgpu-pro-icd && \
		ln -s /opt/amdgpu-pro/bin/clinfo /usr/bin && \
		ln -s /opt/amdgpu-pro/lib/x86_64-linux-gnu/* /usr/lib/x86_64-linux-gnu/ && \
		ldconfig && \
		find /opt/amdgpu-pro && \
		ldconfig -p | grep libamd
{% endif %}

	RUN \
		apt-get update && \
		apt-get install -y build-essential autoconf automake \
		libtool pkg-config libcurl4-gnutls-dev \
		libjansson-dev uthash-dev libncursesw5-dev \
		libudev-dev libusb-1.0-0-dev libevent-dev \
		libmicrohttpd-dev libhidapi-dev

	RUN \
		apt-get install -y devscripts debhelper libsensors4-dev yasm wget quilt

	RUN \
		apt-get install -y git && \
		git clone https://github.com/Equibit/bfgminer.git /bfg
		# && \
		#cd /bfg && \
		#./autogen.sh && \
		#./configure --without-curses --enable-keccak --disable-sha256d {% if target == "amd" %} --enable-opencl {% endif %} {% if target == "cpu" %} --enable-cpumining {% endif %} --disable-other-drivers && \
		#make V=0

	COPY debian-*.patch /bfg/debian/
	RUN \
		cd /bfg/debian && \
		patch control < debian-control.patch && \
		patch rules < debian-rules.patch && \
		cd /bfg && \
		DEB_BUILD_OPTIONS=nocheck debuild -us -uc -b && \
		echo RETURN_CODE :: $? && \
		find / -name "bfgminer*" && \
		ldd /bfg/bfgminer


FROM ubuntu:18.04 as runner

	
{% if target == "amd" %}
	RUN mkdir /deb
	COPY --from=builder /*.deb /deb
{% endif %}

	RUN mkdir /bfg
	WORKDIR /bfg

{% if target == "amd" %}
	COPY amd/10-amdgpu-pro.conf /etc/ld.so.conf.d/
	RUN ldconfig
{% endif %}

	COPY scripts/bfg .

	COPY --from=builder /bfg/bfgminer .
	COPY --from=builder /bfg/libbase58/.libs ./libbase58/.libs
	COPY --from=builder /bfg/libblkmaker/.libs ./libblkmaker/.libs

COPY --from=builder /bfg/opencl ./opencl

	RUN \
		apt-get update && \
		apt-get install -y libjansson-dev libsensors4-dev libcurl4-gnutls-dev libmicrohttpd-dev libevent-pthreads-2.1-6 {% if target == "amd" %} libdrm-amdgpu1 {% endif %} strace gdb clinfo

	ENTRYPOINT ["/bfg/bfg"]

# vim: ts=4:sw=4
