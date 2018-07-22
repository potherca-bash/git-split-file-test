# Git Split File Test Fixtures

Fixtures for the git split repository tests.

## Introduction

This repository contains the full text of the childrens book "Winnie the pooh".

The original text format has been converted to HTML.

For the git-split tests, this HTML is to be split into separate HTML files, one
per chapter. (See the `source` directory).

There are two split-strategies that can be applied to the source-file:

- DELETE Remove the source-file after the split has run
- MOVE   Replace the content of the source-file with that of the similarly
         named file in the target-path.

A separate branch exists with the desired result of each strategy.

Run the following command to run the tests:

    bash run-tests.sh

The script uses the `git-split-file` command. To change the (path to the)
executable, use the `GIT_SPLIT_FILE` environmental variable:

    GIT_SPLIT_FILE=/path/to/git-split-file.sh bash run-tests.sh

