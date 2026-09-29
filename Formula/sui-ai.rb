class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.4.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.4.4/sui-aarch64-apple-darwin.tar.xz"
      sha256 "e37a701241d582644ea3939899ea3df19ce5ab26810eef3ea4a4bea577b80353"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.4.4/sui-x86_64-apple-darwin.tar.xz"
      sha256 "c218a4b7717b833ae5442a4fc01bd0267ff0537b7e2b3c67bb4c0efdf36f57cd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.4.4/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d863b04bcec0883f5a1e336261bef59bdfe7fbfbdd25b7ded9fc1b2caa8bc074"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.4.4/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0627a10a8b138b46f6ca6efa3ba135a9571fbdd05f87144e8464166e0e7c8e5f"
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
