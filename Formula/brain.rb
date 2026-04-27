class Brain < Formula
  desc "Git-backed memory layer for AI coding agents"
  homepage "https://github.com/codejunkie99/brain"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/codejunkie99/brain/releases/download/v0.1.0/brain-aarch64-apple-darwin.tar.gz"
      sha256 "cf1505df6b688c882c67265a534443af2c24f307e1a0fd6d773ae06554cc5daf"
    end

    on_intel do
      url "https://github.com/codejunkie99/brain/releases/download/v0.1.0/brain-x86_64-apple-darwin.tar.gz"
      sha256 "95b9388dfcc4956d89de380a4c4cdb9fe1172f7c4a1aeaa277703c7fbac49e26"
    end
  end

  def install
    bin.install "brain"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/brain --version")

    ENV["HOME"] = testpath.to_s
    brain_dir = testpath/"brain"
    system bin/"brain", "--brain-dir", brain_dir, "onboard", "--agents", "none", "--yes"
    system bin/"brain", "--brain-dir", brain_dir, "note", "homebrew test note"
    assert_match "homebrew test note", shell_output("#{bin}/brain --brain-dir #{brain_dir} log")
  end
end
