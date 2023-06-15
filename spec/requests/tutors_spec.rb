require 'rails_helper'

RSpec.describe "Tutors", type: :request do
  describe "POST /courses/:course_id/tutors" do
    let!(:course) {Course.create(name: "Harry Potter")}
    it "creates a new tutor" do
      tutor_params = { first_name: "Rajnish", last_name: "Das"}
      post "/courses/#{course.id}/tutors", params: { tutor: tutor_params}
      expect(response).to have_http_status(:created)

      tutor = Tutor.last
      expect(tutor.first_name).to eq(tutor_params[:first_name])
      expect(tutor.last_name).to eq(tutor_params[:last_name])
      expect(tutor.course_id).to eq(course.id)

      tutor = JSON.parse(response.body)
      expect(tutor['first_name']).to eq(tutor_params[:first_name])
    end

    it "shows an error for invalid tutor first_name" do
      post "/courses/#{course.id}/tutors", params: { tutor: { first_name: "" }}
      expect(response).to have_http_status(:unprocessable_entity)

      errors = JSON.parse(response.body)
      expect(errors['error']).to include("First name can't be blank")
    end

    it "shows an error for invalid tutor last_name" do
      post "/courses/#{course.id}/tutors", params: { tutor: { first_name: "Raj", last_name: "" }}
      expect(response).to have_http_status(:unprocessable_entity)

      errors = JSON.parse(response.body)
      expect(errors['error']).to include("Last name can't be blank")
    end
  end
end
