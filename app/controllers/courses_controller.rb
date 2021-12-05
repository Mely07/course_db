class CoursesController < ApplicationController
    before_action :set_course, only: [:show, :update, :destroy]

    def index 
        courses = Course.all.paginate(page: params[:page], per_page: 100)
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

    def update
        if @course.update(course_params)
            render json: @course, status: :created
        else
            render json: @course.errors, status: :unprocessable_entity
        end
    end

    def destroy
        if @course.destroy
            render json: {message: "Deletion successful"}
        else
            render json: @course.errors, status: :unprocessable_entity
        end
    end

    private
    def set_course
        @course = Course.find_by(id: params[:id])
        if !@course
            render json: {error: "Course not found"}
        end
    end

    def course_params
        params.require(:course).permit(:name, :release_date)
    end

end
