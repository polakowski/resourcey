class UsersController < Resourcey::Controller

  private

  def resource_params
    params.require(:user).permit(:name, :age)
  end
end
