class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.9.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.9.1/sui-aarch64-apple-darwin.tar.xz"
      sha256 "5b84a32ad7723667a3ca2048fd7a17c37403d926774531239ddad08b168fa972"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.9.1/sui-x86_64-apple-darwin.tar.xz"
      sha256 "cc6a8f68af36aa2c0098954420e0d27c3783374cd968b48b192a5fed5c69a2a5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.9.1/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ccbcb7075f9669da71b05231be74dbeb7229d0c457d499e5606d53cac72401d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.9.1/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "258590ca5fa073b910255e43995bf16cd04d48825dbc1a59cb0483aade31ffac"
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
