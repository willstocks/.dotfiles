#!/bin/bash

current=$1
current_plus=$(($current + 10))
current_minus=$(($current - 10))

if (($current > 90))
then
	brightnessctl set $current_minus%
else
	brightnessctl set $current_plus%
fi
