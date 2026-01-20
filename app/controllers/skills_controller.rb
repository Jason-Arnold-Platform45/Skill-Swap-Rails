class SkillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_skill, only: [:show, :edit, :update, :destroy]
  before_action :authorize_owner!, only: [:edit, :update, :destroy]

  def index
    @skills = Skill.all
  end

  def show; end

  def new
    @skill = Skill.new
  end

  def create
    @skill = current_user.skills.build(skill_params)

    if @skill.save
      redirect_to @skill, notice: "Skill created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @skill.update(skill_params)
      redirect_to @skill, notice: "Skill updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @skill.destroy
    redirect_to skills_path, notice: "Skill deleted."
  end

  private

  def set_skill
    @skill = Skill.find(params[:id])
  end

  def authorize_owner!
    unless @skill.user == current_user
      redirect_to skills_path, alert: "Not authorized."
      return
    end
  end

  def skill_params
    params.require(:skill).permit(:title, :description, :skill_type)
  end
end
