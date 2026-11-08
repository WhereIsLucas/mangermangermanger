# Manger manger manger

## Semaines

{% assign semaines = site.pages | where_exp: "p", "p.path contains 'semaines/Recettes'" | sort: "path" | reverse %}
{% for p in semaines %}- [{{ p.path | remove: "semaines/" | remove: ".md" }}]({{ p.url | relative_url }})
{% endfor %}

## Historique

[Tous les menus passés](historique.md)
