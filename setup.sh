#!/bin/sh

echo "Checking out libopencm3..."
git submodule update --init

echo "Building libopencm3..."
make --no-print-directory -C libopencm3

