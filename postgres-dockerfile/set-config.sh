#!/bin/sh

sed -i 's/shared_buffers = 128MB/shared_buffers = 512MB/g' /var/lib/postgresql/data/postgresql.conf
