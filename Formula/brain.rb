class Brain < Formula
  desc "Git-backed memory layer for AI coding agents"
  homepage "https://github.com/codejunkie99/brain"
  url "https://github.com/codejunkie99/brain/archive/47642875fc0a996882617135d0cd8db9cf0c5c98.tar.gz"
  version "0.1.0"
  sha256 "5932410420a6b694580b30593201c7a5be365e424e79e15656180dd93abc1009"
  license "Apache-2.0"
  head "https://github.com/codejunkie99/brain.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/brain-cli")
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
