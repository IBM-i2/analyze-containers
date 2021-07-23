#!/usr/bin/env bash
# MIT License
#
# Copyright (c) 2021, IBM Corporation
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
set -e

###############################################################################
# Etl variables                                                               #
###############################################################################
BASE_DATA="law-enforcement-data-set-1"
STAGING_SCHEMA="IS_STAGING"
IMPORT_MAPPING_FILE="/var/i2a-data/${BASE_DATA}/mapping.xml"

###############################################################################
# Constants                                                                   #
###############################################################################
# Array for base data tables to csv and format file names
BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME=base_data_table_to_csv_and_format_file_name_map_
map_put "$BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME" "E_Account" "account"
map_put "$BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME" "E_Address" "address"
map_put "$BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME" "E_Communications_D" "telephone"
map_put "$BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME" "E_Event" "event"
map_put "$BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME" "E_Organization" "organisation"
map_put "$BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME" "E_Person" "person"
map_put "$BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME" "E_Property" "property"
map_put "$BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME" "E_Vehicle" "vehicle"
map_put "$BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME" "L_Access_To_Org_Acc" "organisation_accessto_account"
map_put "$BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME" "L_Access_To_Org_Add" "organisation_accessto_address"
map_put "$BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME" "L_Access_To_Per_Acc" "person_accessto_account"
map_put "$BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME" "L_Access_To_Per_Add" "person_accessto_address"
map_put "$BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME" "L_To_Org_Own_Veh" "organisation_accessto_vehicle"
map_put "$BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME" "L_To_Per_Own_Tel" "person_owner_accessto_telephone"
map_put "$BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME" "L_To_Per_Own_Veh" "person_owner_acessto_vehicle"
map_put "$BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME" "L_To_Per_Sh_Org" "person_shareholder_accessto_organisation"
map_put "$BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME" "L_Associate" "person_association_person"
map_put "$BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME" "L_Communication" "telephone_calls_telephone"
map_put "$BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME" "L_Employment" "person_employedby_organisation"
map_put "$BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME" "L_Involved_In_Eve_Per" "event_involvedin_person"
map_put "$BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME" "L_Transaction" "account_transaction_account"

# Import IDs used for ingestion with BULK import mode
BULK_IMPORT_MAPPING_IDS=( 
  "Account" "Address" "Telephone" "Event" "Organisation" "Person" "Property" "Vehicle" "AccessToOrgAcc" "AccessToOrgAdd" "AccessToPerAcc" "AccessToPerAdd" "AccessToOrgOwnVeh" "AccessToPerOwnTel" "AccessToPerOwnVeh" "AccessToPerShOrg" "Associate" "Communication" "Employment" "InvolvedInEvePer" "Transaction" 
)

###############################################################################
# Ingesting base data                                                         #
###############################################################################
print "Inserting data into the staging tables"
# To stop the variables being evaluated in this script, the variables are escaped using backslashes (\) and surrounded in double quotes (").
# Any double quotes in the curl command are also escaped by a leading backslash.
for table_name in $(map_keys "${BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME}"); do
  csv_and_format_file_name=$(map_get "${BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME}" "${table_name}")
  sql_query="\
    BULK INSERT ${STAGING_SCHEMA}.${table_name} \
    FROM '/var/i2a-data/${BASE_DATA}/${csv_and_format_file_name}.csv' \
    WITH (FORMATFILE = '/var/i2a-data/${BASE_DATA}/sqlserver/format-files/${csv_and_format_file_name}.fmt', FIRSTROW = 2)"
  runSQLServerCommandAsETL runSQLQueryForDB "${sql_query}" "${DB_NAME}"
done

for import_id in "${BULK_IMPORT_MAPPING_IDS[@]}"; do
  runEtlToolkitToolAsi2ETL bash -c "/opt/ibm/etltoolkit/ingestInformationStoreRecords \
    --importMappingsFile ${IMPORT_MAPPING_FILE} \
    --importMappingId ${import_id} \
    -importMode BULK"
done

###############################################################################
# Truncating the staging tables                                               #
###############################################################################
print "Truncating the staging tables"
for table_name in $(map_keys "${BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME}"); do
  csv_and_format_file_name=$(map_get "${BASE_DATA_TABLE_TO_CSV_AND_FORMAT_FILE_NAME}" "${table_name}")
  sql_query="TRUNCATE Table ${STAGING_SCHEMA}.${table_name}"
  runSQLServerCommandAsETL runSQLQueryForDB "${sql_query}" "${DB_NAME}"
done