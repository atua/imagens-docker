#!/bin/bash

service supervisor start
supervisorctl start filas:*
