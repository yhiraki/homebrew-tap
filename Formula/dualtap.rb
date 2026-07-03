class Dualtap < Formula
  desc "Record mic + system audio together on macOS, no BlackHole"
  homepage "https://github.com/yhiraki/dualtap"
  url "https://github.com/yhiraki/dualtap/releases/download/v0.1.2/dualtap-v0.1.2-macos-universal.tar.gz"
  sha256 "523dd2ad1091aab4ff8bd7fdb91b2a95e7d95ddc57516fa4879bfe2b2a6630a8"
  license "MIT"
  head "https://github.com/yhiraki/dualtap.git", branch: "main"

  depends_on macos: :sonoma
  depends_on xcode: :build if build.head?

  def install
    if build.head?
      system "swift", "build", "--disable-sandbox", "-c", "release"
      bin.install ".build/release/dualtap"
    else
      bin.install "dualtap"
    end
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
