---
description: Planifier le menu de la semaine (contraintes en argument)
argument-hint: [dates, stock, soirs seuls, invités, envies…]
---

Planifie le menu de la semaine en suivant le « Déroulé d'une session type » de CLAUDE.md.

Contraintes données par Lucas : $ARGUMENTS

Avant de proposer quoi que ce soit :
1. Lis `historique.md` en entier et applique les règles de rotation de CLAUDE.md.
   Parcours aussi `recipes/` : une recette déjà écrite peut être reproposée (en respectant la rotation) et réutilisée telle quelle.
2. Lis la liste Rappels « Wishlist Repas » (envies notées au fil de l'eau) :
   `osascript -e 'tell application "Reminders" to get name of (reminders of list id "14BFC200-4630-492A-B3A6-598EB78485C6" whose completed is false)'`
3. Si les dates ne sont pas données, prends la prochaine semaine du samedi au vendredi à partir d'aujourd'hui, et dis-le.

Puis propose le menu en tableau | Jour | Plat | Pour |, avec pour chaque plat sa protéine, son légume et son temps de préparation, et les plats longs signalés. Ensuite, on itère plat par plat. Ne génère le fichier de recettes qu'une fois tous les plats validés.
