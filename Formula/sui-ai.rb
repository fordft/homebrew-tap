class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.10.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.10.0/sui-aarch64-apple-darwin.tar.xz"
      sha256 "fc16e4e131145627ddad788413e721fa4b88aef04d4446285b8dade1704b5518"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.10.0/sui-x86_64-apple-darwin.tar.xz"
      sha256 "72d7c38346b2138906a75c8171606ede9d5f53ccaac09e9cc203a16c7ad25eb0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.10.0/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "358079601858cd2fb9f3c17875c27756b4bfd0892f342c63397493cfadc129f0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.10.0/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c7fd22cbcf8bffe72846c0fb9363bec09fc156200ec34794cb237091616f8c43"
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
