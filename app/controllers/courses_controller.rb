class CoursesController < ApplicationController
  before_action :set_course, only: [:update, :show]

  def index
    courses = Course.includes(:tutors).all
    render json: courses, include: {tutors: {only: [:id, :first_name, :last_name]}}
  end

  def create
    course = Course.new(course_params)
    if course.save
      render json: course, status: :created
    else
      render json: {error: course.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def show
    course = Course.find(params[:id])
    render json: course, include: {tutors: {only: [:id, :first_name, :last_name]}}, status: :ok
  end

  def update
    if @course.update(course_params)
      render json: @course
    else
      render json: {error: @course.error.full_message}, status: :unprocessable_entity
    end
  end

  private
  def course_params
    params.require(:course).permit(:name)
  end

  def set_course
    @course = Course.find(params[:id])
  end
end
