class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.8.0/sui-aarch64-apple-darwin.tar.xz"
      sha256 "0c562168ce0865870cba327e0a5754e1d3f06fba20358490ee1cd268899c5a3b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.8.0/sui-x86_64-apple-darwin.tar.xz"
      sha256 "41f093766fac773846518685ae3752712d4496a888073b5e1921d2b967f5aaf8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.8.0/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0a35a7e119a40b69d7da29c7010c3af78bba16cf692215d0ab4abe26adad5519"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.8.0/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c009d30cc04c9508be5ba58e2fb9379ff38044c7b90440cb3abcb5714ceae44f"
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
