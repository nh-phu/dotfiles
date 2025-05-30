#!/bin/bash


if mullvad status | grep -q "Connected"; then
    status=$(mullvad status | grep -oP 'Connected' )
    echo "status"
else
  echo "Not connected"
fi
