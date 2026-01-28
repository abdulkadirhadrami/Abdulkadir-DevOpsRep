#!/bin/bash

# ========== CONFIG ==========
# Ku qor sida: OWNER/REPO
REPO="abdulkadirhadrami/Abdulkadir-DevOpsRep"

# Hubi token
if [ -z "$GITHUB_TOKEN" ]; then
  echo "❌ GITHUB_TOKEN lama helin. Fadlan export samee."
  exit 1
fi

echo "📌 Listing Pull Requests for $REPO ..."
echo "--------------------------------------"

# ========== API CALL ==========
response=$(curl -s \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  "https://api.github.com/repos/$REPO/pulls?state=all")

# ========== PARSE ==========
prs=$(echo "$response" | jq -r '
  if type=="array" then
    .[] |
    "PR #\(.number) | \(.state) | \(.title) | by \(.user.login)"
  else
    "⚠️ API error or no pull requests"
  end
')

# ========== OUTPUT ==========
echo "$prs"
