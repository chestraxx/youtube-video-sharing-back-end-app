require "test_helper"
include ActionCable::TestHelper

class NotificationRelayJobTest < ActiveJob::TestCase
  test "NotificationRelayJob should work with user" do
    video = Video.last

    NotificationRelayJob.perform_later(video.as_json(index: true))
    assert_enqueued_jobs 1
    assert_performed_jobs 0

    perform_enqueued_jobs
    assert_performed_jobs 1
    assert_enqueued_jobs 0
  end
end
