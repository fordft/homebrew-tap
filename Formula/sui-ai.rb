class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.4.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.4.5/sui-aarch64-apple-darwin.tar.xz"
      sha256 "532caed985b05af7f0bf5875a741cfac35caa286073e0c89a9ce284e338f8a88"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.4.5/sui-x86_64-apple-darwin.tar.xz"
      sha256 "7765523f4e28196babae0d839de2a765f80ebaabcbeae8e6b7abc481edeada66"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.4.5/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bccdf041150594811965b8b2710f39ed67b69ebd0fb149c463a37a2bf07874dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.4.5/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6e2ca5379e2f5d499b6360f06ae14c7080df2e5fdca7e0ab04cd86817c7d845a"
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
