# Flutter Posts App

A Flutter app that interacts with the [JSONPlaceholder API](https://jsonplaceholder.typicode.com/posts) to display a list of posts with interactive features.

## Features

1. **Post List**:
   - Fetches posts from `https://jsonplaceholder.typicode.com/posts`.
   - Displays posts in a scrollable list with light yellow background initially.

2. **Detail Screen**:
   - Opens when a post is clicked.
   - Fetches post details from `https://jsonplaceholder.typicode.com/posts/{postId}`.
   - Displays the post description from the `body` field.

3. **Mark as Read**:
   - Changes row background color to white after a post is clicked.

4. **Timer Icon**:
   - Shows a random timer (e.g., 10s, 20s) next to each post.

5. **Local Storage**:
   - Stores posts locally using `shared_preferences`.
   - Loads posts from local storage first, then updates from the API in the background.

### Below is a working video of the app
![Simulator Screenshot - iPhone 15 Pro - 2024-12-12 at 16 58 15](https://github.com/user-attachments/assets/27071b96-b8d5-482b-9f1c-47a905d54add)


https://github.com/user-attachments/assets/4babf23e-7f4d-4929-bd70-c27fa394faeb



### Below is the link to the apk - 
 - [APK LINK](https://drive.google.com/file/d/1kvXJWOskuUlR0vy9skIcEeCUcxHTtnT2/view?usp=sharing)

## How to Run

1. Clone the project:
   git clone <repository_url>
   cd flutter_posts_app
2. Install Dependencies
   flutter pub get
3. Run the app: flutter run

