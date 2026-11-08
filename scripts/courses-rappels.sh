#!/bin/zsh
# Ajoute des articles à la liste « Courses » de Rappels.
# Usage : scripts/courses-rappels.sh < articles.txt   (un article par ligne)
#         scripts/courses-rappels.sh --dry-run < articles.txt
# - ignore les lignes vides et les commentaires (#)
# - n'ajoute pas un article déjà présent (non coché) dans la liste, insensible à la casse
# - ne supprime ni ne coche jamais rien

set -euo pipefail

LIST_ID="9F1B5D3F-771B-46DA-8BFC-6F5BF6837F11"
DRY_RUN=0
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=1

items=()
while IFS= read -r line || [[ -n "$line" ]]; do
  line="${line#"${line%%[![:space:]]*}"}"   # trim début
  line="${line%"${line##*[![:space:]]}"}"   # trim fin
  line="${line#- }"                          # tolère les puces markdown
  [[ -z "$line" || "$line" == \#* ]] && continue
  items+=("$line")
done

(( ${#items} == 0 )) && { echo "Aucun article reçu." >&2; exit 1; }

osascript - "$LIST_ID" "$DRY_RUN" "${items[@]}" <<'APPLESCRIPT'
on run argv
  set listId to item 1 of argv
  set dryRun to (item 2 of argv) is "1"
  set newItems to items 3 thru -1 of argv
  set added to {}
  set skipped to {}
  tell application "Reminders"
    set theList to list id listId
    set existing to name of (reminders of theList whose completed is false)
    repeat with anItem in newItems
      set itemName to contents of anItem
      set isDup to false
      ignoring case
        repeat with e in existing
          if (contents of e) is itemName then set isDup to true
        end repeat
      end ignoring
      if isDup then
        set end of skipped to itemName
      else
        if not dryRun then make new reminder at end of theList with properties {name:itemName}
        set end of added to itemName
        set end of existing to itemName
      end if
    end repeat
  end tell
  set AppleScript's text item delimiters to linefeed & "  + "
  set out to "Ajoutés (" & (count of added) & ") :" & linefeed & "  + " & (added as text)
  set AppleScript's text item delimiters to linefeed & "  = "
  if (count of skipped) > 0 then set out to out & linefeed & "Déjà dans la liste (" & (count of skipped) & ") :" & linefeed & "  = " & (skipped as text)
  if dryRun then set out to "[dry-run, rien n'a été ajouté]" & linefeed & out
  return out
end run
APPLESCRIPT
