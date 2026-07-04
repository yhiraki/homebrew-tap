class Dualtap < Formula
  desc "Record mic + system audio together on macOS, no BlackHole"
  homepage "https://github.com/yhiraki/dualtap"
  url "https://github.com/yhiraki/dualtap/releases/download/v0.1.3/dualtap-v0.1.3-macos-universal.tar.gz"
  sha256 "c49c7a6a19b92b5d1fd742351fc99bc8c8abe5b308612fc1102a02158ac37082"
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
