module Resourcey
  class Controller < ActionController::Base
    def index
      render json: serialized_collection(resources)
    end

    def show
      find_resource
      render json: @resource, serializer: serializer
    end

    def create
      @resource = resource_model.new(resource_params)

      if @resource.save
        render json: @resource, serializer: serializer, status: :ok
      else
        render json: { errors: @resource.errors }, status: :bad_request
      end
    end

    def update
      find_resource
      @resource.assign_attributes(resource_params)

      if @resource.save
        render json: @resource, serializer: serializer, status: :ok
      else
        render json: { errors: @resource.errors }, status: :bad_request
      end
    end

    def destroy
      find_resource
      @resource.destroy

      if @resource.destroyed?
        render json: true, status: :ok
      else
        render json: { errors: @resource.errors }, status: :bad_request
      end
    end

    private

    def find_resource
      @resource = resource_model.find(params[:id])
    end

    def resource_model_name
      @resource_model_name ||= controller_name.singularize.camelize
    end

    def resource_model
      name = resource_model_name
      name.safe_constantize || raise(Errors::ClassNotFound.new(name, :model))
    end

    def serializer
      name = "#{resource_model_name}Serializer"
      name.safe_constantize || raise(Errors::ClassNotFound.new(name, :serializer))
    end

    def resources
      resource_model.all
    end

    def resource_params
      raise Errors::NotImplemented.new(:resource_params)
    end

    def serialized_collection(collection)
      ActiveModel::Serializer::CollectionSerializer.new(collection, serializer: serializer)
    end
  end
end
