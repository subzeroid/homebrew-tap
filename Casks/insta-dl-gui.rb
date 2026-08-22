cask "insta-dl-gui" do
  version "0.1.1"
  sha256 "3587174bf17037e366c69cbd6c893dde5fc0d9ae75656ac4933eb02bca42e1e6"

  url "https://github.com/subzeroid/insta-dl-gui/releases/download/v#{version}/insta-dl-gui_#{version}_universal.dmg"
  name "insta-dl-gui"
  desc "Instagram downloader desktop app — posts, reels, stories via HikerAPI"
  homepage "https://github.com/subzeroid/insta-dl-gui"

  livecheck do
    url :homepage
    strategy :github_latest
  end


  app "insta-dl-gui.app"

  zap trash: "~/Library/Application Support/io.github.subzeroid.insta-dl-gui"
end
