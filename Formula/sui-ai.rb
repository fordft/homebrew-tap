class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.11.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.11.4/sui-aarch64-apple-darwin.tar.xz"
      sha256 "7c7927a5fcfab3f8d747129f03a2c846a9c74585506fa507b30f064b32aeb8ba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.11.4/sui-x86_64-apple-darwin.tar.xz"
      sha256 "71b1c4d9cdc2766f3c65caf9145ccc3a25b23b27ff32e79ceb28348c9749ddcb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.11.4/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1cf486e2a975c08af5364560b2a1a3988f3bf4673e15dca580ac84ab3f27b4d7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.11.4/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5e4624130f155a074554ba35272be64d2bf2243512acee5c296adab88ddddf7f"
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
