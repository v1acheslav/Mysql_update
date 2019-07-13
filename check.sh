#!/bin/bash

for ctid in `vzlist -1 | awk '{print $1}'`; do
  if vzctl exec2 $ctid mysql --version | grep -q 'Ver 14.14 Distrib 5.5.'; then
    echo "True"

  else
    echo "False"




  fi
done
