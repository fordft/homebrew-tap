class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.3.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.3.4/sui-aarch64-apple-darwin.tar.xz"
      sha256 "ada5af1311719061e2ba38a9319f3cc69ac44cb1144dee504934abab5e641ce3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.3.4/sui-x86_64-apple-darwin.tar.xz"
      sha256 "a217deb4da3140848f567e7259b101f3f5d17277e16d1ee9bea5f5af76f55e87"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.3.4/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a96fc8289bc83f26a1a7a5430f96e300f285afef4abc838dddf2d4abda55ec04"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.3.4/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b70fcaf9091e07a8871d99ee82fa636a29cf2bd4b04b0a3dbae992c77a664320"
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
