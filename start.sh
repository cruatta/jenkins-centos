#!/bin/bash
service jenkins start
while [[ $(service jenkins status) ]]; do
	sleep 5
done
