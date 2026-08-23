#!/usr/bin/env bash
# Repo açıklamalarını ve profil website alanını toplu uygular.
#
#   GITHUB_TOKEN=ghp_xxx ./apply.sh
#
# Token'a "repo" yetkisi yeterli. Token hiçbir yere yazılmaz, sadece bu
# oturumda kullanılır. Sadece açıklama alanını değiştirir; kod, ayar,
# görünürlük gibi hiçbir şeye dokunmaz.
set -euo pipefail

: "${GITHUB_TOKEN:?GITHUB_TOKEN verilmedi. Kullanım: GITHUB_TOKEN=ghp_xxx ./apply.sh}"
U=muratozturk4u

ayarla() {
  local repo="$1" aciklama="$2"
  local kod
  kod=$(curl -s -o /dev/null -w '%{http_code}' -X PATCH \
    -H "Authorization: Bearer $GITHUB_TOKEN" \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/$U/$repo" \
    -d "$(python3 -c 'import json,sys; print(json.dumps({"description": sys.argv[1]}))' "$aciklama")")
  printf '  %-34s HTTP %s\n' "$repo" "$kod"
}

echo "Açıklamalar yazılıyor:"
ayarla dev-activity                     "Measures real commit activity from local git history — private repositories included, aggregate numbers only"
ayarla LinguaSign                       "Sign language translation and learning assistant — CNN+LSTM, MediaPipe and Transformer approaches compared"
ayarla LexoRead                         "Reading assistant for dyslexia — summaries adapted to the reader's level, emotion-aware TTS (BART + T5)"
ayarla Audio-AI-Transformer-Comparison  "Benchmarks four speech transformers on the same task: HuBERT, wav2vec, WavLM and data2vec"
ayarla Emotion-Audio-Classifier         "Speech dataset builder for emotion analysis — downloads audio, trims silence, sorts into classes"
ayarla otonom-revenue-no-human-company  "Research and architecture for an autonomous multi-agent revenue pipeline for charities"
ayarla FilmWebApi                       "Film browsing and watchlist API — ASP.NET Core, layered architecture, EF Core, SQL Server"
ayarla MarketAutomationWebApp           "Retail management system: customers, products, sales and stock. Java Spring + MySQL"
ayarla PomodoroApp                      "Pomodoro timer for Android, written in Kotlin"

echo
echo "Profil website alanı:"
kod=$(curl -s -o /dev/null -w '%{http_code}' -X PATCH \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/user \
  -d '{"blog":"https://code-pulse-ledger.lovable.app/"}')
printf '  %-34s HTTP %s\n' "blog alanı" "$kod"

echo
echo "Pinned repo'lar API ile ayarlanamıyor — profil sayfandan"
echo "'Customize your pins' ile elle seç. Öneri repo-aciklamalari.md içinde."
