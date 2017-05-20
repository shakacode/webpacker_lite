require "webpacker_test"

class EnvTest < Minitest::Test
  def test_current_env
    assert_equal WebpackerLite::Env.current, "production"
  end

  def test_file_path
    correct_path = File.join(File.dirname(__FILE__), "test_app/config", "webpacker_lite.yml").to_s
    puts "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
    puts "env_test.rb: #{__LINE__},  method: #{__method__}"
    puts "correct_path = #{correct_path}"
    puts "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"

    puts "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
    puts "env_test.rb: #{__LINE__},  method: #{__method__}"
    puts "WebpackerLite::Env.file_path.to_s = #{WebpackerLite::Env.file_path.to_s}"
    puts "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"


    assert_equal WebpackerLite::Env.file_path.to_s, correct_path
  end
end
