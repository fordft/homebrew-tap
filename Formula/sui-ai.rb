class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.3.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.3.5/sui-aarch64-apple-darwin.tar.xz"
      sha256 "ca3826977a24e22eedca3c487176cf477125511ead4415997fa9ceef1d9cc2a4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.3.5/sui-x86_64-apple-darwin.tar.xz"
      sha256 "4f2059d0134c620b2cf6c2898fe0f5bf76bfb204633d432b117fc06f05467c31"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.3.5/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1c364e9ba399a3b74b2fbf5075f8bb5181920c7faf423ff107a0e8c5d3359a0b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.3.5/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "130b8d67e22e4652028094265635190dab5988db65af3f3c150e68540fd638a4"
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
