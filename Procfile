web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
resque_worker: env TERM_CHILD=1 RESQUE_TERM_TIMEOUT=10 QUEUE=critical,high,low bundle exec rake resque:work
scheduler: bundle exec rake resque:scheduler