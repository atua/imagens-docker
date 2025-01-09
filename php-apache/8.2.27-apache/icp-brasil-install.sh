#!/bin/bash

ARQUIVO="ACcompactado.zip"

cd /usr/local/share/ca-certificates

rm -f $ARQUIVO
if wget --no-check-certificate -O $ARQUIVO https://acraiz.icpbrasil.gov.br/credenciadas/CertificadosAC-ICP-Brasil/$ARQUIVO; then
  unzip -o $ARQUIVO
  update-ca-certificates
fi
