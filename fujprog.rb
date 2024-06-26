class Fujprog < Formula
    desc "FPGA ULX2S / ULX3S JTAG programmer"
    homepage "https://github.com/kost/fujprog"
    url "https://github.com/kost/fujprog/archive/refs/tags/v4.8.tar.gz"
    head "https://github.com/kost/fujprog.git"
  
    depends_on "cmake"
    depends_on "pkg-config"
    depends_on "libftdi"
    depends_on "libusb"
    depends_on "libusb-compat"
  
    def install
      system "cmake", ".", *std_cmake_args
      system "make", "install"
    end
  
  end