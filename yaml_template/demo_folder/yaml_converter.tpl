%{for env, ip in local.yaml_data~}
    ${env} - ${ip} 
%{endfor~}
