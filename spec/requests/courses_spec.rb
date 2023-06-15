require 'rails_helper'

RSpec.describe "Courses", type: :request do
  describe "GET /Courses" do
    it "shows all the courses along with tutors" do
      course1 = Course.create(name: "Programming with Ruby")
      course2 = Course.create(name: "Mathematics")
      course3 = Course.create(name: "Database Management")

      tutor1 = Tutor.create(first_name: "Rajnish", last_name: "Das", course: course1)
      tutor2 = Tutor.create(first_name: "John", last_name: "Smith", course: course2)
      tutor3 = Tutor.create(first_name: "Brie", last_name: "Larson", course: course3)

      get '/courses'
      expect(response).to have_http_status(:ok)

      courses = JSON.parse(response.body)
      expect(courses.length).to eq(3)

      expect(courses[0]['name']).to eq(course1.name)
      expect("#{courses[0]['tutors'][0]['first_name']} " "#{courses[0]['tutors'][0]['last_name']}").to eq("#{tutor1.first_name} " "#{tutor1.last_name}")

      expect(courses[1]['name']).to eq(course2.name)
      expect("#{courses[1]['tutors'][0]['first_name']} " "#{courses[1]['tutors'][0]['last_name']}").to eq("#{tutor2.first_name} " "#{tutor2.last_name}")

      expect(courses[2]['name']).to eq(course3.name)
      expect("#{courses[2]['tutors'][0]['first_name']} " "#{courses[2]['tutors'][0]['last_name']}").to eq("#{tutor3.first_name} " "#{tutor3.last_name}")
    end
  end

  describe "POST /Courses" do
    it "creates a new course" do
      course_params = {course: {name: "Science"}}

      post '/courses', params: course_params
      expect(response).to have_http_status(201)

      course = JSON.parse(response.body)
      expect(course['name']).to eq(course_params[:course][:name])
    end

    it "shows an error for invalid course parameters" do
      post '/courses', params: {course: {name: ""}}
      expect(response).to have_http_status(:unprocessable_entity)

      errors = JSON.parse(response.body)
      expect(errors['error']).to include("Name can't be blank")
    end

  end
end
