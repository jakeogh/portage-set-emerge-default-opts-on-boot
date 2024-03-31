#!/usr/bin/env bash
echo '\n' '\x00'
exit 1
#!/bin/sh

set -o nounset
set -o errexit
set -o pipefail

# https://wiki.gentoo.org/wiki/CPU_FLAGS_*
target="/etc/portage/cpu_flags.conf"
cpu_flags=$(cpuid2cpuflags | cut -d ":" -f 2- | cut -c 2-)
echo -e "# THIS FILE IS AUTOMATICALLY GENERATED BY ${0}\n" > "${target}"
echo "CPU_FLAGS_X86=\"${cpu_flags}\"" >> "${target}"

source_line="source ${target}"
grep -E "^${source_line}$" /etc/portage/make.conf > /dev/null || { echo "${0}: ERROR, the line: \`${source_line}\` was not found in /etc/portage/make.conf" ; exit 1 ; }