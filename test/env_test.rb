require "webpacker_test"

class EnvTest < Minitest::Test
  def test_current_env
    assert_equal Rails.env, WebpackerHelpers::Env.current
  end

  def test_file_path
    correct_path = File.join(File.dirname(__FILE__), "test_app", "config", "webpacker_helpers.yml").to_s
    assert_equal correct_path, WebpackerHelpers::Env.file_path.to_s
  end
end
