#!/bin/bash

set -e
set -x

vagrant up

export KUBECONFIG=$(pwd)/kubeconfig

K8S_VERSION=v1.17.2

sleep 30s #Yeah, crappy but'll do for now
while read line; do
	echo $line
	nstatus=$(echo $line | awk '{print $2}')
	nversion=$(echo $line | awk '{print $5}')

	[[ $nstatus = "Ready" ]]
	[[ $nversion = $K8S_VERSION ]]

done <<< $(kubectl get nodes --no-headers)

vagrant destroy -f

