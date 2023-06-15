class TutorsController < ApplicationController

  def create
    tutor = Tutor.new(tutor_params)
    tutor.course_id = params[:course_id]

    if tutor.save
      render json: tutor, status: :created
    else
      render json: {error: tutor.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private
  def tutor_params
    params.require(:tutor).permit(:first_name, :last_name)
  end
end
