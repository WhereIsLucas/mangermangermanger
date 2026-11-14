---
description: Envoyer la liste de courses d'une semaine dans Rappels
argument-hint: [fichier de la semaine, par défaut le plus récent]
---

Envoie la liste de courses dans la liste Rappels « Courses ».

1. Fichier : $ARGUMENTS ; si vide, le fichier `semaines/AAAA-MM-JJ — *.md` le plus récent (dernier par ordre alphabétique, hors `_modele.md`).
2. Extrais les articles de la section « Liste de courses » : sections 🥩 Boucherie et 🛒 Supermarché uniquement (pas l'épicerie asiatique, sauf si Lucas le demande). Un article par ligne, avec la quantité totale, sans le repas entre parenthèses. Exemple : « 400 g de bœuf haché ». Fusionne les doublons.
3. Lance d'abord `scripts/courses-rappels.sh --dry-run` avec les articles sur stdin, puis montre le résultat à Lucas.
4. Après confirmation, relance sans `--dry-run`. Le script ne supprime rien et ignore les articles déjà présents.
