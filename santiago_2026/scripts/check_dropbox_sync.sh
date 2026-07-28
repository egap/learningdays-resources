#!/bin/sh
# Report drift between the workshop Dropbox and this hub site during the
# course week (Jul 27-31, 2026). Read-only: it copies nothing, so the
# curated exclusions in ROUTING.md (participant data, photos, readings)
# stay excluded no matter what appears in Dropbox. Run from santiago_2026/.
#
#   sh scripts/check_dropbox_sync.sh
#
# Two reports:
#   1. STALE  -- a file we copied from Dropbox changed at the source.
#      (slides/4-3-transparency_sp.pdf is intentionally ours: the repo copy
#      is a newer Quarto render, so it is skipped below.)
#   2. NEW    -- a file in the 2026 folders that has no copy here yet.
#      Decide per file: lecture decks usually come in; anything built from
#      participant data (names, photos, responses) stays out.

set -u

ROOT="$HOME/Dropbox/Training/2026_LD_LATAM_Shared_Docs/2026 LD Workshop Materials Participants"
OLD="$ROOT/2025 Materials"
NEW="$ROOT/2026 LD Workshop Materials Participants"

drift=0

# --- 1. Files copied from the 2025 materials: flag source-side edits. ---
# Pairs are "dropbox-path relative to $OLD | repo path"; from ROUTING.md.
while IFS='|' read -r db rp; do
  [ -z "$db" ] && continue
  if [ ! -f "$OLD/$db" ]; then
    echo "GONE FROM DROPBOX: $db"
    drift=1
  elif [ "$(md5 -q "$OLD/$db")" != "$(md5 -q "$rp")" ]; then
    echo "STALE (source changed): $db -> $rp"
    drift=1
  fi
done <<'PAIRS'
Slides/1-1-theory.pdf|slides/1-1-theory.pdf
Slides/1-2-causal-inference.pdf|slides/1-2-causal-inference.pdf
Slides/2-1-randomization-slides.pdf|slides/2-1-randomization-slides.pdf
Slides/2-2-Design talk_2025.pdf|slides/2-2-design-talk-2025.pdf
Slides/2-3-HypothesisTesting_2025.pdf|slides/2-3-HypothesisTesting_2025.pdf
Slides/1-3-threats.pdf|slides/1-3-threats.pdf
Slides/4-1-ethics-slides_sp.pdf|slides/4-1-ethics-slides_sp.pdf
Slides/TA-rsession1.pdf|r_sessions/TA-rsession1.pdf
R Sessions/activity1-basics.R|r_sessions/activity1-basics.R
R Sessions/activity2-randomization.R|r_sessions/activity2-randomization.R
R Sessions/activity3-estimation.R|r_sessions/activity3-estimation.R
R Sessions/activity5-estimation.R|r_sessions/activity5-estimation.R
R Sessions/act3.R|r_sessions/act3.R
R Sessions/data_for_analysis.csv|r_sessions/data_for_analysis.csv
PAIRS

# --- 2. New 2026 material with no copy here yet. ---
# A Dropbox file is "known" if some tracked repo file has the same md5;
# this survives the renames we apply (spaces -> dashes). Junk and
# participant-data files we will never publish are filtered by name.
repo_sums=$(find slides r_sessions forms assets -type f \
  \( -name '*.pdf' -o -name '*.pptx' -o -name '*.Rmd' -o -name '*.R' \) \
  -exec md5 -q {} \; | sort -u)

# Never publishable: the 0 - Intro welcome deck and its participant photos,
# the live-randomization sheet (participant names), the photo roster.
# Reviewed and dismissed (drop a line here when a new item is dealt with):
# the 27-Jul agenda exports (site Programa tables checked against them
# 2026-07-27) and the Friday folder's outdated Montevideo-era duplicates of
# the formato files (the Day 2 versions are the ones copied here).
new_report=$(find "$NEW/Slides" "$NEW/Agenda" "$NEW/Participants' Presentations Friday" \
    -type f 2>/dev/null \
  | grep -viE '\.(DS_Store|Rhistory|log|aux)$|~\$|\.Rproj\.user|/0 - Intro/|LD_experiment|Photo Roster' \
  | grep -viE 'Agenda/LD_LATAM_Agenda_2026(_27-Jul-26)?\.(pdf|docx|xlsx)$' \
  | grep -viE "Presentations Friday/formato_presentacion(_powerpoint)?\.(Rmd|pptx)$" \
  | while read -r f; do
      if ! printf '%s\n' "$repo_sums" | grep -q "$(md5 -q "$f")"; then
        echo "NEW IN DROPBOX: ${f#"$ROOT/"}"
      fi
    done)

if [ -n "$new_report" ]; then
  printf '%s\n' "$new_report"
  drift=1
fi

[ "$drift" -eq 0 ] && echo "In sync: no source-side changes, no unseen 2026 files."
