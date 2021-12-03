class CoursesController < ApplicationController
    before_action :set_course, only: [:show]

    def index 
        courses = Course.all
        render json: courses
    end

    def show 
        render json: @course
    end

    def create 
        course = Course.new(course_params)

        if course.save 
            render json: course, status: :created
        else
            render json: course.errors, status: :unprocessable_entity
        end
    end

    private
    def set_course
        @course = Course.find_by(id: params[:id])
    end

    def course_params
        params.require(:course).permit(:name, :release_date)
    end

end
