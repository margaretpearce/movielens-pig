# movielens-pig
Analyzing MovieLens movie ratings with PigLatin

### Running the script:
pig -f AverageRating.pig -param ratings=data/ratings-noheader.csv -param titles=data/movies-noheader.csv 
