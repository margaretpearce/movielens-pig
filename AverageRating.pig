movie_ratings = LOAD '$ratings'
USING PigStorage(',')
AS (userId: int, movieId: int, rating: double, timestamp: chararray);

movie_ratings_sample = LIMIT movie_ratings 10;
DUMP movie_ratings_sample;

movie_titles = LOAD '$titles'
USING PigStorage(',')
AS (movieId: int, title: chararray, genres: chararray);

movie_titles_sample = LIMIT movie_titles 10;
DUMP movie_titles_sample;

--Compute average rating
movie_ratings_grouped = GROUP movie_ratings BY movieId;
movie_ratings_grouped_sample = LIMIT movie_ratings_grouped 5;
DUMP movie_ratings_grouped_sample;