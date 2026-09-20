#!/bin/bash
# Deploy the self-contained profile README (images embedded, no assets/ folder needed)
# Usage: place this script next to README.md, then run: bash setup.sh

set -e

GITHUB_USER="dhia-ui"
REPO_DIR="${GITHUB_USER}-profile-readme"

echo "==> Cloning your profile repo (github.com/${GITHUB_USER}/${GITHUB_USER})..."
git clone "https://github.com/${GITHUB_USER}/${GITHUB_USER}.git" "$REPO_DIR" || {
  echo "Repo doesn't exist yet. Create it first:"
  echo "  1. Go to https://github.com/new"
  echo "  2. Repository name MUST be exactly: ${GITHUB_USER}"
  echo "  3. Make it Public, check 'Add a README file', then create it."
  echo "  4. Re-run this script."
  exit 1
}

echo "==> Copying README in (self-contained, no assets/ folder needed)..."
cp README.md "${REPO_DIR}/README.md"

cd "$REPO_DIR"
# clean up the old assets folder if a previous version left one behind
if [ -d "assets" ]; then
  git rm -r assets --quiet || true
fi

echo "==> Committing and pushing..."
git add -A
git commit -m "Self-contained README: embed visuals as base64 to fix broken images"
git push origin main || git push origin master

echo "==> Done. Check https://github.com/${GITHUB_USER}"
