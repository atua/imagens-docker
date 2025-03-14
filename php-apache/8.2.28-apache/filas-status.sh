#!/bin/bash

if service supervisor status >/dev/null 2>&1; then
  supervisorctl status
else
  echo 'service supervisor is not running'
fi
