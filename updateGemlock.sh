docker run --rm -v $(pwd):/app -w /app -it ruby:2.5.0 /bin/bash -c "gem install bundler && bundle lock --update"
