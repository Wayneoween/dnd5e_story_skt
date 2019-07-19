all: clean build

DATESTAMP=$(shell /bin/date "+%Y-%m-%d")
TIMESTAMP=$(shell /bin/date "+%Y-%m-%d %H:%M:%S")

export DATESTAMP
export TIMESTAMP

define PRAEAMBLE
---
title: "Togrims Tagebuch, Auszug XX"
image: "/images/skt/sXeXX.jpg"
excerpt: "XXX"
tags: [ "Storm King's Thunder", "SKT", "Frontpage"]
---

endef

export PRAEAMBLE

new:
	@read -p 'episode: ' EPISODE; \
	echo "$$PRAEAMBLE" > skt/_posts/${DATESTAMP}-$$EPISODE.md; \
	echo "" >> skt/_posts/${DATESTAMP}-$$EPISODE.md; \
	vim skt/_posts/${DATESTAMP}-$$EPISODE.md

build:
	bundle exec jekyll b

clean:
	$(RM) -rf _site/*

serve:
	bundle exec jekyll serve --drafts
