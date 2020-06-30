class RoleController < ApplicationController

    def index
        respond_with Role.all
    end

    def show
        respond_with Role.find(params[:id])
    end

    def create
        respond_with Role.create(role_params)
    end

    def destroy
    respond_with Role.destroy(params[:id])
    end

    def update
    role = Role.find(params["id"])
    role.update_attributes(role_params)
    respond_with role, json: role
    end

    private
    def role_params
    params.require(:role).permit(:id, :role, :description)
    end
end
