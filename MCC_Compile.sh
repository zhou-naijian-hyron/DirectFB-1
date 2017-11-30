#!/bin/sh
CWD=$(pwd)
LOGFILE=${CWD}/makelog.txt

# Hi3536
CROSS=arm-hisiv400-linux-

# setup cross tools
export CC=${CROSS}gcc CXX=${CROSS}g++ LD=${CROSS}ld AR=${CROSS}ar RANLIB=${CROSS}ranlib STRIP=${CROSS}strip
export CFLAGS='-march=armv7-a -mfloat-abi=softfp -mfpu=neon-vfpv4 -mno-unaligned-access -fno-aggressive-loop-optimizations'
export CXXFlAGS='-march=armv7-a -mfloat-abi=softfp -mfpu=neon-vfpv4 -mno-unaligned-access -fno-aggressive-loop-optimizations'
# freetype support
export FREETYPE_CFLAGS="-I/home/mcc/git/G2NVR_root/install/include/freetype2"
export FREETYPE_LIBS="-L/home/mcc/git/G2NVR_root/install/lib -lfreetype"

#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/hisi-linux/x86-arm/arm-hisiv400-linux/arm-hisiv400-linux-gnueabi/lib
#export LDFLAGS='-L/opt/hisi-linux/x86-arm/arm-hisiv400-linux/target/lib'
#export LIBS='-ldl'

[ -f ${LOGFILE} ] && rm ${LOGFILE}

date
echo -n "configure ..."

./configure --host=arm-linux --prefix=/home/mcc/directFB \
				--with-gfxdrivers=none \
				--with-inputdrivers=none \
				--disable-png \
				--disable-jpeg \
				--disable-zlib \
				--disable-x11 \
				--enable-sdl=no \
				--enable-gif=no \
				--enable-multicore \
				--enable-multi-kernel >> ${LOGFILE} 2>&1

date
echo -n "compiling ..."
# make
make >> ${LOGFILE} 2>&1
[ $? != 0 ] && exit

date
echo -n "Installing..."

# install
make install >> ${LOGFILE} 2>&1
date
