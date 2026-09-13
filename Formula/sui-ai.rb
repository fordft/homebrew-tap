class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.4.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.4.2/sui-aarch64-apple-darwin.tar.xz"
      sha256 "0136d4f5f09808495fc10f9a931368c1cc5a556f6283fb04aa77b615fe3c8507"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.4.2/sui-x86_64-apple-darwin.tar.xz"
      sha256 "a8ea8513065b1e0f9295db36b1907da45514d2ade240962d0383853d7759d069"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.4.2/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "274528f8832df59d7e066e4fac66a379e9b4f796965f20f332273358ef92815b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.4.2/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e02aae7f0e5ccedfb99d53d0e4041b64aa35b9c4fc8ac9549df7eac717784c93"
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
