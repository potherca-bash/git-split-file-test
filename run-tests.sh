#!/usr/bin/env bash

: "${GIT_SPLIT_FILE:=git-split-file}"

run-tests() {

    reset() {
        git checkout master
        git branch -D '01-starting-point'
        git checkout -b '01-starting-point'
    }

    diff-log() {
        local -r sStrategy="${1?One parameter required: <strategy-name>}"

        diff "strategy-${sStrategy}.log" "logs/strategy-${sStrategy}.log"
    }

    clean-up-log() {
        local -r sStrategy="${1?One parameter required: <strategy-name>}"

        sed -i -e 's/ [0-9a-f]\{7\}//' "strategy-${sStrategy}.log"
        sed -i -e "s:$PWD::" "strategy-${sStrategy}.log"
    }

    call-git-split() {
        local -r sStrategy="${1?One parameter required: <strategy-name>}"

        echo '' > "strategy-${sStrategy}.log"

        bash "${GIT_SPLIT_FILE}"    \
            ./index.html            \
            ./source/               \
            .                       \
            "${sStrategy}"          \
            | tee -a "strategy-${sStrategy}.log"
    }

    local -a -r aStrategies=( 'DELETE' 'MOVE' )

    reset

    for sStrategy in "${aStrategies[@]}";do
        call-git-split "${sStrategy}"

        echo -e "\n: GIT DIFF for ${sStrategy}"
        git diff "strategy-${sStrategy}"

        reset
    done

    for sStrategy in "${aStrategies[@]}";do
        clean-up-log "${sStrategy}"
        echo -e "\n: LOG DIFF for ${sStrategy}"
        diff-log "${sStrategy}"
    done

    # @FIXME: Write diff to file and check it is empty
}

run-tests
