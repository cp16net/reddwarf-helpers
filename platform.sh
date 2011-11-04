#!/bin/bash

function keystone_login {
    #curl -d '{"passwordCredentials": {"username": "admin", "password": "admin", "tenantId": "admin"}}' -H "Content-type: application/json" http://localhost:5000/v2.0/tokens | python -mjson.tool
    TOKEN=$(curl -d '{"passwordCredentials": {"username": "admin", "password": "admin", "tenantId": "admin"}}' -H "Content-type: application/json" http://localhost:5000/v2.0/tokens | python -mjson.tool | grep id | tr -s ' ' | cut -d ' ' -f 3 | sed s/\"/''/g)
    export TOKEN
    export TENANT=dbaas
    echo "TENANT = $TENANT"
    echo "TOKEN = $TOKEN"
}

keystone_login
#/src/bin/reddwarf-cli auth login admin admin admin
#alias rdcli=/src/bin/reddwarf-cli

function dbaas_login {
    output=$(curl -i -H "X-Auth-User: admin" -H "X-Auth-Key: admin" -H "X-Auth-Project-Id: admin" http://localhost:8775/v1.0/ | sed -n '/Token/p')
    echo "$output"
    token=`echo $output | awk -F": " '{print $2}'`
    export TOKEN=$token
    echo "TOKEN = $TOKEN"
}

function curl_call_json {
    curl -v -H "X-Auth-Token: $TOKEN" -H"X_AUTH_PROJECT_ID: $TENANT" $@  | python -mjson.tool
}

function list_version {
    #curl -H "X-Auth-Token: $TOKEN" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/ | python -mjson.tool
    curl_call_json http://localhost:8775/
    echo ""
}

function mgmt_get_hosts {
    curl -H "X-Auth-Token: $TOKEN" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/mgmt/hosts | python -mjson.tool
    echo ""
}

function mgmt_get_storage {
    curl -H "X-Auth-Token: $TOKEN" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/mgmt/storage | python -mjson.tool
    echo ""
}

function mgmt_get_account {
    curl -H "X-Auth-Token: $TOKEN" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/mgmt/accounts/$1 | python -mjson.tool
    echo ""
}

function mgmt_get_hosts_xml {
    curl -H "X-Auth-Token: $TOKEN" -H "Accept: application/xml" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/mgmt/hosts
    echo ""
}

function list_instance_xml {
    curl -H "X-Auth-Token: $TOKEN" -H "Accept: application/xml" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/mgmt/instances/$1
    echo ""
}

function list_instance {
    curl -H "X-Auth-Token: $TOKEN" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/mgmt/instances/$1 | python -mjson.tool
    echo ""
}

function list_host {
    curl -H "X-Auth-Token: $TOKEN" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/mgmt/hosts/$1
    echo ""
}

function list_host_xml {
    curl -H "X-Auth-Token: $TOKEN" -H "Accept: application/xml" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/mgmt/hosts/$1
    echo ""
}

function list_images {
    curl -H "X-Auth-Token: $TOKEN" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/images/detail
    echo ""
}

function list_images_xml {
    curl -H "X-Auth-Token: $TOKEN" -H "Accept: application/xml" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/images/detail
    echo ""
}

function list_flavor {
    curl -H "X-Auth-Token: $TOKEN" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/flavors/$1 
    echo ""
}

function list_flavor_xml {
    curl -H "X-Auth-Token: $TOKEN" -H "Accept: application/xml" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/flavors/$1
    echo ""
}

function list_flavor_detail {
    curl -H "X-Auth-Token: $TOKEN" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/flavors/detail/$1
    echo ""
}

function list_flavors {
    curl -H "X-Auth-Token: $TOKEN" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/flavors | python -mjson.tool
    echo ""
}

function list_flavors_detail_xml {
    curl -H "X-Auth-Token: $TOKEN" -H "Accept: application/xml" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/flavors
    echo ""
}

function list_flavors_detail {
    curl -H "X-Auth-Token: $TOKEN" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/flavors/detail | python -mjson.tool
    echo ""
}

function list_flavors_detail_xml {
    curl -H "X-Auth-Token: $TOKEN" -H "Accept: application/xml" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/flavors/detail
    echo ""
}

function list_users {
    curl -H "X-Auth-Token: $TOKEN" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances/$1/users
    echo ""
}

function list_users_xml {
    curl -H "X-Auth-Token: $TOKEN" -H "Accept: application/xml" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances/$1/users
    echo ""
}

function list_databases {
    curl -H "X-Auth-Token: $TOKEN" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances/$1/databases
    echo ""
}

function list_databases_xml {
    curl -H "X-Auth-Token: $TOKEN" -H "Accept: application/xml" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances/$1/databases
    echo ""
}

function index_instances_xml {
    curl -H "X-Auth-Token: $TOKEN" -H "Accept: application/xml" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances
    echo ""
}

function detail_instances_xml {
    curl -H "X-Auth-Token: $TOKEN" -H "Accept: application/xml" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances/detail
    echo ""
}

function show_instance_xml {
    curl -H "X-Auth-Token: $TOKEN" -H "Accept: application/xml" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances/$1
    echo ""
}

function index_instances {
    curl -H "X-Auth-Token: $TOKEN" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances | python -mjson.tool
    echo ""
}

function detail_instances {
    curl -H "X-Auth-Token: $TOKEN" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances/detail | python -mjson.tool
    echo ""
}

function show_instance {
    curl -H "X-Auth-Token: $TOKEN" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances/$1 | python -mjson.tool
    echo ""
}

function create_instance_fail {
    JSON_DATA='{"instance"'':{"name":"'$1'","flavorRef":"http://localhost:8775/v1.0/flavors/'$2'","imageRef":"http://localhost:8775/v1.0/images/'$3'", "port":"3306", "dbtype":{"name": "mysql", "version":"5.1.2"}, "databases":[{"name":"testdb", "character_set":"utf8", "collate":"utf8_general_ci"}, {"name":"abfadklfgklq3u4q78tzdfjhvgajkdshfgjaef72346JKVFE4"}],"volume":{"size":""}}}'
    curl -H "X-Auth-Token: $TOKEN" -H"Content-Type: application/json" -d"$JSON_DATA" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances
    echo ""
}

function create_instance_fail_xml {
    JSON_DATA='{"instance"'':{"name":"'$1'","flavorRef":"http://localhost:8775/v1.0/flavors/'$2'","imageRef":"http://localhost:8775/v1.0/images/'$3'", "port":"3306", "dbtype":{"name": "mysql", "version":"5.1.2"}, "databases":[{"name":"testdb", "character_set":"utf8", "collate":"utf8_general_ci"}, {"name":"abfadklfgklq3u4q78tzdfjhvgajkdshfgjaef72346JKVFE4"}],"volume":{"size":""}}}'
    curl -H "X-Auth-Token: $TOKEN" -H"Content-Type: application/json" -d"$JSON_DATA" -H "Accept: application/xml" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances
    echo ""
}

function create_instance {
    JSON_DATA='{"instance"'':{"name":"'$1'","flavorRef":"http://localhost:8775/v1.0/flavors/'$2'","imageRef":"http://localhost:8775/v1.0/images/'$3'", "port":"3306", "dbtype":{"name": "mysql", "version":"5.1.2"}, "databases":[{"name":"testdb", "character_set":"utf8", "collate":"utf8_general_ci"}, {"name":"abfadklfgklq3u4q78tzdfjhvgajkdshfgjaef72346JKVFE4"}],"volume":{"size":"2"}}}'
    curl -H "X-Auth-Token: $TOKEN" -H"Content-Type: application/json" -d"$JSON_DATA" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances | python -mjson.tool
    echo ""
}

function create_instancesize {
    JSON_DATA='{"instance"'':{"name":"'$1'","flavorRef":"http://localhost:8775/v1.0/flavors/'$2'", "port":"3306", "dbtype":{"name": "mysql", "version":"5.1.2"}, "databases":[{"name":"testdb", "character_set":"utf8", "collate":"utf8_general_ci"}, {"name":"abfadklfgklq3u4q78tzdfjhvgajkdshfgjaef72346JKVFE4"}],"volume":{"size":"'$3'"}}}'
    curl -H "X-Auth-Token: $TOKEN" -H"Content-Type: application/json" -d"$JSON_DATA" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances
    echo ""
}

function create_instance_xml {
    JSON_DATA='{"instance"'':{"name":"'$1'","flavorRef":"http://localhost:8775/v1.0/flavors/'$2'","imageRef":"http://localhost:8775/v1.0/images/'$3'", "port":"3306", "dbtype":{"name": "mysql", "version":"5.1.2"}, "databases":[{"name":"testdb", "character_set":"utf8", "collate":"utf8_general_ci"}, {"name":"abfadklfgklq3u4q78tzdfjhvgajkdshfgjaef72346JKVFE4"}],"volume":{"size":"2"}}}'
    curl -H "X-Auth-Token: $TOKEN" -H "Accept: application/xml" -H"Content-Type: application/json" -d"$JSON_DATA" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances
    echo ""
}


function delete_instance {
    curl -X DELETE -H "X-Auth-Token: $TOKEN" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances/$1
    echo ""
}

function upgradeall_guest {
    curl -H "X-Auth-Token: $TOKEN" -H"Content-Type: application/json" -d"{}" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/guests/upgradeall
    echo ""
}

function upgrade_guest {
    curl -H "X-Auth-Token: $TOKEN" -H"Content-Type: application/json" -d"{}" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/guests/$1/upgrade
    echo ""
}

function create_databases {
    JSON_DATA='{"databases":[{"name":"test", "character_set":"utf8", "collate":"utf8_general_ci"}]}'
    curl -H "X-Auth-Token: $TOKEN" -H"Content-Type: application/json" -d"$JSON_DATA" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances/$1/databases
    echo ""
}

function delete_databases {
    curl -X DELETE -H "X-Auth-Token: $TOKEN" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances/$1/databases/$2
    echo ""
}

function create_users {
    JSON_DATA='{"users": [{"name": "rnirmal", "password": "random", "database": "TESTDB"}, {"name": "rnirmal1", "password": "random1", "databases": [{"name":"nextdb"}, {"name":"firstdb"}]}]}'
    curl -H "X-Auth-Token: $TOKEN" -H"Content-Type: application/json" -d"$JSON_DATA" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances/$1/users
    echo ""
}

function delete_users {
    curl -X DELETE -H "X-Auth-Token: $TOKEN" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances/$1/users/$2
    echo ""
}

function enable_root {
    curl -X POST -H "X-Auth-Token: $TOKEN" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances/$1/root
    echo ""
}

function disable_root {
    curl -X DELETE -H "X-Auth-Token: $TOKEN" -H"X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances/$1/root
    echo ""
}

function check_root_enabled {
    curl -H "X-Auth-Token: $TOKEN" -H "X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances/$1/root | python -mjson.tool
    echo ""
}

function check_root_enabled_xml {
    curl -H "X-Auth-Token: $TOKEN" -H "X_AUTH_PROJECT_ID: $TENANT" -H "Accept: application/xml" http://localhost:8775/v1.0/instances/$1/root
    echo ""
}

function get_database_details {
    curl -H "X-Auth-Token: $TOKEN" -H "X_AUTH_PROJECT_ID: $TENANT" http://localhost:8775/v1.0/instances/$1/databases/$2 | python -mjson.tool
    echo ""
}

function get_database_details {
    curl -H "X-Auth-Token: $TOKEN" -H "X_AUTH_PROJECT_ID: $TENANT" -H "Accept: application/xml" http://localhost:8775/v1.0/instances/$1/databases/$2
    echo ""
}
