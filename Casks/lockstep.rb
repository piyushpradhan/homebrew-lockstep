cask "lockstep" do
  version "0.1.10"
  sha256 "99c83ab85406d5544cd701b61d99515ce4d7f2b622671f2ae1479e8d7958d88e"

  url "https://github.com/piyushpradhan/homebrew-lockstep/releases/download/v#{version}/Lockstep_#{version}_arm64.dmg",
      verified: "github.com/piyushpradhan/homebrew-lockstep/"
  name "Lockstep"
  desc "Local, observable cron/scheduled-job manager — cron with eyes"
  homepage "https://trylockstep.vercel.app"

  livecheck do
    url "https://github.com/piyushpradhan/homebrew-lockstep/releases/latest"
    strategy :github_latest
  end

  auto_updates false
  depends_on macos: :big_sur
  depends_on arch: :arm64

  app "Lockstep.app"

  # No Apple Developer ID. Strip the download quarantine, then re-apply
  # a sealed ad-hoc signature so Gatekeeper accepts the app.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/Lockstep.app"]
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/Lockstep.app"]
  end

  zap trash: [
    "~/Library/Application Support/Lockstep",
    "~/Library/Caches/com.piyushpradhan.lockstep",
    "~/Library/Preferences/com.piyushpradhan.lockstep.plist",
    "~/Library/Saved Application State/com.piyushpradhan.lockstep.savedState",
  ]
end
