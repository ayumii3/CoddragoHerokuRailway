#!/bin/bash

# Habilitando overcommit_memory
sysctl vm.overcommit_memory=1

# Iniciando o aplicativo
python3 -m hikka