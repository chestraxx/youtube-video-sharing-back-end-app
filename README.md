# youtube-video-sharing-back-end-app

### Introduction:

    youtube-video-sharing-back-end-app is back-end app, part of youtube video sharing app.

### Prerequisites:

    ruby ~ 3.*
    postgres ~ 14.*
    redis

### Installation & Configuration:

    1. git clone https://github.com/chestraxx/youtube-video-sharing-back-end-app.git
    2. cd youtube-video-sharing-back-end-app
    3. bundle
    4. touch config/application.yml
    5. vi config/application.yml
    6. Add config below to file:
        YOUTUBE_API_KEY: YOUR_YOUTUBE_API_KEY
        CABLE_ALLOWED_REQUEST_ORIGINS:
          [
            "http://localhost:3000"
          ]
        REQUEST_ORIGINS: "http://localhost:3000"
    7. Change YOUR_YOUTUBE_API_KEY by Google API Key (follow https://developers.google.com/youtube/registering_an_application)

### Database Setup:

    1. vi config/database.yml
    2. Edit username & password of local database
    3. rails db:create
    4. rails db:migrate
    5. rails test

### Docker Deployment:

### Usage:

### Troubleshooting:
