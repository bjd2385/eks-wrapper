#! /bin/bash
# Stand up a K8s cluster with eksctl.


source src/utils.sh


usage()
{
    printf "Usage: %s [-h help] [-d dry run] [-D delete a cluster]\\n" "$0"
    exit 1
}


_dry_run=false

while getopts ":h:dD" flag
do
    case "${flag}" in
        d)
            # Dry run.
            _dry_run=true
            ;;
        D)
            # Delete a cluster.
            REGION="$(response "Cluster region (defaults to \`us-east-2\`): " "us-east-2")"
            list="$(eksctl get cluster --region "$REGION")"

            if [[ "$list" =~ "No clusters found" ]]
            then
                _error "$list"
                exit 1
            else
                printf "%s\\n" "$list"
            fi

            CLUSTER="$(response "Select a cluster from the above list to delete: " "")"

            if [ "$CLUSTER" ]
            then
                eksctl delete cluster --region "$REGION" "$CLUSTER"
            else
                _error "Must provide a cluster name."
            fi

            exit 1
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


# Cluster
NAME="$(response "Cluster name (optional): " "support-test-$(uuid)")"
OWNER="$(response "Your name (for tagging purposes, defaults to \`Support\`): " "Support")"
VERSION="$(response "Override K8s version (defaults to 1.18): " "1.18")"
REGION="$(response "Cluster region (default \`us-east-2\`): " "us-east-2")"


##
# Get Nodegroup values from the user.
nodegroup_io()
{
    MIN="$(response "Min number of worker nodes (default is 2): " "2")"
    MAX="$(response "Max number of worker nodes (default is $MIN + 1 = $(( MIN + 1 ))): " "$(( MIN + 1 ))")"
    SIZE="$(response "Instance size (default is \`t3.medium\`): " "t3.medium")"
    EBS_SIZE="$(response "Instance volume size (default 80 (GB)): " "80")"
    NODEGROUP_NAME="$(response "Nodegroup name (default \`test\`): " "test")"

    # TODO: Add check/retry to ensure there are no duplicate nodegroup names.
}


main()
{
    # Set nodegroup variables prior to creating a cluster for the first time.
    nodegroup_io

    # Create
    while true
    do
        cmd="eksctl create cluster --name ${NAME} --tags \"Owner=${OWNER}\" --region ${REGION} \
--version ${VERSION} --timeout \"60m0s\" --nodegroup-name ${NODEGROUP_NAME} --node-type ${SIZE} \
--nodes-min ${MIN} --nodes-max ${MAX} --node-volume-size ${EBS_SIZE} --node-labels \"env=test\" \
--full-ecr-access --asg-access --alb-ingress-access --auto-kubeconfig"

        if $_dry_run
        then
            _separator "Dry run output:"
            printf "%s\\n\\n" "$cmd"
            exit 0
        fi

        _separator "Creating EKS Cluster"

        eval "$cmd"

        if ! [ $? ]
        then
            # Cluster creation was not successful, so you can either retry following its complete deletion, or exit.
            printf "Deleting cluster and pausing\\n"

            # This command blocks, but it doesn't exit when all resources are deleted, yet.
            eksctl delete cluster --region "$REGION" "$NAME"

            _wait 90

            retry="$(response "Retry? [y/n]: ")"
            if [[ ! "$retry" =~ ^[Yy].* ]]
            then
                return 1
            fi
        else
            break
        fi
    done

    _separator "EKS Cluster $NAME created. Moving on to optional additional compute"
    printf "\\n"

    # Cluster creation was successful. Want to add more node(s|groups)?
    while true
    do
        if [[ "$(response "Would you like to add further nodegroups? [y/n]: " "no")" =~ ^[Yy].* ]]
        then
            # Yes, so reset nodegroup variables and run an additional command to append a nodegroup.
            _separator "Adding additional nodegroup to cluster $NAME"
            nodegroup_io
            :
        else
            # No, let's just exit with some beautiful output :D
            :
            break
        fi
    done
}


main