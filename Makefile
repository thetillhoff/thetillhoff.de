IMAGE := ghcr.io/thetillhoff/thetillhoff.de

.PHONY: dev build docker-build docker-run clean

dev:
	temingo -w -s -v

build:
	temingo

docker-build:
	docker build -t $(IMAGE) .

docker-run:
	docker run --rm -p 80:80 $(IMAGE)

clean:
	rm -rf output/
