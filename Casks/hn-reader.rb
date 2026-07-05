cask "hn-reader" do
  version "0.3.0"
  sha256 "b699a0e8f198ef031b8288c6cf33437142ec2e77e9c68e7aa6c68d87fd29bf50"

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
