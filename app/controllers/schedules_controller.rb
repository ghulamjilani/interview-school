class SchedulesController < ApplicationController
  before_action :set_student
  before_action :set_section_student, only: [:update, :destroy]

  def index
    @section_student = @student.section_students
  end

  def new
    @section_student = @student.section_students.new
  end

  def edit
    @section_student = @student.section_students.find_by(id: params.dig(:id))
  end

  def show
    @section_student = SectionStudent.find(params.dig(:id))
  end

  def update
    if @section_student.update(section_params)
      flash[:notice] = 'Section was updated successfully'
      redirect_to schedules_path
    else
      render :edit
    end
  end

  def create
    @section_student = @student.section_students.find_or_initialize_by(section_id: section_params.dig(:section_id))

    if @section_student.save
      flash[:notice] = 'Section was successfully added'
      redirect_to schedules_path
    else
      render :new
    end
  end

  def destroy
    if @section_student.destroy
      redirect_to schedules_path, notice: 'Schedule was successfully destroyed.'
    else
      redirect_to schedules_path, alert: 'Unable to delete schedule'
    end
  end

  private

  def set_section_student
    @section_student = SectionStudent.find(params.dig(:id))
  end

  def section_params
    params.permit(:section_id)
  end

  def set_student
    @student = Student.find_by(ip_address: request.remote_ip) || Student.create(ip_address: request.remote_ip)
  end
end
