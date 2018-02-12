#!/bin/bash
#title           :basic_config.sh
#description     :This script will help you with some useful git commands
#author          :ShirishRam
#date            :2017-09-27
#version         :0.1
#usage           :NA
#notes           :The contents in this file is only for your guide. You cannot execute this script directly.
#bash_version    :NA
#==============================================================================

#Rename a commit
git commit --amend

#Cherry pick commits
git cherry-pick <commit-id>

#View git log with text based graph of commits on left side, like you see on github/ bitbucket
git log --graph

#Cache git credential for a day
git config --global credential.helper 'cache --timeout=86400'

#Remove all deleted files from git cache: 
git ls-files --deleted -z | xargs -0 git rm

#Custom git commands aliases
#Paste the below configurations in your ~/.gitconfig
[alias]
        st = status
        cm = commit -m
        ps = push origin
        pl = pull origin
        ch = checkout
        me = merge
