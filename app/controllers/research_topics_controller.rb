class ResearchTopicsController < ApplicationController
  before_action :authenticate_user!

  before_action :no_layout, :only => [:research_questions, :vote_counter]
  before_action :set_research_topic, only: [:show, :update, :edit, :destroy]

  authorize_actions_for ResearchTopic, only: [:index, :create, :new]
  def index
    @research_topics = ResearchTopic.accepted
  end

  def show
    authorize_action_for @research_topic
  end


  def create
    @research_topic = current_user.research_topics.new(research_topic_params)

    if @research_topic.save
      redirect_to research_topics_path
    else
      render :new
    end
  end

  def update
    authorize_action_for @research_topic

    if current_user.can_moderate?(@research_topic)
      @research_topic.update(research_topic_moderator_params)
    end

    if @research_topic.update(research_topic_params)
      redirect_to research_topic_path(@research_topic)
    else
      render :edit
    end
  end

  def edit
    authorize_action_for @research_topic

  end

  def new
    @research_topic = ResearchTopic.new
  end

  def destroy
    authorize_action_for @research_topic

    @research_topic.destroy

    redirect_to research_topics_admin_path

  end

  private

  def research_topic_params
    params.require(:research_topic).permit(:text, :description)
  end

  def research_topic_moderator_params
    params.require(:research_topic).permit(:state)
  end

  def set_research_topic
    @research_topic = ResearchTopic.find_by_id(params[:id])
  end

end