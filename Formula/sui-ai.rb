class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.11.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.11.5/sui-aarch64-apple-darwin.tar.xz"
      sha256 "05276f6ef7a74758216de63a47e227e25cb20621d428892dcff4248f2c1ec705"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.11.5/sui-x86_64-apple-darwin.tar.xz"
      sha256 "24854a8bbba39939298f103ac6f7dfded4e1f1aa59cb6cebc590fd11b9eee90d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.11.5/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1012589aa469de722492a36e9075ffb6a7ea31dbdc737c8f81a2bb9660cbcd80"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.11.5/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5b9eac7ce26b3fc4888c2c1be37ad2a049473c280ab87ae9b89c3b03dfa952c8"
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
