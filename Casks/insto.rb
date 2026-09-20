cask "insto" do
  version "0.1.1"

  on_arm do
    sha256 "e35fb35ed40a6fe199a9d96273a34390c7037c86c3c6e64e7bdd36d8aa82df76"

    url "https://github.com/subzeroid/insto-gui/releases/download/v#{version}/insto_#{version}_aarch64.dmg"
  end
  on_intel do
    sha256 "7d91c4e46b873fc3fb4d95c438a9046e1fa56d174b4d4a6e213b0f860f1f88b2"

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
