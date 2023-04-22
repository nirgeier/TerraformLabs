%{for env, ip in yaml_data~}
    ${env} - ${ip} 
%{endfor~}
