#!/bin/sh

# This script is using git-format-staged and swiftlint from SPM
# https://github.com/hallettj/git-format-staged << recommend from swiftlint readme

# https://stackoverflow.com/questions/51074821/git-hooks-doesnt-work-on-source-tree?answertab=active#tab-top
export PATH=/usr/local/bin:$PATH

echo "Execute from `pwd`"

command -v git-format-staged > /dev/null || { echo 'git-format-staged missing, install it now'; npm install -g git-format-staged; }

# use prebuilt binary if one exists, preferring release
builds=( '.build/release/swiftlint' '.build/debug/swiftlint' )
for build in ${builds[@]} ; do
  if [[ -e $build ]] ; then
    swiftlint=$build
    break
  fi
done
# fall back to using 'swift run' if no prebuilt binary found
swiftlint=${swiftlint:-'swift run swiftlint'}

# formatter will apply fix directly to staged file
format_cmd="git-format-staged --no-write --formatter '$swiftlint --config .swiftlint.yml --reporter emoji --path '{}'' '*.swift'"

echo "${format_cmd}"
eval ${format_cmd};