# Senior Seminar Backend - Travelly

## Demo

- Frontend: https://travelly-frontend.herokuapp.com/login/
- Backend: https://minecraft-steves-travelly.herokuapp.com/

## Versions

- Ruby Version: 2.6.0
- Rails Version: 5.2.3

## Commands

**After pulling down repo**

- bundle install
- rails db:migrate
- rails db:reset
- rails s

**If you need/want to deploy**

- git push heroku master
- heroku pg:reset DATABASE
- heroku run rails db:migrate
- heroku run rails db:seed

## Main Features

- Completely React Frontend - With Api Only Backend
- Document Uploading
- Jwt Authorization
- Travel/Expense Report Comments
- Payment Manager Admin Dashboard

## Backend Model Diagram

![Senior Seminar Diagram](/.github/Images/SeniorSeminarDiagram.png)


## Contributions

### <ins> Sean Passmore: </ins>

Worked on the backend with Christian. We tried to split all issues down the middle in terms of the numbers we took care of. Towards the end things got a lot more blurry as taking the time to make particular issues was less useful than actually doing what the issue would say. I did all the backend data validation. A note on that is expense reports can only be made on the day of return or after so that's not a bug that’s a feature. I handled the majority of the image upload for documents and when there were issues early on Christian and I worked as a pair to fix them. The early weeks of the project were just planning and researching anything we wanted to use such as gems and planning our database tables. Because of this we were able to have a functional database day 1 of programming. Once we got farther and noticed issues in our DB structure we were able to make small changes because of the pre planning. Learned everything about git, database design, and software engineering from Christian since I’ve not taking the DB or Software Engineering class yet.

### <ins> Christian Gerhardt: </ins>

I worked on the backend with Sean. Initially as a team we sat down and discussed the database design of the project during class time. After getting the backend initial foundation established, we moved forward with more specific needs for the backend. Just one of the items I worked on getting the “sessions” established by using JWT authorization codes for a user when they log in.  Once all the basic endpoints were provided, we started working more with Tyler for the specific endpoint changes and additions. Sean and I would split the workload. Whoever wasn’t working on something would pick up the next task or issue. Majority of the issues in our tracker has someone assigned to it so that is one way to see how people contributed. Then looking at PRs, you’ll see who did the commits, who made the PRs and who reviewed them. 