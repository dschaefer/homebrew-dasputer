class NextpnrEcp5 < Formula
    desc "portable FPGA place-and-route tool"
    homepage "https://github.com/YosysHQ/nextpnr"
    url "https://github.com/YosysHQ/nextpnr/archive/refs/tags/nextpnr-0.7.tar.gz"
    head "https://github.com/YosysHQ/nextpnr.git"
  
    depends_on "cmake" => :build
    depends_on "pkg-config" => :build
    depends_on "eigen" => :build
    depends_on "python"
    depends_on "boost"
    depends_on "boost-python3"
    depends_on "qt5"
    depends_on "prjtrellis"
  
    def install
      system "cmake", "-DARCH=ecp5", "-DTRELLIS_INSTALL_PREFIX=#{HOMEBREW_PREFIX}", \
         ".", *std_cmake_args, "-DBoost_NO_BOOST_CMAKE=on", "-DBUILD_TESTS=OFF"
      system "make", "install"
    end
  
  end
