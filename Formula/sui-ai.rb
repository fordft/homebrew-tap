class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.11.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.11.2/sui-aarch64-apple-darwin.tar.xz"
      sha256 "c1814a25b5cab6fc4df3588aa51f48fcf058f4dcce55adf810f968df4f795474"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.11.2/sui-x86_64-apple-darwin.tar.xz"
      sha256 "8b7ad7c6b9a2b107c48ecb658ffce44861caf6f971d49a78750bd4f3a171d05e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.11.2/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "29f968b0ce52591cdda2d0ed30d26a594b990871e3a557cf5e45a10ad3b4d1db"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.11.2/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dc8887df6709f358a3642653544694d7128e94a137543cb7976dc99fe1022bb2"
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
