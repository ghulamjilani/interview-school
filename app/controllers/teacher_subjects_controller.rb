class TeacherSubjectsController < ApplicationController
  before_action :set_teacher_subject, only: %i[show edit update destroy]
  before_action :set_teacher, only: %i[new create]

  def edit; end

  def show; end

  def update
    if @teacher_subject.update(teacher_subject_params)
      render :show
    else
      render :edit
    end
  end

  def new
    @teacher_subject = TeacherSubject.new level: TeacherSubject::DEFAULT_LEVEL
  end

  def create
    @teacher_subject = TeacherSubject.new teacher_subject_params
    @teacher_subject.teacher = @teacher
    if @teacher_subject.save
      flash[:notice] = 'Subject was successfully added'
    else
      render :new
    end
  end

  def destroy
    @teacher_subject.destroy!
    flash[:notice] = 'Subject was successfully removed'
  end

  private

  def set_teacher_subject
    @teacher_subject = TeacherSubject.find params[:id]
  end

  def set_teacher
    @teacher = Teacher.find params[:teacher_id]
  end

  def teacher_subject_params
    params.require(:teacher_subject).permit(:level, :subject_id)
  end
end
