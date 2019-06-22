# Upgrade Ubuntu components
sudo apt update
sudo apt upgrade -y

# gRPC
# https://github.com/grpc/grpc/tree/master/src/cpp
# https://github.com/grpc/grpc/blob/master/BUILDING.md
cd /tmp
sudo apt-get install -y build-essential autoconf libtool pkg-config
sudo apt-get install -y libgflags-dev libgtest-dev
sudo apt-get install -y clang libc++-dev
git clone -b $(curl -L https://grpc.io/release) https://github.com/grpc/grpc
cd grpc
git submodule update --init
make # make -j16
# WARNING: After installing with make install there is no easy way to uninstall, which can cause issues if you later want to remove the grpc and/or protobuf installation or upgrade to a newer version.
sudo make install
sudo ldconfig # Refresh shared library cache.

# Protobuf
# The latest Protobuf might not be compatible with gRPC
# We always install the protobuf included in gRPC
cd /tmp/grpc/third_party/protobuf
make # make -j16
sudo make install
sudo ldconfig # Refresh shared library cache.

# CMake
cd /tmp
sudo apt-get install -y git
git clone https://github.com/Kitware/CMake.git
cd CMake
./bootstrap # ./bootstrap --parallel=16
make # make -j16
sudo make install