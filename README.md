# bash-scripts

[![Build Status](https://travis-ci.org/0xmachos/bash-scripts.svg?branch=master)](https://travis-ci.org/0xmachos/bash-scripts)

Assorted Bash scripts 

##### `add_sudo_user`
- Add a user to `sudo` group with an SSH jey
- Usage: `./add_sudo_user {Username} {SSH Public Key}`

##### `ct-abuse`
- For the given domain query [Certificate Transparency](https://www.certificate-transparency.org/what-is-ct) to get a list of subdomains which have SSL/TLS certificates issued for them 
- Usage: `./ct-abuse.sh {target_domain}`

##### `shebang`
- Check if bash scripts have a shebang on line one (`#!`)
- Usgae: `./shebang.sh *` or `./shebang.sh {file 1} {file ...}`

##### `x86_check`
- Check whole system for 32-bit Apps
- Usage: `./x86_check`
