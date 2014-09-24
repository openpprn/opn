class ResearchTopicsController < ApplicationController
  authorize_actions_for ResearchTopic

  before_action :no_layout, :only => [:research_questions, :vote_counter]
  before_action :set_research_topic

  def index

  end

  def show
    @research_topic = ResearchTopic.find(params[:id])
  end


  def create
    @research_topic = current_user.research_topics.new(research_topic_params)

    if @research_topic.save
      redirect_post @research_topic
    end
  end

  def update
    if @research_topic.update(post_params)
      redirect_post @research_topic
    end
  end

  def edit
  end

  def new
    @research_topic = ResearchTopic.new
  end

  def destroy
    @research_topic.destroy

    redirect_to research_topics_admin_path

  end

  private

  def research_topic_params
    params.require(:research_topic).permit(:text, :description)
  end

  def set_research_topic
    @research_topic = ResearchTopic.find_by_id(params[:id])
  end

end