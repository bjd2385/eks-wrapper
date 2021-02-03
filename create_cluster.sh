#! /bin/bash
# Stand up a K8s cluster.


source src/utils.sh


# Install `brew install ossp-uuid` to get `uuid`.
NAME="$(response "Cluster name: " "support-test-$(uuid)")"
echo "$NAME"
OWNER="$(response "Your name (for tagging purposes): " "Support")"
VERSION="$(response "Override K8s version (defaults to 1.18): " "1.18")"
REGION="$(response "Cluster region: " "us-east-2")"
MIN="$(response "Min number of worker nodes (default is 2): " "2")"
MAX="$(response "Max number of worker nodes (default is \`min\`+1): " "$(( MIN + 1 ))")"


main()
{
    while true
    do
        eksctl create cluster --name "$NAME" --tags "Owner=$OWNER" --region "$REGION" --version "$VERSION" \
                              --timeout "60m0s" --nodegroup-name "2-3-1-test" --node-type "t3.medium" --nodes-min "$MIN" \
                              --nodes-max "$MAX" --node-volume-size 80 --node-labels "env=test,agent=2-3-1" \
                              --full-ecr-access --asg-access --alb-ingress-access --auto-kubeconfig

        if ! $?
        then
            eksctl delete cluster --name "$NAME"
            printf "Deleting cluster and pausing\\n"
            printf "...\\n"
            sleep 60
            printf "Should be good to go now!\\n"
            retry="$(response "Retry? [y/n]: ")"
            if [[ "$retry" =~ ^[Yy].* ]]
            then
                continue
            else
                break
            fi
        fi
    done
}


main