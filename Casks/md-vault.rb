cask "md-vault" do
  version "0.4.0"
  sha256 "3623c3a3356959965d8d0679045600799dcc08b404ee89818e7cf7a2c783cc8c"

  url "https://github.com/tbeseda/md-vault/releases/download/v#{version}/md-vault.zip"
  name "md-vault"
  desc "Viewer and editor for folders of markdown files"
  homepage "https://github.com/tbeseda/md-vault"

  depends_on macos: :tahoe

  app "md-vault.app"

  postflight do
    %w[com.apple.quarantine com.apple.provenance].each do |attr|
      result = system_command "/usr/bin/xattr",
                              args: ["-dr", attr, "#{appdir}/md-vault.app"]
      opoo "Failed to remove #{attr} from md-vault.app: #{result.stderr.strip}" unless result.exit_status.zero?
    end
  end

  zap trash: "~/Library/Preferences/com.tbeseda.md-vault.plist"
end
