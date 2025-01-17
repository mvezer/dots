#!/usr/bin/zsh

function draw_line {
  printf %"$COLUMNS"s |tr " " "${1:--}"
}

function .. {
  cd ..
}

function ... {
  cd ../..
}

function .... {
  cd ../../..
}
