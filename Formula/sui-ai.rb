class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.3.0/sui-aarch64-apple-darwin.tar.xz"
      sha256 "9730e1a4aa71ee36e14be99814570db28b4a36acf4040c0875bd7f4cc4020bc7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.3.0/sui-x86_64-apple-darwin.tar.xz"
      sha256 "669bf6b168419b5251fec0d36f1557639a79f402daaea6ccbef95675e2696695"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.3.0/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b7c7a727ecf23c2cfdbcd2e8bb67f2fd68cc9e90102023f644573921e2a150f8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.3.0/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "df4d0cddda1a98b96bbdd6b5dd70b8d475f2c7092bdcfc7a1c27f1030199a1ea"
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
