require "test_helper"

class ShareMailerTest < ActionMailer::TestCase
  test "share_file" do
    mail = ShareMailer.share_file
    assert_equal "Share file", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
