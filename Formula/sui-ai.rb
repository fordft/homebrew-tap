class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.3.1/sui-aarch64-apple-darwin.tar.xz"
      sha256 "3d6206ccc0d2a7848650f21ed3a197d7e94da139d3541f8abf53116b7cfe6c5d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.3.1/sui-x86_64-apple-darwin.tar.xz"
      sha256 "4c39790bf96b37700667b6829b31af6ca5434a16742209e9836d834cde8c3346"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.3.1/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "279367aaaed6bb5f75f926bc71fa4202534fd82729494f99bce4dbcb21175777"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.3.1/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d2fa70dc7f6072dfb392a2b7798155ce4713041715177b8c11d87a87d16a8efc"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "sui", "sui-certify", "sui-mission"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "sui", "sui-certify", "sui-mission"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "sui", "sui-certify", "sui-mission"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "sui", "sui-certify", "sui-mission"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
