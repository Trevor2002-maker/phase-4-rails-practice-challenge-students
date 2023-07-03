class StudentsController < ApplicationController
    before_action :set_instructor
    before_action :set_student, only: [:show, :update, :destroy]
  
    def index
      @students = @instructor.students
      render json: @students
    end
  
    def show
      render json: @student
    end
  
    def create
      @student = @instructor.students.build(student_params)
      if @student.save
        render json: @student, status: :created
      else
        render json: @student.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @student.update(student_params)
        render json: @student
      else
        render json: @student.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @student.destroy
      head :no_content
    end
  
    private
  
    def set_instructor
      @instructor = Instructor.find(params[:instructor_id])
    end
  
    def set_student
      @student = @instructor.students.find(params[:id])
    end
  
    def student_params
      params.require(:student).permit(:name, :major, :age)
    end
  end