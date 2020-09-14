class M68kElf < Formula
  desc "M68K GCC Toolchain"
  url "https://ftp.gnu.org/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.xz"
  url "https://ftpmirror.gnu.org/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.xz"
  sha256 "b8dd4368bb9c7f0b98188317ee0254dd8cc99d1e3a18d0ff146c855fe16c1d8c"
  license "GPL-2.0"

  depends_on "gmp"
  depends_on "libmpc"
  depends_on "mpfr"

  resource "binutils" do
    url "https://ftp.gnu.org/gnu/binutils/binutils-2.35.tar.gz"
    mirror "https://ftpmirror.gnu.org/binutils/binutils-2.35.tar.gz"
    sha256 "a3ac62bae4f339855b5449cfa9b49df90c635adbd67ecb8a0e7f3ae86a058da6"
  end  

  resource "newlib" do
    url "ftp://sourceware.org/pub/newlib/newlib-3.3.0.tar.gz"
    sha256 "58dd9e3eaedf519360d92d84205c3deef0b3fc286685d1c562e245914ef72c66"
  end

  def install
    target = "m68k-elf"

    resource("binutils").stage do
      args = %W[
        --prefix=#{prefix}
        --target=#{target}
      ]
      mkdir "build" do
        system "../configure", *args
        system "make"
        system "make", "install"
      end
    end

    ENV.prepend_path "PATH", "#{prefix}/bin"

    args = %W[
      --prefix=#{prefix}
      --target=#{target}
      --with-cpu=m68020
      --disable-multilib
      --enable-lto
      --enable-languages=c
      --without-headers
      --with-newlib
      --disable-shared
      --disable-thread
    ]
    mkdir "build1" do
      system "../configure", *args
      system "make", "all-gcc"
      system "make", "install-gcc"
    end

    resource("newlib").stage do
      args = %W[
        --prefix=#{prefix}
        --target=#{target}
        --with-cpu=m68020
        --disable-multilib
        --disable-newlib-supplied-syscalls
      ]
      mkdir "build" do
        system "../configure", *args
        system "make"
        system "make", "install"
      end
    end

    args = %W[
      --prefix=#{prefix}
      --target=#{target}
      --with-cpu=m68020
      --disable-multilib
      --enable-lto
      --enable-languages=c,c++
      --with-newlib
    ]
    mkdir "build2" do
      system "../configure", *args
      system "make"
      system "make", "install"
    end
  end
end
