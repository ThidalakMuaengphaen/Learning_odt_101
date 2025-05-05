require 'rails_helper'

describe "User can send a message", type: :system do
  context "test room exists" do
    before do
      @room1 = Room.create!(name: "Room 1")
    end

    context "user is in a room" do
      before do
        visit root_path
        click_link "Room 1"
        expect(page).to have_content("Room 1")
      end

      it "allows user to send a message and see it displayed", js: true do
        user_sends_a_message("Hello everyone!")
        user_sees_the_sent_message("Hello everyone!")
      end

      it "does not allow user to send a message and see it displayed", js: true do
        user_sends_a_message("")
        user_should_see_an_error_message
      end

      def user_sends_a_message(message_text)
        fill_in "message_content", with: message_text
        click_button "Create Message"
      end

      def user_sees_the_sent_message(message_text)
        expect(page).to have_content(message_text)
      end

      def user_should_see_an_error_message
        expect(page).to have_content("Content missing")
      end
    end
  end
end