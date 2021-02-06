#! /bin/bash
# Stand up a K8s cluster with eksctl.


source src/utils.sh
source src/eks.sh


usage()
{
    printf "Usage: %s [-h help] [-c create a cluster] [-d dry run] [-D delete a cluster] \
[-a add node group to existing cluster] [-r remove node group from existing cluster] \
[-g get kubeconfig command] [-s show cluster and cluster nodegroups]\\n" "$0" >&2
    exit 1
}


if [ $# -ne 1 ]
then
    printf "Expected 1 argument to $0, received %s.\\n" "$#" >&2
    usage
    exit 1
fi


while getopts ":h:dDcagrs" flag
do
    case "${flag}" in
        d)
            # Dry run.
            create true
            ;;
        c)
            # Create a cluster.
            create false
            ;;
        D)
            delete
            ;;
        a)
            add_nodes
            ;;
        r)
            remove_nodes
            ;;
        g)
            get_kubeconfig
            ;;
        s)
            show_cluster
            ;;
        h)
            # Help.
            usage
            ;;
        *)
            usage
            ;;
    esac
done