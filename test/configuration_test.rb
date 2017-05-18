require "webpacker_test"

class ConfigurationTest < Minitest::Test
  def test_manifest_path
    manifest_path = File.join(File.dirname(__FILE__), "test_app/public/webpack", "manifest.json").to_s
    assert_equal WebpackerLite::Configuration.manifest_path.to_s, manifest_path
  end

  def test_output_path
    output_path = File.join(File.dirname(__FILE__), "test_app/public/webpack").to_s
    assert_equal WebpackerLite::Configuration.webpack_public_output_dir.to_s, output_path
  end
end
