class CoursesController < ApplicationController
    before_action :set_course, only: [:show]

    def index 
        courses = Course.all
        render json: courses
    end

    def show 
        render json: @course
    end

    private
    def set_course
        @course = Course.find_by(id: params[:id])
    end

end
