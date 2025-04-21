#!/bin/sh

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
# FIXME: implement this with GNU parallel
time echo "$files" | parallel ./load_denormalized.sh

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
# FIXME: implement this with GNU parallel
time echo "$files" | parallel python3 load_tweets.py --db=postgresql://postgres:pass@localhost:1629/postgres --inputs={}

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
# FIXME: implement this with GNU parallel

time echo "$files" | parallel python3 load_tweets_batch.py --db=postgresql://postgres:pass@localhost:1729/postgres --inputs={}

