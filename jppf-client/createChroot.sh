#!/bin/bash
OLYMPUS_ROOT="/opt/openolympus/"
JPPF_ROOT="/opt/jppf/"
JPPF_SERVER_ROOT="${JPPF_ROOT}/server"
OLYMPUS_CONFIG="/opt/openolympus/openolympus.properties"
CHROOT_TEMPLATE="/usr/chroot"
STORAGE_PATH="${OLYMPUS_ROOT}/storage"

function copyDependencies {
	ldd $1
	FILES=$(ldd $1 | xargs -L1 | perl -n -e '/\s*(?:[a-zA-Z\.\-_0-9]+\s*=>\s*)?\s*([^=>]*) \([0-9a-zA-Z]+\)/ && print $1, "\n"' | xargs -L1 | sed -e 's/^ *//' -e 's/ *$//')
	for file in $FILES; do
		echo "Copying ${file} to ${CHROOT_TEMPLATE}/${file}"
		mkdir -p $(dirname "${CHROOT_TEMPLATE}/${file}")
		cp "${file}" "${CHROOT_TEMPLATE}/${file}"
	done
}

function createChrootTemplate {
	rm -rf "${CHROOT_TEMPLATE}"

	mkdir -p "${CHROOT_TEMPLATE}"

	mkdir -p "${CHROOT_TEMPLATE}/bin" "${CHROOT_TEMPLATE}/dev" "${CHROOT_TEMPLATE}/etc" "${CHROOT_TEMPLATE}/etc/pam.d" "${CHROOT_TEMPLATE}/lib/x86_64-linux-gnu" "${CHROOT_TEMPLATE}/lib64" "${CHROOT_TEMPLATE}/lib/security" "${CHROOT_TEMPLATE}/var" "${CHROOT_TEMPLATE}/var/log" "${CHROOT_TEMPLATE}/usr" "${CHROOT_TEMPLATE}/usr/bin" "${CHROOT_TEMPLATE}/usr/lib"


	TMP_DIR=$(mktemp -dt "XXXXX")
	pushd . > /dev/null

		cd "${TMP_DIR}"

	cat > "test.cpp" <<EOF
#include <vector>
#include <iostream>
int main() {
	std::vector<int> v;
	v.push_back(0);
	std::cout<<"hi";
	return 0;
}
EOF

		g++ test.cpp
		copyDependencies ./a.out

	popd > /dev/null
}
createChrootTemplate

git clone https://github.com/nickguletskii/OpenOlympus-Watchdog.git
cd OpenOlympus-Watchdog
cmake -G "Unix Makefiles"
make all
make install
