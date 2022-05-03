#!/bin/bash
sudo mount -t tmpfs -o size=384m tmpfs ./dasd
sudo chown -R `whoami` ./dasd
df -h | grep dasd
