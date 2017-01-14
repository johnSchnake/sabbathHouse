FROM ruby:2.5
ENV DIRPATH /usr/src/app/
WORKDIR $DIRPATH

# Add gemfile and bundle before app files to maintain cache longer.
ADD Gemfile* $DIRPATH
RUN ["gem", "install", "bundler"]
RUN ["bundle", "install", "--path", "vendor/bundle", "--binstubs", "vendor/bundle/bin", "--deployment"]

EXPOSE 4567
ENV RAILS_ENV production
ENV SECRET_KEY_BASE f0b75fbd428de7d008fdfc7b1a2ebc1217d5ac2f3eee5ed2d3eaccad5b0ea9f8fb0e8594bb6908ee36723ac740e3aa596c2d71a5e838323354f4aeddbb8af209
ENV RAILS_SERVE_STATIC_FILES true

COPY . $DIRPATH
RUN ["bundle","exec", "rake", "assets:precompile"]
CMD ["bundle","exec", "unicorn", "-p", "4567"]
