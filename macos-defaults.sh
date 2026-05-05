#!/usr/bin/env bash

defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXDefaultSearchScope -string SCcf
killall Finder

defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock autohide -bool true
killall Dock

mkdir -p "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots"
killall SystemUIServer
