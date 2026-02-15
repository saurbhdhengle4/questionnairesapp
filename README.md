taskapk

This is a Flutter application that uses Mock API for login and
questionnaires.

  Step 1: Match Flutter Version

Run the following command:

flutter doctor -v

Required Version: Flutter 3.38.9 (stable) Dart 3.10.8

Example Output: Flutter version 3.38.9 on channel stable at C: Dart
version 3.10.8

If your version is different, update Flutter.

  
  Step 2: Setup Mock API
  

Open: https://mockapi.io

Create a .env file in the project root folder.

Add your base URL:

BASE_URL=https://your-project-id.mockapi.io/api/v1

Save the file.

  -
  Create Resources in MockAPI
  -

1)  Resource Name: users

Fields: - id (default) - emails (String) - password (String)

Click Create and save.

2)  Resource Name: questionnaires

Paste this JSON data:

[ { “id”: “1”, “title”: “General Feedback”, “description”: “Please share
your thoughts about our app.”, “questions”: [ { “id”: “1”, “text”: “Is
the app fast?”, “options”: [“Yes”, “No”, “Sometimes”] }, { “id”: “2”,
“text”: “Do you like the UI?”, “options”: [“Love it”, “It’s okay”, “No”]
}, { “id”: “3”, “text”: “Is navigation easy?”, “options”: [“Very easy”,
“Average”, “Difficult”] }, { “id”: “4”, “text”: “Would you use it
again?”, “options”: [“Daily”, “Weekly”, “Never”] }, { “id”: “5”, “text”:
“Rate your experience.”, “options”: [“5 Stars”, “3 Stars”, “1 Star”] } ]
}]

Save the data.

  
  Step 3: Install Dependencies
  

flutter pub get

  -
  Step 4: Run the Application
  -

flutter run

  
  Setup Complete
  

Your application should now run successfully.  Thank You for this experience
