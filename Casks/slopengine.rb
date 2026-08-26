cask "slopengine" do
  version "0.6.4"
  sha256 "d8db2380cb573d964e8e504191ce6ec5bce10dd9fbc795cefde08a93636d9824" # scripts/checksum.sh v#{version}

  # Only an arm64 (Apple Silicon) build is currently published.
  depends_on arch: :arm64
  depends_on macos: ">= :big_sur"

  url "https://github.com/slopnode/engine/releases/download/v#{version}/slopengine-osx-arm64-v#{version}.tar.gz"
  name "slopengine"
  desc "First-person boomer shooter game engine (raylib/flecs/s7)"
  homepage "https://github.com/slopnode/engine"

  livecheck do
    url "https://github.com/slopnode/engine/releases"
    strategy :github_latest
  end

  # The release tarball extracts into a single top-level
  # slopengine-osx-arm64-v<version> directory; the binaries and the
  # "packages/engine" data dir they need at runtime live inside it.
  extracted_dir = "slopengine-osx-arm64-v#{version}"

  binary "#{extracted_dir}/slopengine"
  binary "#{extracted_dir}/slopbsp"
  binary "#{extracted_dir}/sloprad"
  binary "#{extracted_dir}/slopvis"
  binary "#{extracted_dir}/slopmap"
  binary "#{extracted_dir}/slopsprite"
  binary "#{extracted_dir}/slopicons"

  caveats <<~EOS
    slopengine looks for its bundled "engine" package in the current
    directory, then in $SLOPENGINE_ENGINE, before falling back to a
    build-machine path that does not exist on this Mac. Point it at the
    copy installed by this cask:

      export SLOPENGINE_ENGINE="#{staged_path}/#{extracted_dir}/packages/engine"

    Add that line to your shell profile (~/.zshrc, ~/.bash_profile, etc.)
    to make it permanent.
  EOS
end
