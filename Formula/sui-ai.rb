class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.12.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.12.7/sui-aarch64-apple-darwin.tar.xz"
      sha256 "7eef8d34e7725654da81f710a62d0460609410bd2496c30c2d2974d9f68c1276"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.12.7/sui-x86_64-apple-darwin.tar.xz"
      sha256 "97e3169a25670dd85c192093973552ab4cb846caeae1aea91fe22f873f3f6076"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.12.7/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fadda769acc8dadca82619029517212d9d4c18c9b103010cf6e8b3a869ba2f1c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.12.7/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6a1c681cbf94550ae79e5c5fc70d628d373a61f4db132b7f238734ac95f1f111"
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
