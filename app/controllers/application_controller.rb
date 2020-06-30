class ApplicationController < ActionController::API

    before_action :authenticate_request
    attr_reader :current_user

    respond_to :json

    private

    def authenticate_request
      @current_user = AuthorizeApiRequest.call(request.headers).result
      render json: { error: 'Not Authorized' }, status: 401 unless @current_user
    end
  
end
# Employee.create!(email: 'example@mail.com' , password: '123123123' , password_confirmation: '123123123')
# {"auth_token":"eyJhbGciOiJIUzI1NiJ9.eyJlbXBsb3llZV9pZCI6MSwiZXhwIjoxNTU2NDA3MDcwfQ.ArTnUmyAcIJ3Rw0VZHdLHTBUwCUX1hMMSF3VQN7LwS0"}
# curl -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJlbXBsb3llZV9pZCI6MSwiZXhwIjoxNTU2NDA3Mjg5fQ.46ch3iXjohzovu3Ulj5d66Af3ETIZVBJrQ9QInF4-lM" http://localhost:3000/employees.json/