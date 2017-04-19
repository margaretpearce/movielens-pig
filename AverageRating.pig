-- Load ratings
movie_ratings = LOAD '$ratings'
USING PigStorage(',')
AS (userId: int, movieId: int, rating: double, timestamp: chararray);

movie_ratings_sample = LIMIT movie_ratings 10;
DUMP movie_ratings_sample;

-- Load titles
movie_titles = LOAD '$titles'
USING PigStorage(',')
AS (movieId: int, title: chararray, genres: chararray);

movie_titles_sample = LIMIT movie_titles 10;
DUMP movie_titles_sample;

-- Compute average rating: (movieId, avgRating, numRatings)
movie_ratings_grouped = GROUP movie_ratings BY movieId;
movie_ratings_avg = FOREACH movie_ratings_grouped GENERATE
group as movieId,
AVG(movie_ratings.rating) as avgRating,
COUNT(movie_ratings) as numRatings;

movie_ratings_avg_sample = LIMIT movie_ratings_avg 5;
DUMP movie_ratings_avg_sample;

-- Join with titles
ratings_joined_all = FOREACH (JOIN movie_ratings_avg BY movieId, movie_titles BY movieId) GENERATE *;
ratings_joined = FOREACH ratings_joined_all GENERATE
movie_titles::movieId AS movieId,
movie_titles::title AS title,
movie_ratings_avg::avgRating AS avgRating,
movie_ratings_avg::numRatings AS numRatings;

ratings_joined_sample = LIMIT ratings_joined 5;
DUMP ratings_joined_sample;
