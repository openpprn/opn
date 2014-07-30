module Scaffoldable
  extend ActiveSupport::Concern

  included do
    MODEL_CLASS = self.model_class
    before_action :set_object, only: [:show, :edit, :update, :destroy]
  end

  def index
    @temp = MODEL_CLASS
    set_model_collection
  end

  def show
  end

  def new
    set_model_instance(MODEL_CLASS.new)
  end

  def edit
  end

  def create
    set_model_instance(MODEL_CLASS.new(object_params))

    respond_to do |format|
      if model_instance.save
        format.html { redirect_to model_instance, notice: "#{MODEL_CLASS.name} was successfully created." }
        format.json { render action: 'show', status: :created, location: model_instance }
      else
        format.html { render action: 'new' }
        format.json { render json: model_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if model_instance.update(object_params)
        format.html { redirect_to model_instance, notice: "#{MODEL_CLASS.name} was successfully updated." }
        format.json { render action: 'show', status: :ok, location: model_instance }
      else
        format.html { render action: 'edit' }
        format.json { render json: model_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    model_instance.destroy
    respond_to do |format|
      format.html { redirect_to send("#{MODEL_CLASS.table_name}_path") }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_object
    set_model_instance(MODEL_CLASS.find(params[:id]))
  end

  def set_model_instance(val)
    instance_variable_set("@#{MODEL_CLASS.name.underscore}", val)
  end

  def set_model_collection
    instance_variable_set("@#{MODEL_CLASS.name.pluralize.underscore}", MODEL_CLASS.all)
  end
  def model_instance
    instance_variable_get("@#{MODEL_CLASS.name.underscore}")
  end
end