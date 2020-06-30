# app/commands/authenticate_user.rb

class AuthenticateUser
    prepend SimpleCommand
  
    def initialize(email, password)
      @email = email
      @password = password
    end
  
    def call
      JsonWebToken.encode(employee_id: employee.id, first_name: employee.first_name, last_name: employee.last_name, role_id: employee.role_id, department_id: employee.department_id, email: employee.email) if employee
    end
  
    private
  
    attr_accessor :email, :password
  
    def employee
      employee = Employee.find_by_email(email)
      return employee if employee && employee.authenticate(password)
  
      errors.add :employee_authentication, 'invalid credentials'
      nil
    end
  end