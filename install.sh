#!/bin/bash


cat <<"EOF" >> $HOME/.bashrc
function aws-assumerole() {
    [[ -z "$AWS_IAM_ROLE_ARN" ]] && echo "Please set AWS_IAM_ROLE_ARN" && return
    [[ -z "$AWS_PROFILE" ]] && echo "Please set AWS_PROFILE" && return
    [[ -z "$AWS_MFA_ARN" ]] && echo "Please set AWS_MFA_ARN" && return

    echo -n "Type your MFA Token: "; read mfa_token

    result="$(aws sts assume-role --role-arn "$AWS_IAM_ROLE_ARN" --role-session-name AWSCLI-Session --profile "$AWS_PROFILE" --serial-number "$AWS_MFA_ARN" --token-code "$mfa_token")"
    secrets="$(echo "$result" | jq -r '[.Credentials.AccessKeyId, .Credentials.SecretAccessKey, .Credentials.SessionToken]')"

    export AWS_ACCESS_KEY_ID="$(echo "$secrets" | jq -r '.[0]')"
    export AWS_SECRET_ACCESS_KEY="$(echo "$secrets" | jq -r '.[1]')"
    export AWS_SESSION_TOKEN="$(echo "$secrets" | jq -r '.[2]')"
}
EOF
