class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.11.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.11.8/sui-aarch64-apple-darwin.tar.xz"
      sha256 "8b6d2a532527884a7394ddb86278bb12e5faff2c5317164ac64d4bc53d0c3fdc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.11.8/sui-x86_64-apple-darwin.tar.xz"
      sha256 "f66c2ee8efa61c3d67b69a735266bf4adee9a4a1ebc024ad9aae28f06be33bb0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.11.8/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a9764940cebfaa7d1104a7f5037d41abf2ac395d8fd82f82bba2d5755f5fee33"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.11.8/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "32d506d5ee0b3cc5e30acd87a0d8974714eab244f7529fe4126da47bc36efcd1"
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
