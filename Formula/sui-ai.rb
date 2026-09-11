class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.3.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.3.3/sui-aarch64-apple-darwin.tar.xz"
      sha256 "d3d0b8c5182503d709959b8651c675e05de9f1f6642783fb8c7b75b5be3cc6b5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.3.3/sui-x86_64-apple-darwin.tar.xz"
      sha256 "b15620f7e8aeb44705072224ee352000004c0afb4efd5735ef35367cbc949bf7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.3.3/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d61f28fbf40add50a7ce423a4111d36528efa69ae7614c698d6143e29424be44"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.3.3/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3a5ac61f40057ad47fac3600a1e8c47e4285fa849f00f6746f15248e7bfbd7c0"
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
