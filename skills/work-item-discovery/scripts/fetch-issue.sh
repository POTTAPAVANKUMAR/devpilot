#!/usr/bin/env bash
# fetch-issue.sh - Fetch GitHub issue via gh CLI or GitHub REST API
set -euo pipefail

ISSUE_INPUT="${1:-}"

if [ -z "$ISSUE_INPUT" ]; then
  echo "Usage: $0 <issue_number_or_url>"
  exit 1
fi

# Strip non-digits if just issue number passed
ISSUE_NUM=$(echo "$ISSUE_INPUT" | sed -E 's/.*issues\/([0-9]+).*/\1/' | sed -E 's/[^0-9]//g')

if command -v gh &>/dev/null; then
  gh issue view "$ISSUE_NUM" --json number,title,body,labels,assignees,state,createdAt
else
  # Fallback to git remote origin + curl
  REMOTE_URL=$(git config --get remote.origin.url || true)
  if [[ "$REMOTE_URL" =~ github\.com[:/]([^/]+)/([^/.]+) ]]; then
    OWNER="${BASH_REMATCH[1]}"
    REPO="${BASH_REMATCH[2]}"
    AUTH_HEADER=()
    if [ -n "${GITHUB_TOKEN:-}" ]; then
      AUTH_HEADER=(-H "Authorization: Bearer $GITHUB_TOKEN")
    fi
    curl -s "${AUTH_HEADER[@]}" "https://api.github.com/repos/$OWNER/$REPO/issues/$ISSUE_NUM"
  else
    echo "Error: gh CLI not found and unable to parse GitHub repository remote." >&2
    exit 1
  fi
fi
