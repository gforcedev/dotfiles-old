#!/bin/bash
# fd - cd to selected directory
fd() {
  local dir
  dir=$(rg --hidden --files --null | xargs -0 dirname | uniq | fzf) &&
  cd "$dir"
}
