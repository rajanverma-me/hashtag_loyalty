require 'test_helper'

class InformMailerTest < ActionMailer::TestCase
  test "data_uploaded" do
    mail = InformMailer.data_uploaded
    assert_equal "Data uploaded", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
