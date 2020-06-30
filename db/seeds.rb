# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
role1 = Role.create!(role: "Employee", description: "Submits travel requests and expense reports")
role2 = Role.create!(role: "Budget Approver", description: "Reviews travel requests and expense reports")
role3 = Role.create!(role: "Payment Approver",
  description: "Has ultimate control over travel requests and expense reports")

  Department.create!(name: "Computer Science", department_number: 69, budget: 10000.00)
  Department.create!(name: "Biology", department_number: 420, budget: 20000.00)
  Department.create!(name: "History", department_number: 1776, budget: 30000.00)
  Department.create!(name: "Payment", department_number: 0, budget: 0.00)
  BudgetCode.create!(budget_code: 42069,
    description:"Budget code for non-department employee expenses",
    department_id: 1)
  BudgetCode.create!(budget_code: 29213,
    description:"ICPC - ACM billing",
    department_id: 1)
  BudgetCode.create!(budget_code: 42233,
    description:"Vehicle gas money for bug jobs",
    department_id: 2)
  BudgetCode.create!(budget_code: 14422,
    description:"Plane trips to find national treasure",
    department_id: 3)

Employee.create!(first_name: "Eboby", last_name: "Eboberson", role_id: 1, department_id: 1, email: "memes1@meme.com", password:"nice_meme")
Employee.create!(first_name: "Bobert", last_name: "Bugabert", role_id: 2, department_id: 2, email: "memes2@meme.com", password:"nice_meme")
Employee.create!(first_name: "Bonjulio", last_name: "Bojulio", role_id: 2, department_id: 1, email: "memes3@meme.com", password:"nice_meme")
Employee.create!(first_name: "Biggy", last_name: "Throckmorton", role_id: 2, department_id: 2, email: "memes4@meme.com", password:"nice_meme")
Employee.create!(first_name: "Beetlegoose", last_name: "Waterbottle", role_id: 2, department_id: 3, email: "memes5@meme.com", password:"nice_meme")
Employee.create!(first_name: "Playboi", last_name: "QT", role_id: 3, department_id: 4, email: "memes6@meme.com", password:"nice_meme")
# Travel.create!(destination: "Fucktopolis", purpose: "Oh, you know.", date_of_departure: Date.today, date_of_return: Date.tomorrow, employee_id: 1, status:1)
# Expense.create!(expense_type: "Erotic Massage", amount: 400000.00, expensed_type: "Travel", expensed_id: 1)
# Document.create!(image_url: open('app/assets/images/dcbang.jpg'), expense_id: 1)
