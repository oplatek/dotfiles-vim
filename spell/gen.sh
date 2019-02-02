#!/bin/sh

set -e

wget http://ftp.services.openoffice.org/pub/OpenOffice.org/contrib/dictionaries/cs_CZ.zip
unzip cs_CZ.zip

# UTF-8
vim -u NONE -e -c "set enc=utf-8" -c "mkspell! cs cs_CZ" -c q

# ASCII + UTF-8: we need unmunch, which is part of hunspell-tools.
unmunch cs_CZ.dic cs_CZ.aff > cs_CZ.words
(cstocs il2 utf8 cs_CZ.words; cstocs il2 ascii cs_CZ.words) | sort -u > csa_CZ.words
vim -u NONE -e -c "set enc=utf-8" -c "mkspell! csa csa_CZ.words" -c q
