#!/bin/sh

CURDIR=$PWD 

cd $1
echo > feeds.conf <<EOF
src-git packages https://git.openwrt.org/feed/packages.git;openwrt-18.06
src-git luci https://git.openwrt.org/project/luci.git;openwrt-18.06
src-git routing https://git.openwrt.org/feed/routing.git;openwrt-18.06
src-git telephony https://git.openwrt.org/feed/telephony.git;openwrt-18.06
EOF

./scripts/feeds update -a && \
rm -vrf $PWD/package/libs/mbedtls \
       $PWD/package/network/services/ipset-dns \
       $PWD/feeds/packages/libs/libev \
       $PWD/feeds/packages/libs/libsodium \
       $PWD/feeds/packages/libs/pcre \
       $PWD/feeds/packages/libs/c-ares \
       $PWD/feeds/packages/net/shadowsocks-libev \
       $PWD/feeds/luci/application/luci-app-shadowsocks-libev && \
tar -C $CURDIR -cf- package | tar -xvf- && \
tar -C $CURDIR -cf- feeds | tar -xvf- && \
./scripts/feeds update -i && \
./scripts/feeds install -a && \
./scripts/feeds install -a 

