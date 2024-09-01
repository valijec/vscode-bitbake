#!/bin/bash

# Tag: yocto-5.0.3
BITBAKE_DOCS_COMMIT=11d83170922a2c6b9db1f6e8c23e533526984b2c
    (cherry picked from commit 1e6f862864539d6f6a0bea3e4479e0dd40ff3091)
# Tag: yocto-5.0.3
YOCTO_DOCS_COMMIT=09e321d7cbd5bd7071a0c138e6d0c424fb086269
+-  Git Revision: :yocto_git:`f7def85be9f99dcb4ba488bead201f670304379b </poky/commit/?id=f7def85be9f99dcb4ba488bead201f670304379b>`
+-  Git Revision: :oe_git:`803cc32e72b4fc2fc28d92090e61f5dd288a10cb </openembedded-core/commit/?id=803cc32e72b4fc2fc28d92090e61f5dd288a10cb>`
+-  Git Revision: :yocto_git:`acbba477893ef87388effc4679b7f40ee49fc852 </meta-mingw/commit/?id=acbba477893ef87388effc4679b7f40ee49fc852>`
+-  Git Revision: :oe_git:`8714a02e13477a9d97858b3642e05f28247454b5 </bitbake/commit/?id=8714a02e13477a9d97858b3642e05f28247454b5>`
+-  Git Revision: :yocto_git:`875dfe69e93bf8fee3b8c07818a6ac059f228a13 </yocto-docs/commit/?id=875dfe69e93bf8fee3b8c07818a6ac059f228a13>`

BITBAKE_DOCS_LIST="bitbake-user-manual-metadata.rst bitbake-user-manual-ref-variables.rst"
YOCTO_DOCS_LIST=" tasks.rst variables.rst"

set -e
cd "$(dirname "$(readlink -f "$0")")/.."

mkdir -p server/resources/docs
#  Bitbake docs
git clone --depth 1 --filter=blob:none --sparse https://github.com/openembedded/bitbake.git
cd bitbake
git sparse-checkout set doc/bitbake-user-manual/
git fetch origin
git checkout $BITBAKE_DOCS_COMMIT
cd doc/bitbake-user-manual/
mv $BITBAKE_DOCS_LIST  ../../../server/resources/docs
cd ../../../
rm -rf bitbake

# Yocto docs
git clone --depth 1 --filter=blob:none --sparse https://git.yoctoproject.org/yocto-docs
cd yocto-docs
git sparse-checkout set documentation/ref-manual
git fetch origin
git checkout $YOCTO_DOCS_COMMIT
cd documentation/ref-manual
mv $YOCTO_DOCS_LIST ../../../server/resources/docs
cd ../../../
rm -rf yocto-docs

# This line is added to let the last task in tasks.rst get matched by the regex in doc scanner
echo "\n.. _ref-dummy-end-for-matching-do-validate-branches:" >> server/resources/docs/tasks.rst
