class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.12.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.12.5/sui-aarch64-apple-darwin.tar.xz"
      sha256 "edb8d9c97e18a26b38fb64d5c305d615719cb711ebd482b78a211576470dd522"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.12.5/sui-x86_64-apple-darwin.tar.xz"
      sha256 "4fd6584ebf2d8f67ca155352807921c54eb64d99e8f55fe55ef21567787bd36a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.12.5/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ffb08229f925c134ab6240d4c680c9c555ecc8267a30d4ac86c739b9beff9196"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.12.5/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f5632a94c00677376176fead55c83912091a27e11bca5b4a2a14af3623541f92"
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
