../compile.sh -d [recency_uganda_prod_analysis_test] -s staging/sp_makefile -k staging -c sp

../compile.sh -d [recency_uganda_prod_analysis_test] -s base/sp_makefile -k base -c sp

../compile.sh -d [recency_uganda_prod_analysis_test] -v base/vw_makefile -k base

../compile.sh -d [recency_uganda_prod_analysis_test] -s derived_recency/sp_makefile -k derived_recency -c sp

../compile.sh -d [recency_uganda_prod_analysis_test] -s sp_makefile -k dbo

../compile.sh -d [recency_uganda_prod_analysis_test] -v vw_makefile -k base

cat staging/build/create_stored_procedures.sql base/build/create_stored_procedures.sql derived_recency/build/create_stored_procedures.sql build/create_stored_procedures.sql > build/create_stored_procedures_all.sql