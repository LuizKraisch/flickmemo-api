## Requirements & Use cases

Here are some information about the Flickmemo's requirements and use cases. This session is being written, so some things may change.

### Use cases

Below there's a use case diagram for the main usages of the aplication:

<p align="center">
  <img src="https://github.com/LuizKraisch/flickmemo-api/docs/assets/use-case-diagram.png">
</p>

### Functional and Non-Functional Requirements

Here are some requirements that are being used to create the app:

#### Functional
 - Users can see recommendations of movies based on their profiles;
 - Users can search for movies by their name;
 - Users can view details of the movies, such as:
   - Main images (poster and backgrounds);
   - Title, release year, average score, main tags, genres, and a quick resume;
   - A general overview;
   - Recent reviews added for the movie;
   - Similar movies related to the one selected.
 - Users can add movies to their watchlist;
 - Users can review the movies, by adding:
   - A score;
   - A note (including a check for spoilers);
   - A check if the movie is a favorite one.
 - Users can see their movie lists in the profile;

#### Non-Functional
 - The mobile app should be easy to use, quick to navigate and simple to exhibit the data;
 - The mobile app should have loaders and skeletons through all the views;
 - The mobile app should work for both mobile systems (iOS and Android);
 - The mobile app should provide clear and concise instructions for adding movies to a list and writing reviews;
 - The mobile app should adapt to regional content and preferences, such as displaying movie titles and descriptions in the user's preferred language (english and portuguese);
 - The API infrastructure should be designed to handle an increasing number of users, movies, and reviews without significant performance degradation.