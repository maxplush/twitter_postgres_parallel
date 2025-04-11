#!/bin/bash

files=$(find data/*)

echo '================================================================================'
echo 'load denormalized'
echo '================================================================================'
time for file in $files; do
    # copy your solution to the twitter_postgres assignment here
    unzip -p "$file" | sed 's/\\u0000//g' | \
    psql postgresql://postgres:pass@localhost:1569/postgres -c \
    "COPY tweets_jsonb (data) FROM STDIN csv quote e'\x01' delimiter e'\x02';"
done

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
time for file in $files; do
	python3 load_tweets.py --db=postgresql://postgres:pass@localhost:1629/postgres --inputs="$file"
    # copy your solution to the twitter_postgres assignment here
done

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
time for file in $files; do
    python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:1729/ --inputs $file
done
