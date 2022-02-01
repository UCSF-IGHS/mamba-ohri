../compile.sh -d analysis -s base/sp_makefile
../compile.sh -d analysis -s derived_hts/sp_makefile
../compile.sh -d analysis -s sp_makefile

cat base/build/create_stored_procedures.sql derived_hts/build/create_stored_procedures.sql build/create_stored_procedures.sql > build/create_stored_procedures_all.sql