#!/bin/bash
set -ev

export PROJECT_NAME='Telepharo'

PHARO[0]=70
PHARO[1]=80
PHARO[2]=90

export ARCH_32=true
export ARCH_64=true

export PHARO_SCRIPT="Iceberg enableMetacelloIntegration: false.

Metacello new
	baseline: 'TelePharo';
	repository: 'github://pharo-ide/TelePharo';
	load: #(Client Server).			
Smalltalk saveSession.

Iceberg enableMetacelloIntegration: true."