#!/bin/sh

# This script is using git-format-staged and swiftformat from SPM
# https://github.com/hallettj/git-format-staged << recommend from swiftformat readme

# https://stackoverflow.com/questions/51074821/git-hooks-doesnt-work-on-source-tree?answertab=active#tab-top
export PATH=/usr/local/bin:$PATH

echo "Execute from `pwd`"

command -v git-format-staged > /dev/null || { echo 'git-format-staged missing, install it now'; npm install -g git-format-staged; }

# use prebuilt binary if one exists, preferring release
builds=( '.build/release/swiftformat' '.build/debug/swiftformat' )
for build in ${builds[@]} ; do
  if [[ -e $build ]] ; then
    swiftformat=$build
    break
  fi
done
# fall back to using 'swift run' if no prebuilt binary found
swiftformat=${swiftformat:-'swift run swiftformat'}

# formatter will apply fix directly to staged file
format_cmd="git-format-staged --formatter '$swiftformat --config .swiftformat stdin' '*.swift'"

echo "${format_cmd}"
eval ${format_cmd};