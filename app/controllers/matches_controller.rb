class MatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_match, only: [:show, :accept, :reject]

  def index
    @matches = Match.for_user(current_user)
  end

  def show
  end

  def create
    skill = Skill.find(params[:skill_id])

    @match = Match.new(
      skill: skill,
      requester: current_user,
      provider: skill.user,
      status: "pending"
    )

    if @match.save
      redirect_to matches_path, notice: "Match request sent."
    else
      redirect_to skills_path, alert: @match.errors.full_messages.to_sentence
    end
  end

  def accept
    authorize_provider!
    @match.update!(status: "accepted")
    redirect_to matches_path, notice: "Match accepted."
  end

  def reject
    authorize_provider!
    @match.update!(status: "rejected")
    redirect_to matches_path, alert: "Match rejected."
  end

  private

  def set_match
    @match = Match.find(params[:id])
  end

  def authorize_provider!
    unless @match.provider == current_user
      redirect_to matches_path, alert: "You are not allowed to do that."
    end
  end
end
