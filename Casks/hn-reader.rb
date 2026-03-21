cask "hn-reader" do
  version "0.2.0"
  sha256 "26c6a7505731f1a6f29d25469181366fbdd022d23cd56dcd266f1f1d0f74d2b4"

  url "https://github.com/tbeseda/hnr-swiftui/releases/download/v#{version}/HNReader.zip"
  name "HN Reader"
  desc "Native macOS app for browsing Hacker News stories"
  homepage "https://github.com/tbeseda/hnr-swiftui"

  depends_on macos: ">= :sequoia"

  app "HNReader.app"

  postflight do
    %w[com.apple.quarantine com.apple.provenance].each do |attr|
      result = system_command "/usr/bin/xattr",
                              args: ["-dr", attr, "#{appdir}/HNReader.app"]
      unless result.exit_status.zero?
        opoo "Failed to remove #{attr} from HNReader.app: #{result.stderr.strip}"
      end
    end
  end

  zap trash: [
    "~/Library/Preferences/com.tbeseda.HNReader.plist",
  ]
end
