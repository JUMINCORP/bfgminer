FROM ubuntu:18.04 as amd

	RUN mkdir /amd

	COPY AMD-APP-SDKInstaller-v3.0.130.136-GA-linux64.tar.bz2 /amd

	RUN \
		apt-get update && \
		apt-get install -y lsb-release && \
		cd /amd && \
		tar -xjvf AMD-APP-SDKInstaller-v3.0.130.136-GA-linux64.tar.bz2 && \
		./AMD-APP-SDK-v3.0.130.136-GA-linux64.sh -- --silent --acceptEULA y


FROM ubuntu:18.04 as builder

	COPY --from=amd /opt/AMDAPPSDK-3.0/include/CL /usr/include
	COPY --from=amd	/opt/AMDAPPSDK-3.0/lib/x86_64/ /usr/lib/x86_64-linux-gnu/
	RUN ldconfig

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

	RUN mkdir /amd

	COPY amdgpu-pro-18.20-673703-ubuntu-18.04.tar.xz /amd

	RUN \
		cd /amd && \
		apt-get update && \
		apt-get install -y xz-utils && \
		tar --strip-components=1 -xJvf amdgpu-pro-18.20-673703-ubuntu-18.04.tar.xz && \
		./amdgpu-install -y --opencl=legacy --headless && \
		ln -s /opt/amdgpu-pro/bin/clinfo /usr/bin && \
		ln -s /opt/amdgpu-pro/lib/x86_64-linux-gnu/* /usr/lib/x86_64-linux-gnu/ && \
		ldconfig && \
		apt-get update && \
		apt-get install -y libdrm-amdgpu1

	RUN mkdir /bfg
	WORKDIR /bfg
	COPY --from=builder /bfg/bfgminer .
	COPY --from=builder /bfg/libbase58/.libs ./libbase58/.libs
	COPY --from=builder /bfg/libblkmaker/.libs ./libblkmaker/.libs
	COPY --from=builder /bfg/opencl ./opencl

	RUN \
		apt-get update && \
		apt-get install -y libjansson-dev libcurl4-gnutls-dev libmicrohttpd-dev libevent-pthreads-2.1-6

# vim: ts=4:sw=4
