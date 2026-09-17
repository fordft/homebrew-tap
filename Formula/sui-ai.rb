class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.4.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.4.3/sui-aarch64-apple-darwin.tar.xz"
      sha256 "a30c8280d7313d07c7aff644586096ad450a26af85f15016fa1db257239df81c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.4.3/sui-x86_64-apple-darwin.tar.xz"
      sha256 "2fd71b21a452fbd3baad0555b15167200f44c6f87d1d392188b2030bbb9e637b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.4.3/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d31d1aa607c56baf381325445b4ae5586330968b693e6f68ac1c04212b071061"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.4.3/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a30b69a94c02357e40037a015cd2d3a4504af2b92c24d195022e4b90e28d7aae"
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
