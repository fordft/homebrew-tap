class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.7.0/sui-aarch64-apple-darwin.tar.xz"
      sha256 "35c97c85429bf955164ef1251b78b9bc7bc4b9098e4e0bd21ed4c98cf8d5892f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.7.0/sui-x86_64-apple-darwin.tar.xz"
      sha256 "3c9d254c77b7001f04168105efe6689e2aafff5fec47f9322597bda097ae0485"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.7.0/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "179c45d5c4edc496554c89b6b25259f2a4730ac9d305fbd0358438f8396a7385"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.7.0/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7569cd8768150e6b5b1b9a9970cb15ef2c6ecfd55cbc90ba844bd5de5685ffae"
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
