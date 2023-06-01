#!/bin/bash

if [ ! -d openroberta ]
then
  echo 'please start this script from the root of the Git working tree - exit 12'
  exit 12
fi

while true
do
  case "$1" in
    -q)            QUIET='yes'
                   shift ;;
    *)             break ;;
  esac
done

cmd="$1"
shift

case "$cmd" in
''|help)        cat ora-help.txt ;;

new-docker-setup) base_dir="$1"
                if [[ -d $base_dir ]]
                then
                  echo "basedir '$base_dir' exists. Exit 12"
                  exit 12
                fi
                cp -r openroberta $base_dir
                cp README.md $base_dir
                echo 'New docker setup created in $base_dir. Please read the README.md of the git repository "OpenRoberta/docker"' ;;

new-server-in-docker-setup)
                base_dir="$1"
                server_name="$2"
                if [[ ! -d $base_dir || ! -f $base_dir/decl.sh ]]
                then
                  echo "basedir '$base_dir' is no valid dir for docker setup. Exit 12"
                  exit 12
                fi
                server_dir="$base_dir/server/$server_name"
                db_dir="$base_dir/db/$server_name"
                if [[ -d "$server_dir" ||  -d "$db_dir" ]]
                then
                  echo "server dir or db dir for '$server_name' found. Exit 12"
                  exit 12
                fi
                cp -r openroberta/server/_server-template $server_dir
                echo "New server $server_name created. Please read the README.md of the git repository \"OpenRoberta/docker\"" ;;

update-docker-setup)
                base_dir="$1"
                if [[ ! -d $base_dir || ! -f $base_dir/decl.sh ]]
                then
                  echo "basedir '$base_dir' no valid dir for docker setup. Exit 12"
                  exit 12
                fi
                rm -rf $base_dir/conf $base_dir/scripts
                cp -r openroberta/conf $base_dir/conf
                cp -r openroberta/scripts $base_dir/scripts
                cp README.md $base_dir
                echo "configuration data copied to $base_dir/conf and $base_dir/scripts" ;;

*)              echo "invalid command: $cmd - exit 1"
                exit 1 ;;
esac

exit 0
