cask "hn-reader" do
  version "0.4.2"
  sha256 "e9b425d43ce07c635a9af308ca47795d68e72f5fd4e9f285cd4d8d47bcebe927"

  url "https://github.com/tbeseda/hnr-swiftui/releases/download/v#{version}/HNReader.zip"
  name "HN Reader"
  desc "Hacker News story reader with unread tracking"
  homepage "https://github.com/tbeseda/hnr-swiftui"

  depends_on macos: :sequoia

  app "HNReader.app"

  # The app is unsigned; clear Gatekeeper's quarantine so it opens
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/HNReader.app"], must_succeed: false
    run "/usr/bin/xattr", args: ["-dr", "com.apple.provenance", "{{appdir}}/HNReader.app"], must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/HNReader",
    "~/Library/Preferences/com.tbeseda.HNReader.plist",
  ]
end
