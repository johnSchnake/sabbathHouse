#!/bin/bash
set -x

# Run in background so we can scrape and kill later.
railsAppID=`docker run -d -p 4567:4567 rails-app`
sleep 2

railsURL="http://localhost:4567"
open $railsURL

(
	# Ensure localCopy is empty and scrape site.
	rm -rf localCopy ; mkdir localCopy
	cd localCopy
	wget --mirror --no-host-directories --page-requisites --convert-links $railsURL
	
	# Run the static site and check if it looks good in the browser. Browse to
	# localhost:8080 to review. Compare to localhost:4567 to compare to the
	# rails version.
	docker build -t static-site -f - . < ../Dockerfile-static
	
	# Will open before running blocking docker run; just refresh the page.
	# Otherwise we have to put docker in the background and manually kill later.
	open http://localhost:8080
	docker run -it --publish 8080:80 static-site

	# Leave this running until after you're done with the static site.
	docker kill $railsAppID
)
