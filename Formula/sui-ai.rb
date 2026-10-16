class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.12.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.12.3/sui-aarch64-apple-darwin.tar.xz"
      sha256 "a7d0dacb033c924e9da60339ec53775c038b9f0f2de004354f4a2d6d22ca7c4a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.12.3/sui-x86_64-apple-darwin.tar.xz"
      sha256 "0ad3dfb24bc93c901037ef4e1be31db9b39e6718a3a608c19249a88f6013d5cc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.12.3/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b3e9bdee8eceb6e452de901f275bf28fb3b8801914fdd62bc44f9727e3836956"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.12.3/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7067d86eecc8fec68970ee5c43d1a7554ac84848505a837daf6ec38a74b74b12"
    end
  end
  license "MIT"

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
