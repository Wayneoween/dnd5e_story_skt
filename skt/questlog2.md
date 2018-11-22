---
layout: page
title: Augsburg D&D - Questlog
sitemap:
    priority: 1
    lastmod: 2018-03-01
    changefreq: weekly
bodyclasses: questlog
---

## Questlog für Storm King's Thunder

----

## Offene Quests

{% assign open_quests = site.skt_quests | where:"status","open" | sort: 'number' %}
{% for quest in open_quests %}
#### {{ quest.title }}

{{ quest.content }}

{% endfor %}

## Abgeschlossene Quests

{% assign done_quests = site.skt_quests | where:"status","done" | sort: 'number' %}
{% for quest in done_quests %}
#### {{ quest.title }}

{{ quest.content }}

{% endfor %}
