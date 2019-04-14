#!/bin/bash

tar -C context -cf - .|docker build -t andzuc/gentoo-tc:armv6z-hardfloat-linux-gnueabi -
