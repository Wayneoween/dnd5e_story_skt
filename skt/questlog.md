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

## Hauptquests

{% assign open_quests = site.skt_quests | where:"status","main" | sort %}
{% for quest in open_quests %}
#### {{ quest.title }}

{{ quest.content }}

{% if quest.reward != 'none' %}
{% include icons/loot.html %} **Belohnung:** {{ quest.reward }}
{% endif %}

{% endfor %}

---

## Seitenquests

{% assign open_quests = site.skt_quests | where:"status","open" | sort %}
{% for quest in open_quests %}
#### {{ quest.title }}

{{ quest.content }}

{% if quest.reward != 'none' %}
{% include icons/loot.html %} **Belohnung:** {{ quest.reward }}
{% endif %}

{% endfor %}

---

## Abgeschlossene Quests

{% assign done_quests = site.skt_quests | where:"status","done" | sort %}
{% for quest in done_quests %}
#### {{ quest.title }}

{{ quest.content }}

{% if quest.reward != 'none' %}
{% include icons/loot.html %} **Belohnung:** {{ quest.reward }}
{% endif %}

{% endfor %}
