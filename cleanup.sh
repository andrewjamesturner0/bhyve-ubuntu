#!/bin/bash

source common

sudo bhyvectl --destroy --vm="$_HOSTNAME"
