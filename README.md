# README

This site was designed for a friend and local Nun who has a passion for helping others celebrate the Sabbath.

It was also an opportunity for me to learn some Ruby on Rails and deploy another site for the first time.

Included is a RoR app which can also be nearly served as a static site. The organization had a hosting agreement
which made it hard to use RoR so I actually had to deploy it like that. Using a running version of the site I used
wget to pull the HTML and then tweaked it to fix any resulting issues.

## Initial Creation

 - Create a normal RoR app
 - Comment out the lines of code for active_record since I dont need/want a database to worry about for this project. Debately I didn't need to use RoR at all but that was its own goal.
 - Launch a Docker container to generate the Gemfile.lock

## Deployment

To deploy a new version:

```
// Make code changes...

// Generate a new Gemfile.lock if gems changed.
docker run --rm -v $(pwd):/app -w /app -it ruby:2.5.0 /bin/bash -c "gem install bundler && bundle lock --update"

// Build the RoR app Docker image.
docker build . -t rails-app

// Run the RoR app, scrape it, and launch the static site to confirm changes to be deployed.
./run.sh

// If everything looks good, deploy it.
export FTP_LOGIN=<user login>
export FTP_PASSWORD=<pw>
./deploy.sh
```
