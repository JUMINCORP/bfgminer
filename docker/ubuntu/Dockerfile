FROM ubuntu:18.04 as builder

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


	RUN \
		apt-get update && \
		apt-get install -y build-essential autoconf automake \
		libtool pkg-config libcurl4-gnutls-dev \
		libjansson-dev uthash-dev libncursesw5-dev \
		libudev-dev libusb-1.0-0-dev libevent-dev \
		libmicrohttpd-dev libhidapi-dev

	RUN \
		apt-get install -y git && \
		git clone https://github.com/Equibit/bfgminer.git /bfg && \
		cd /bfg && \
		./autogen.sh && \
		./configure --without-curses --enable-keccak --disable-sha256d --enable-opencl --disable-oth && \
		make V=0



FROM ubuntu:18.04 as runner

	RUN mkdir /bfg
	WORKDIR /bfg

	RUN find /opt
	#COPY --from=builder /opt/amdgpu-pro/bin/ /usr/bin/
	#COPY --from=builder /opt/amdgpu-pro/lib/x86_64-linux-gnu/ /usr/lib/
	#COPY --from=builder /etc/OpenCL/ /etc/OpenCL/

	RUN find /usr/lib

	COPY amd/10-amdgpu-pro.conf /etc/ld.so.conf.d/
	RUN ldconfig

	COPY scripts/bfg .

	COPY --from=builder /bfg/bfgminer .
	COPY --from=builder /bfg/libbase58/.libs ./libbase58/.libs
	COPY --from=builder /bfg/libblkmaker/.libs ./libblkmaker/.libs
	COPY --from=builder /bfg/opencl ./opencl

	RUN \
		apt-get update && \
		apt-get install -y libjansson-dev libcurl4-gnutls-dev libmicrohttpd-dev libevent-pthreads-2.1-6 libdrm-amdgpu1 strace gdb clinfo

# vim: ts=4:sw=4
