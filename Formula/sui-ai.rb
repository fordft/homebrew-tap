class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.6.0/sui-aarch64-apple-darwin.tar.xz"
      sha256 "fdd21b499921ad6798f3f6fbeb835698b4f213f5a4523289b8ac7c8c0e62f9dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.6.0/sui-x86_64-apple-darwin.tar.xz"
      sha256 "4c886e47d5f68cc319ef355484c4d777e88ad5cfc309d81b44eff66eb1a625dd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.6.0/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3cd578c09f55d8bc891ef4843053e773be7b93b161c0a8f4e49845c5473af0ca"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.6.0/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a5f485ff5f5b0def8a7a9c35e6b7935d0fbc63622b8a2d4da083b634de56a906"
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
