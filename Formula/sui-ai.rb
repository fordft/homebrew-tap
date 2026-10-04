class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.4.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.4.7/sui-aarch64-apple-darwin.tar.xz"
      sha256 "a8eabd162b29783a6c282e932d2b9f5d258830e74ad1a40cc75aaccb11c1e037"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.4.7/sui-x86_64-apple-darwin.tar.xz"
      sha256 "01f7ff07d24cd0b7fa11fe6bb2c5928bee850630857b9609f1ec4f80df60cc3a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.4.7/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7d5a5967cb06634c02dbba71497ffd6048c450802678e9135758b9a5eceebf64"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.4.7/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c6199d8fcbaf3c0f7927b655bc6e5bb5586a960a0c9aa2146225dfcf69ace5a7"
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
