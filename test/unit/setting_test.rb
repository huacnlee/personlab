require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def test_find_create
    Setting.find_create
    @setting = Setting.first
    assert(@setting)
  end
end
