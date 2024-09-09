# TokyoScene
TokyoScene is a web application designed to help users discover and explore live music events in Tokyo. Users can search for gigs, filter by genre, and view event details on an interactive map.

## Table of Contents
* Features
* Installation
* Usage
* Screenshots
* Contributing

## Features 
* **Search for Gigs:** Users can search for live music events in Tokyo.
* **Filter by Genre:** Users can filter events by genre.
* **Interactive Map:** View event locations on an interactive map.
* **User Dashboard:** Personalised dashboard displaying user information, favourite genres, and favourite artists. Users can link their Spotify account to get gig recommendations based on their top genres.
* **Chatrooms:** Users can join chatrooms linked to a gig and interact with other users, provided they have registered for the event.

## Installation
To get started with TokyoScene, follow these steps:

1. **Clone the repository:**
   <pre>git clone https://github.com/yourusername/tokyoscene.git
   cd tokyoscene</pre>
2. **Install dependencies:**
   <pre>bundle install 
   yarn install</pre>
3. **Set up the database:**
   <pre>rails db:create
   rails db:migrate
   rails db:seed</pre>
4. **Set up environment variables:**
   Create a `.env` file in the root directory and add your environment variables:
   <pre>SPOTIFY_CLIENT_ID=your_spotify_client_id
   SPOTIFY_CLIENT_SECRET=your_spotify_client_secret
   MAPBOX_API_KEY=your_mapbox_api_key
   CLOUDINARY_URL=your_cloudinary_url</pre>
5. **Start the server:**
   <pre>rails server</pre>
7. **Visit the application:**
   Open your browser and go to `http://localhost:3000`.

## Spotify Developer Account
To use the Spotify API features, you need a Spotify developer account. Follow these steps to set it up:

1. **Create a Spotify Developer Account:**
   * Go to the [Spotify Developer Dashboard](https://developer.spotify.com/dashboard/applications) and log in with your Spotify account.
   * Create a new application to get your `client_id` and `client_secret`.
2. **Set up environment variables:**
   * Add your `client_id` and `client_secret` to the `.env` file as shown above.

## Mapbox API Key
To use the interactive map features, you need a Mapbox API key. Follow these steps to set it up:

1. **Create a Mapbox Account:**
   * Go to the [Mapbox website](https://www.mapbox.com/) and sign up for an account.
   * Create a new access token to get your `MAPBOX_API_KEY`.
2. **Set up environment variables:**
   * Add your `MAPBOX_API_KEY` to the `.env` file as shown above.

## Cloudinary Key
To use Cloudinary for image uploads, you need a Cloudinary URL. Follow these steps to set it up:

1. **Create a Cloudinary Account:**
   * Go to the [Cloudinary website](https://cloudinary.com/) and sign up for an account.
   * Get your `CLOUDINARY_URL` from the Cloudinary dashboard.
2. **Set up environment variables:**
   * Add your `CLOUDINARY_URL` to the `.env` file as shown above.

## Usage
### Searching for Gigs
* Use the search bar to find live music events in Tokyo.
* Filter events by genre using the filter bar.
* View event details and locations on the interactive map.

### User Dashboard
* View your personalised dashboard with your upcoming events, link your Spotify account for gig recommendations around Tokyo based on your music taste, and see your favorite genres and artists.
  
### Update Band Images
Fetch and update band images using the Spotify API by running the following command:
<pre>bundle exec rake gigs:update_band_images</pre>

## Screenshots
Here are some screenshots of the TokyoScene application:

### Home Page
<img width="356" alt="Screenshot 2024-09-09 at 9 05 52 PM" src="https://github.com/user-attachments/assets/1079de87-6e92-414b-a762-4cd962d6cad7">

### Search Results
<img width="356" alt="Screenshot 2024-09-09 at 9 07 08 PM" src="https://github.com/user-attachments/assets/636048c3-84e0-4f80-9e83-2e15f3d56e18">

### Gig Details
<img width="291" alt="Screenshot 2024-09-09 at 9 11 53 PM" src="https://github.com/user-attachments/assets/b178e7c9-4d1d-4e80-b57c-fde7d2f8bd08">

### Chatrooms
<img width="291" alt="Screenshot 2024-09-09 at 9 14 41 PM" src="https://github.com/user-attachments/assets/e32cc5ba-d3c2-4fc3-a4df-5de8c01fc82d">

### Chatrooms/Show
<img width="289" alt="Screenshot 2024-09-09 at 9 15 14 PM" src="https://github.com/user-attachments/assets/5b7ae5f3-1b0d-4e0f-95ab-696716df4f88">

### User Dashboard
<img width="194" alt="Screenshot 2024-09-09 at 9 20 48 PM" src="https://github.com/user-attachments/assets/fb695dc4-a534-48fd-b6eb-9c8b7470e0d0">


## Contributing
We welcome contributions to TokyoScene! To contribute, follow these steps:
1. **Fork the repository:** Click the "Fork" button at the top right of this page.
2. **Clone your fork:**
   <pre>git clone https://github.com/yourusername/tokyoscene.git
   cd tokyoscene</pre>
3. **Create a new branch:**
   <pre>git checkout -b feature/your-feature-name</pre>
4. **Make your changes:** Implement your feature or fix the bug.
5. **Commit your changes:**
   <pre>git add .
   git commit -m "Add your commit message"</pre>
6. **Push to your fork:**
   <pre>git push origin feature/your-feature-name</pre>
7. **Create a pull request:** Go to the original repository and click "New Pull Request".




