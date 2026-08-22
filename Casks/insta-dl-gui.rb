cask "insta-dl-gui" do
  version "0.1.2"
  sha256 "c93ad7cb37fa0bda3ee3dfcf556876344feab848ccc5d32c10fc94b6b57d5c56"

  url "https://github.com/subzeroid/insta-dl-gui/releases/download/v#{version}/insta-dl-gui_#{version}_universal.dmg"
  name "insta-dl-gui"
  desc "Instagram downloader desktop app — posts, reels, stories via HikerAPI"
  homepage "https://github.com/subzeroid/insta-dl-gui"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  depends_on :macos

  app "insta-dl-gui.app"

  zap trash: "~/Library/Application Support/io.github.subzeroid.insta-dl-gui"
end
