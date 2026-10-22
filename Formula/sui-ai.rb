class SuiAi < Formula
  desc "cache-first multi-agent coding harness"
  homepage "https://github.com/fordft/sui"
  version "0.12.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.12.9/sui-aarch64-apple-darwin.tar.xz"
      sha256 "9347480124d4e469667bfe5cb74079db2c0bf9373a02cfc13235317c5e0052df"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.12.9/sui-x86_64-apple-darwin.tar.xz"
      sha256 "6264fee7503325f9cd17fe6d7e125958e36f8d3f0700565051037459bb3436b1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fordft/sui/releases/download/v0.12.9/sui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "17795a6d644612dcc728f8ac1c1d8e62dcfa6277da7cea794c485c7e224b928d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fordft/sui/releases/download/v0.12.9/sui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d1f8bb9e13983287a5054fc2446e9ae540a64045f3fba2819d94328b892dc418"
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
