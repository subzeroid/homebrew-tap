cask "insto" do
  version "0.2.0"

  on_arm do
    sha256 "34681d16d296aab1679349e6710e68989f829575617e22c2489b949a5030dc09"

    url "https://github.com/subzeroid/insto-gui/releases/download/v#{version}/insto_#{version}_aarch64.dmg"
  end
  on_intel do
    sha256 "c2171bff08ec5852ed8fa45a995ee230186191610135c37cd2e5b3a7254fc2aa"

    url "https://github.com/subzeroid/insto-gui/releases/download/v#{version}/insto_#{version}_x64.dmg"
  end

  name "insto"
  desc "Instagram monitoring desktop app with a bundled insto core"
  homepage "https://github.com/subzeroid/insto-gui"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "insto.app"

  uninstall quit: "app.insto.desktop"

  zap trash: [
    "~/Library/Application Support/insto-gui",
    "~/Library/LaunchAgents/io.insto.watch.*.plist",
  ]

  caveats <<~EOS
    insto is ad-hoc signed and not notarized. Open it once and allow it under
    System Settings → Privacy & Security, or check the DMG hash and run
    `xattr -dr com.apple.quarantine /Applications/insto.app`.
    The background monitoring service keeps running after you quit or uninstall
    the app; it runs from a private runtime, not from the app bundle. Disable it
    from inside the app before `brew uninstall --zap`, which removes that runtime
    and the service's launchd entry.
  EOS
end
