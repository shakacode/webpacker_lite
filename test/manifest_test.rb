require "webpacker_test"

class ManifestTest < Minitest::Test
  def test_file_path
    file_path = File.join(File.dirname(__FILE__), "test_app/public/webpack", "manifest.json").to_s
    assert_equal WebpackerLite::Manifest.file_path.to_s, file_path
  end

  def test_lookup_exception
    manifest_path = File.join(File.dirname(__FILE__), "test_app/public/webpack", "manifest.json").to_s
    asset_file = "calendar.js"

    error = assert_raises WebpackerLite::FileLoader::NotFoundError do
      WebpackerLite::Manifest.lookup(asset_file)
    end

    assert_equal error.message, "Can't find #{asset_file} in #{manifest_path}. Is webpack still compiling?"
  end

  def test_lookup_success
    asset_file = "bootstrap.js"
    assert_equal WebpackerLite::Manifest.lookup(asset_file), "bootstrap-300631c4f0e0f9c865bc.js"
  end
end
