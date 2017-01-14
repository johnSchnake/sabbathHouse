# Run in background so we can scrape
docker run -p 4567:4567 rails-app &
sleep 2

railsURL="localhost:4567"
open $railsURL

(
	#wget -m $railsURL
	mkdir localCopy
	cd localCopy
	wget --mirror --no-host-directories --page-requisites --convert-links $railsURL
	cp ../Dockerfile-static ./Dockerfile
	cp ../default-static.conf ./default.conf
	
	docker build -t static-site .
	docker run -it --publish 8080:80 static-site
)
