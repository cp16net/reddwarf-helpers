function dbaas_login {
    output=$(curl -i -H "X-Auth-User: admin" -H "X-Auth-Key: admin" http://localhost:8775/v1.0/ | sed -n '/Token/p')
    token=`echo $output | awk -F": " '{print $2}'`
    export TOKEN=$token
    echo "TOKEN = $TOKEN"
}

function list_images {
    curl -H "X-Auth-Token: $TOKEN" http://localhost:8775/v1.0/images/detail
    echo ""
}

function list_flavors {
    curl -H "X-Auth-Token: $TOKEN" http://localhost:8775/v1.0/flavors/detail
    echo ""
}

function list_users {
    curl -H "X-Auth-Token: $TOKEN" http://localhost:8775/v1.0/dbcontainers/$1/users
    echo ""
}

function list_users_xml {
    curl -H "X-Auth-Token: $TOKEN" -H "Accept: application/xml" http://localhost:8775/v1.0/dbcontainers/$1/users
    echo ""
}

function list_databases {
    curl -H "X-Auth-Token: $TOKEN" http://localhost:8775/v1.0/dbcontainers/$1/databases
    echo ""
}

function list_databases_xml {
    curl -H "X-Auth-Token: $TOKEN" -H "Accept: application/xml" http://localhost:8775/v1.0/dbcontainers/$1/databases
    echo ""
}

function index_containers_xml {
    curl -H "X-Auth-Token: $TOKEN" -H "Accept: application/xml" http://localhost:8775/v1.0/dbcontainers
    echo ""
}

function detail_containers_xml {
    curl -H "X-Auth-Token: $TOKEN" -H "Accept: application/xml" http://localhost:8775/v1.0/dbcontainers/detail
    echo ""
}

function show_container_xml {
    curl -H "X-Auth-Token: $TOKEN" -H "Accept: application/xml" http://localhost:8775/v1.0/dbcontainers/$1
    echo ""
}

function index_containers {
    curl -H "X-Auth-Token: $TOKEN" http://localhost:8775/v1.0/dbcontainers
    echo ""
}

function detail_containers {
    curl -H "X-Auth-Token: $TOKEN" http://localhost:8775/v1.0/dbcontainers/detail
    echo ""
}

function show_container {
    curl -H "X-Auth-Token: $TOKEN" http://localhost:8775/v1.0/dbcontainers/$1
    echo ""
}

function create_container {
    JSON_DATA='{"dbcontainer"'':{"name":"'$1'","flavorRef":"http://localhost:8775/v1.0/flavors/'$2'","imageRef":"http://localhost:8775/v1.0/images/'$3'", "port":"3306", "dbtype":{"name": "mysql", "version":"5.1.2"}, "databases":[{"name":"testdb", "character_set":"utf8", "collate":"utf8_general_ci"}, {"name":"abfadklfgklq3u4q78tzdfjhvgajkdshfgjaef72346JKVFE4"}]}}'
    curl -H "X-Auth-Token: $TOKEN" -H"Content-Type: application/json" -d"$JSON_DATA" http://localhost:8775/v1.0/dbcontainers
    echo ""
}

function create_container_xml {
    JSON_DATA='{"dbcontainer"'':{"name":"'$1'","flavorRef":"http://localhost:8775/v1.0/flavors/'$2'","imageRef":"http://localhost:8775/v1.0/images/'$3'", "port":"3306", "dbtype":{"name": "mysql", "version":"5.1.2"}, "databases":[{"name":"testdb", "character_set":"utf8", "collate":"utf8_general_ci"}, {"name":"abfadklfgklq3u4q78tzdfjhvgajkdshfgjaef72346JKVFE4"}]}}'
    curl -H "X-Auth-Token: $TOKEN" -H "Accept: application/xml" -H"Content-Type: application/json" -d"$JSON_DATA" http://localhost:8775/v1.0/dbcontainers
    echo ""
}


function delete_container {
    curl -X DELETE -H "X-Auth-Token: $TOKEN" http://localhost:8775/v1.0/dbcontainers/$1
    echo ""
}

function upgradeall_guest {
    curl -H "X-Auth-Token: $TOKEN" -H"Content-Type: application/json" -d"{}" http://localhost:8775/v1.0/guests/upgradeall
    echo ""
}

function upgrade_guest {
    curl -H "X-Auth-Token: $TOKEN" -H"Content-Type: application/json" -d"{}" http://localhost:8775/v1.0/guests/$1/upgrade
    echo ""
}

function create_databases {
    JSON_DATA='{"databases":[{"name":"test", "character_set":"utf8", "collate":"utf8_general_ci"}]}'
    curl -H "X-Auth-Token: $TOKEN" -H"Content-Type: application/json" -d"$JSON_DATA" http://localhost:8775/v1.0/dbcontainers/$1/databases
    echo ""
}

function delete_databases {
    curl -X DELETE -H "X-Auth-Token: $TOKEN" http://localhost:8775/v1.0/dbcontainers/$1/databases/$2
    echo ""
}

function create_users {
    JSON_DATA='{"users": [{"name": "rnirmal", "password": "random", "database": "TESTDB"}, {"name": "rnirmal1", "password": "random1", "databases": [{"name":"nextdb"}, {"name":"firstdb"}]}]}'
    curl -H "X-Auth-Token: $TOKEN" -H"Content-Type: application/json" -d"$JSON_DATA" http://localhost:8775/v1.0/dbcontainers/$1/users
    echo ""
}

function delete_users {
    curl -X DELETE -H "X-Auth-Token: $TOKEN" http://localhost:8775/v1.0/dbcontainers/$1/users/$2
    echo ""
}

function enable_root {
    curl -X POST -H "X-Auth-Token: $TOKEN" http://localhost:8775/v1.0/dbcontainers/$1/root
    echo ""
}

function disable_root {
    curl -X DELETE -H "X-Auth-Token: $TOKEN" http://localhost:8775/v1.0/dbcontainers/$1/root
    echo ""
}
