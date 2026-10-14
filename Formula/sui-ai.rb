class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.11.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.11.7/sui-aarch64-apple-darwin.tar.xz"
      sha256 "4b3f9ecf6934689e5989d35730f3d91eed261e7be1d48143df41c933cc517d49"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.11.7/sui-x86_64-apple-darwin.tar.xz"
      sha256 "5e7fe77890f4cd135ba2fcf93c43a6eb4f0b3e526ff56956c60bab3f34c3da53"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.11.7/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5edde42d488693928447f418c6814e3362b346c433292d3b58bcd26aee30c22b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.11.7/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b1019b19960fef537b3ee27fda16419b30163b5977820287fb49e388e618e64d"
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
