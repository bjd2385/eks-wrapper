#! /bin/bash

##
# Delete a cluster from a menu.
delete()
{
    # Delete a cluster.
    REGION="$(response "Cluster region (defaults to \`us-east-2\`): " "us-east-2")"
    list="$(eksctl --verbose 2 get cluster --region "$REGION")"

    if [ -z "$list" ]
    then
        # Above command probably sent text to stderr we didn't capture.
        exit 1
    elif [[ "$list" =~ "No clusters found" ]]
    then
        _error "$list"
        exit 1
    else
        printf "%s\\n" "$list"
    fi

    NAME="$(response "Select a cluster from the above list to delete: " "")"

    if [ "$NAME" ]
    then
        _separator "Starting delete of cluster $NAME"
        eksctl delete cluster --region "$REGION" "$NAME"
        _wait 60
    else
        _error "Must provide a cluster name."
    fi

    return 0
}


##
# Get Nodegroup values from the user.
_nodegroup_io()
{
    MIN="$(response "Min number of worker nodes (default is 2): " "2")"
    MAX="$(response "Max number of worker nodes (default is $MIN + 1 = $(( MIN + 1 ))): " "$(( MIN + 1 ))")"
    SIZE="$(response "Instance size (default is \`t3.medium\`): " "t3.medium")"
    EBS_SIZE="$(response "Instance volume size (default 80 (GB)): " "80")"
    NODEGROUP_NAME="$(response "Nodegroup name (default \`test\`, no duplicates): " "test")"
    LABELS="$(response "Nodegroup labels (default \`env=test\`; must be in format key1=val1,key2=val2): " "env=test")"

    return 0
}


##
# Add a nodegroup to a cluster.
add_nodes()
{
    if [ $# -eq 1 ]
    then
        # This method is being called upon a cluster that was just created, so we already have the cluster info.
        :
    else
        # We do not have the cluster info, so necessary variables are not set.
        REGION="$(response "Cluster region (defaults to \`us-east-2\`): " "us-east-2")"
        list="$(eksctl --verbose 2 get cluster --region "$REGION")"

        if [ -z "$list" ]
        then
            exit 1
        elif [[ "$list" =~ "No clusters found" ]]
        then
            _error "$list"
            exit 1
        else
            printf "%s\\n" "$list"
        fi

        NAME="$(response "Select a cluster from the above list to add a node group to: " "")"
        while ! [ "$NAME" ]
        do
            _error "Expected cluster name."
            NAME="$(response "Select a cluster from the above list to add a node group to: " "")"
        done

        OWNER="$(response "Your name (for tagging purposes, defaults to \`Support\`): " "Support")"
    fi

    # This is a bug in `eksctl`. If no nodegroup exists, it prints "Error: Nodegroup with name  not found" to stderr
    # in earlier eksctl versions. Was fixed somewhere between v0.31.0 and v0.37.0.
    list="$(eksctl --verbose 2 get nodegroup --region "$REGION" --cluster "$NAME" 2>&1)"
    if [[ "$list" =~ "Error:" ]]
    then
        _warning "There are currently no nodegroups attached to this cluster"
    else
        printf "%s\\n" "$list"
    fi

    _nodegroup_io
    _separator "Creating EKS Nodegroup"

    eksctl create nodegroup --cluster "$NAME" --tags "\"Owner=$OWNER\"" --region "$REGION" \
--timeout "60m0s" --name "$NODEGROUP_NAME" --node-type "$SIZE" --nodes-min "$MIN" \
--nodes-max "$MAX" --node-volume-size "$EBS_SIZE" --node-labels "${LABELS}" --full-ecr-access \
--asg-access --alb-ingress-access

    printf "\\n"
    eksctl --verbose 2 get nodegroup --region "$REGION" --cluster "$NAME"
    printf "\\n"

    return 0
}


##
# Remove node group from an existing cluster.
remove_nodes()
{
    # We do not have the cluster info, so necessary variables are not set.
    REGION="$(response "Cluster region (defaults to \`us-east-2\`): " "us-east-2")"
    list="$(eksctl --verbose 2 get cluster --region "$REGION")"

    if [ -z "$list" ]
    then
        exit 1
    elif [[ "$list" =~ "No clusters found" ]]
    then
        _error "$list"
        exit 1
    else
        printf "%s\\n" "$list"
    fi

    NAME="$(response "Select a cluster from the above list to remove a node group from: " "")"
    if ! [ "$NAME" ]
    then
        _error "Expected cluster name."
    fi

    # This is a bug in `eksctl`. If no nodegroup exists, it prints "Error: Nodegroup with name  not found" to stderr
    # in earlier eksctl versions. Was fixed somewhere between v0.31.0 and v0.37.0.
    list="$(eksctl --verbose 2 get nodegroup --region "$REGION" --cluster "$NAME" 2>&1)"

    if [ -z "$list" ]
    then
        # Above command probably sent text to stderr we didn't capture.
        exit 1
    elif [[ "$list" =~ "Error:" ]]
    then
        _error "$list"
        exit 1
    else
        printf "%s\\n" "$list"
    fi

    NODEGROUP_NAME="$(response "Select a nodegroup (name) from the above list to remove from cluster $NAME: " "")"

    _separator "Deleting nodegroup $NODEGROUP_NAME from cluster $NAME"

    eksctl delete nodegroup --region "$REGION" --cluster "$NAME" --name "$NODEGROUP_NAME"
    printf "\\n"

    return 0
}


##
# Create an EKS cluster.
create()
{
    if [ $# -ne 1 ]
    then
        _error "Expected 1 argument to \`create\`, received $#.\\n"
    fi

    _dry_run=$1

    # Cluster
    NAME="$(response "Cluster name (optional): " "support-test-$(uuid)")"
    OWNER="$(response "Your name (for tagging purposes, defaults to \`Support\`): " "Support")"
    VERSION="$(response "Override K8s version (defaults to 1.18): " "1.18")"
    REGION="$(response "Cluster region (default \`us-east-2\`): " "us-east-2")"

    # Set nodegroup variables prior to creating a cluster for the first time.
    _nodegroup_io

    # Create
    while true
    do
        cmd="eksctl create cluster --name ${NAME} --tags \"Owner=${OWNER}\" --region ${REGION} \
--version ${VERSION} --timeout \"60m0s\" --nodegroup-name ${NODEGROUP_NAME} --node-type ${SIZE} \
--nodes-min ${MIN} --nodes-max ${MAX} --node-volume-size ${EBS_SIZE} --node-labels \"${LABELS}\" \
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

            _wait 60

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

    # Cluster creation was successful. Want to add more node(s|groups)?
    while [[ "$(response "Would you like to add further nodegroups? [y/n]: " "no")" =~ ^[Yy].* ]]
    do
        # Yes, so reset nodegroup variables and run an additional command to append a nodegroup.
        _separator "Adding additional nodegroup to cluster $NAME"
        add_nodes "$NAME"
    done

    _separator "Execute the following command to connect to your new cluster:"
    printf "\$ sudo aws eks --region %s update-kubeconfig --name %s\\n\\n" "$REGION" "$NAME"

    return 0
}


##
# Dump command you need to execute as root to connect ot a cluster.
get_kubeconfig()
{
    REGION="$(response "Cluster region (defaults to \`us-east-2\`): " "us-east-2")"
    list="$(eksctl --verbose 2 get cluster --region "$REGION")"

    if [ -z "$list" ]
    then
        exit 1
    elif [[ "$list" =~ "No clusters found" ]]
    then
        _error "$list"
        exit 1
    else
        printf "%s\\n" "$list"
    fi

    NAME="$(response "Select a cluster from the above list to generate \`update-kubeconfig\` command on: " "")"

    if ! [ "$NAME" ]
    then
        _error "Expected cluster name."
    fi

    _separator "Execute the following command to connect to your new cluster:"
    printf "\$ sudo aws eks --region %s update-kubeconfig --name %s\\n\\n" "$REGION" "$NAME"

    return 0
}


##
# Show information about a cluster.
show_cluster()
{
    REGION="$(response "Cluster region (defaults to \`us-east-2\`): " "us-east-2")"
    list="$(eksctl --verbose 2 get cluster --region "$REGION")"

    if [ -z "$list" ]
    then
        exit 1
    elif [[ "$list" =~ "No clusters found" ]]
    then
        _error "$list"
        exit 1
    else
        printf "%s\\n" "$list"
    fi

    NAME="$(response "Select a cluster from the above list to show info: " "")"

    if ! [ "$NAME" ]
    then
        _error "Expected cluster name."
    fi

    # This is a bug in `eksctl`. If no nodegroup exists, it prints "Error: Nodegroup with name  not found" to stderr
    # in earlier eksctl versions. Was fixed somewhere between v0.31.0 and v0.37.0.
    list="$(eksctl --verbose 2 get nodegroup --region "$REGION" --cluster "$NAME" 2>&1)"
    if [[ "$list" =~ "Error:" ]]
    then
        _warning "There are currently no nodegroups attached to this cluster"
    else
        printf "\\n%s\\n\\n" "$list"
    fi

    return 0
}
