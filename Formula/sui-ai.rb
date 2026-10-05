class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.9.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.9.0/sui-aarch64-apple-darwin.tar.xz"
      sha256 "5273ffcd6fed29df02049bb76a3d498aac414e24c3482298c7444970d955fde1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.9.0/sui-x86_64-apple-darwin.tar.xz"
      sha256 "ee1c9253b552c601ca99c8e31754384caaf94a101cd2c5fe82aa542c4398cee0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.9.0/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a54bc5cf9253da7727f78ecc9850a024e7adb7a1262e8e708090a84a2e4eebdb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.9.0/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f63e0a92a706a9cb91e796cc4f047fa80f26895628236a31144e7ab561d80da4"
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
