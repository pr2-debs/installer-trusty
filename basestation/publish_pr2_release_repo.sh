#!/bin/bash
# TODO add generic release number

sudo aptly publish snapshot trusty-release-0.9.2
sudo aptly serve
