# Grade.io
With the COVID-19 pandemic, a lot of education moved to a remote workspace.  Grade.io is here to help!
#
# Vision Statement
Our vision is to provide full transparency of the daily academic process to parents, students, and teachers, in order to build a productive remote learning environment.
#
# How to Build the Application
1. Clone the Grade.io repository 
2. Open a terminal and cd to the root of our project
3. Run ‘pod install’
<img width="215" alt="Screen Shot 2021-05-07 at 11 22 56 AM" src="https://user-images.githubusercontent.com/49224676/117492571-9fd3ad80-af26-11eb-8818-c46de2141212.png">
4. Open Grade.IO.xcworkspace
<img width="139" alt="Screen Shot 2021-05-07 at 11 20 54 AM" src="https://user-images.githubusercontent.com/49224676/117492321-4b303280-af26-11eb-8d8f-46296d70e4d7.png">
5. Make sure the app is utilizing an iPad simulator, then run the application by clicking the Play Button on XCode.
<img width="304" alt="Screen Shot 2021-05-07 at 11 21 51 AM" src="https://user-images.githubusercontent.com/49224676/117492427-6dc24b80-af26-11eb-995c-f98a983e87ad.png">
6. Allow up to a few minutes for the appliction to build.  During this time, the progress bar at the top of xcode should keep a running tally of what tasks are currently building.

# Application Structure

For each classroom, we have a list of Assignment IDs. We also have an ID for the teacher of that class, and a list of student IDs. 
The codable protocol, along with some of our helper functions utilized in these individual classes allows us to generate objects from the Database directly from these IDs.

![2_26_21 class diagram for assignment_classroom](https://user-images.githubusercontent.com/37358652/117493788-4d938c00-af28-11eb-8ae6-f5732a78feb4.png)

Below is our user structure.

![classdiagram feb2021 (USER STRUCTURE)](https://user-images.githubusercontent.com/37358652/117494023-9b0ff900-af28-11eb-8e2b-6f128a34362e.png)

# Adding data to our Database

Generally, we should avoid directly manipulating data on the database (which is easier said than done sometimes). The application will respond to these changes, but unintended side effects may occur. Generally, if you want to create a student or any other such object for testing purposes, make it in the app from the perspective of a user.


