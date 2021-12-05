require 'rails_helper.rb'

RSpec.describe CoursesController, type: :request do 

    context 'GET #index' do
        it 'returns all courses' do 
            course = Course.create!(name: "Test Course 1", release_date: "2021-12-25")
            course = Course.create!(name: "Test Course 2", release_date: "2021-12-26")
            get "/courses"
            expect(JSON(response.body).length).to eq(2)
        end
    end

    context 'GET #show' do
        it 'returns course specified by id' do 
            course = Course.create!(name: "Test Course 1", release_date: "2021-12-25")
            get "/courses/#{course.id}"
            expect(JSON(response.body)["id"]).to eq(course.id)
        end

        it 'returns error message if specified course is not found' do 
            get "/courses/1"
            expect(JSON(response.body)["error"]).to eq("Course not found")
        end   
    end

    describe 'POST #create' do
        it 'successfully creates new course' do
            post "/courses", params: {course: {:name => "Testing Course", :release_date => "2021-12-25"}, :headers => headers}
            expect(Course.last.name).to eq("Testing Course")
        end

        it ' does not successfully create new course if missing information' do
            post "/courses", params: {course: {:name => "Testing Course", :release_date => ""}, :headers => headers}
            expect(response).to have_http_status(422)
        end
    end

    context 'PATCH #update' do
        it 'successfully updates a new course'  do
            course = Course.create!(name: "Test Course", release_date: "2021-12-25")
            patch "/courses/#{course.id}", params: {course: {:name => "Testing Course", :release_date => "2021-12-25"}, :headers => headers}
            expect(response.content_type).to eq('application/json')
            expect(JSON(response.body)["name"]).to eq("Testing Course")
        end

        it 'fails to update course if invalid data is submitted'  do
            course = Course.create!(name: "Test Course", release_date: "2021-12-25")
            patch "/courses/#{course.id}", params: {course: {:name => "Testing Course", :release_date => "2021-12-2590"}, :headers => headers}
            expect(response).to have_http_status(422)
        end

        it 'returns error message if course is not found' do 
            patch "/courses/1"
            expect(JSON(response.body)["error"]).to eq("Course not found")
        end  
    end

    context 'DELETE #destroy' do
        it 'finds course by id, destroys it' do  
            course = Course.create!(name: "Test Course", release_date: "2021-12-25")
            delete "/courses/#{course.id}"
            expect(Course.all.length).to eq(0)
        end

        it 'returns error message if course is not found' do 
            delete "/courses/1"
            expect(JSON(response.body)["error"]).to eq("Course not found")
        end  
    end

end