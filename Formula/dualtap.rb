class Dualtap < Formula
  desc "Record mic + system audio together on macOS, no BlackHole"
  homepage "https://github.com/yhiraki/dualtap"
  url "https://github.com/yhiraki/dualtap/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f1f301815592aaa41dfb6bcc7637df8f1452be946028fb25c6b03fcc47974e50"
  license "MIT"
  head "https://github.com/yhiraki/dualtap.git", branch: "main"

  depends_on xcode: :build
  depends_on macos: :sonoma

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/dualtap"
  end

  def caveats
    <<~EOS
      dualtap captures system audio via the Core Audio process tap, which
      requires macOS 14.4 or newer.

      It records from the terminal it runs in, so the first run prompts your
      terminal app for Microphone and Audio Recording permission.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dualtap --version")
  end
end
