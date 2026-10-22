class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.12.11"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.12.11/sui-aarch64-apple-darwin.tar.xz"
      sha256 "e9c02ddc058c7eeb713d897ff07fda81a901bd051d44a17d8aea91b1e09f5310"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.12.11/sui-x86_64-apple-darwin.tar.xz"
      sha256 "b8e63c2a391f719d1f1f1e81e5e813dbec564a6027ce30c936925a18df60aa8f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.12.11/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6e567d7815b789e12b0a6b0797694a1bec333fc561762246c6b472478ccba6d9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.12.11/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a514fcaf2b56cdddb6a5955dd9a6eb686e93065619e08ebc404059cde9a8ede6"
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
