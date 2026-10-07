class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.10.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.10.1/sui-aarch64-apple-darwin.tar.xz"
      sha256 "5edd6dae2dc0b3affb213aef515345da3f36262f25827c7016e14f64fcbb1a98"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.10.1/sui-x86_64-apple-darwin.tar.xz"
      sha256 "83f9b8ee49380f78dffaeb5c15dfa30066d309ba230fc8077f14241eda8dedfe"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.10.1/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6ec3883c610d526d28e6ea57fabb262ce631f81162d0cd479ac5f86263dba3b8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.10.1/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "48cc81ffe5ccc17a35e6b04c2f3b8df7ade9c79384f0806e01143d3859e22cc9"
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
