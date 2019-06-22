NPROCS=1

while getopts j: option
do
case "${option}"
in
j) NPROCS=${OPTARG};;
esac
done

echo "==========================="
echo "Using ${NPROCS} threads."
echo "==========================="

# Upgrade Ubuntu components
apt update
apt upgrade -y

# gRPC
# https://github.com/grpc/grpc/tree/master/src/cpp
# https://github.com/grpc/grpc/blob/master/BUILDING.md
cd /tmp
apt-get install -y git curl
apt-get install -y build-essential autoconf libtool pkg-config
apt-get install -y libgflags-dev libgtest-dev
apt-get install -y clang libc++-dev
git clone -b $(curl -L https://grpc.io/release) https://github.com/grpc/grpc
cd grpc
git submodule update --init
make -j${NPROCS}
# WARNING: After installing with make install there is no easy way to uninstall, which can cause issues if you later want to remove the grpc and/or protobuf installation or upgrade to a newer version.
make install
ldconfig # Refresh shared library cache.

# Protobuf
# The latest Protobuf might not be compatible with gRPC
# We always install the protobuf included in gRPC
cd /tmp/grpc/third_party/protobuf
make -j${NPROCS}
make install
ldconfig # Refresh shared library cache.

# CMake
cd /tmp
git clone https://github.com/Kitware/CMake.git
cd CMake
./bootstrap --parallel=${NPROCS}
make -j${NPROCS}
make install