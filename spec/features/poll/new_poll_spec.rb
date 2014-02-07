require "spec_helper"

describe "Poll#New_page" do 
	let(:existing_poll) {FactoryGirl.create(:poll)}
	let(:new_poll) { FactoryGirl.build(:poll)}
	
	subject{ page }

	context "user creates a new poll after first creating an image" do
		before(:each) do
			sign_in_as_existing_user(new_poll.user)
			visit new_poll_path(image_id: new_poll.image.id)
		end

		#it should have an image of the image just uploaded  <--- How to test?
		it { should have_field("poll_question") }
		it { should have_field("poll_button1") }
		it { should have_field("poll_button2") }
		it { should have_field("poll_response1") }
		it { should have_field("poll_response2") }
		it { should have_button("Preview")}
		
		context "user presses 'Preview'" do
			before(:each) { preview_a_new_poll(new_poll) }

			it "save the new poll" do
				Poll.last.question.should == new_poll.question
				Poll.last.user_id.should == new_poll.user.id
				#chose to test the save of only 2 of the attributes
			end

			it "creates a unique string identifier in place of id for use in URL" do
				Poll.last.identifier.length.should == 8
			end

			it "assigns the draft poll's 'id' as 'origin_poll' value to identify it as the first poll in a new string of polls" do
				Poll.last.origin_poll.should == Poll.last.id
			end
		end
	end

	context "user visits new_poll_path directly without first creating an image" do
		before(:each) do
			sign_in_as_existing_user(new_poll.user)
			visit new_poll_path
		end

		it "routes the user back to the new_image_path" do
			current_path.should == new_image_path
		end
	end

	context "poll recipient logs in and clicks 'Forward' to forward an existing poll" do
		before(:each) do
			sign_in_as_existing_user(existing_poll.user)
			visit new_poll_path(origin_id: existing_poll.id, type: "existing")
		end
	
		#it should have an image of the image just uploaded  <--- How to test?
		it { should have_field("poll_question", with: existing_poll.question)}
		it { should have_field("poll_button1", with: existing_poll.button1)}
		it { should have_field("poll_button2", with: existing_poll.button2)}
		it { should have_field("poll_response1", with: existing_poll.response1)}
		it { should have_field("poll_response2", with: existing_poll.response2)}

		context "author clicks 'Preview'" do
			before(:each) { click_on "Preview" }

			it "saves the original poll's 'origin_poll' value in the forwarded poll's 'origin_poll' field" do
				Poll.last.origin_poll.should == existing_poll.origin_poll
			end
		end
	end
end




