# Manger manger manger

## Semaines

{% assign semaines = site.pages | where_exp: "p", "p.path contains 'semaines/20'" | sort: "path" | reverse %}
{% for p in semaines %}- [{{ p.title | default: p.path }}]({{ p.url | relative_url }})
{% endfor %}

## Recettes

{% assign recettes = site.pages | where_exp: "p", "p.path contains 'recipes/'" | sort: "title" %}
{% for p in recettes %}- [{{ p.title }}]({{ p.url | relative_url }})
{% endfor %}

## Historique

[Tous les menus passés](historique.md)
