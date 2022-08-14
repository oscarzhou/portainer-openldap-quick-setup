# portainer-openldap-quick-setup
This will setup portainer with testing image and openldap service with bootstrap data + StartTLS/TLS enabled

## 1. How to start?

```
git clone https://github.com/oscarzhou/portainer-openldap-quick-setup.git && cd portainer-openldap-quick-setup
chmod +x ldap-run.sh
./ldap-run.sh
```

![setup-openldap](/images/setup-openldap.gif)

After the output `Portainer run up successfully` shows up, it may take a while for portainer to finish initialization. You can refresh the web page every 5 seconds.  

## 2. How to test? 

| Key  | Value  | 
|---|---|
| Admin Login DN   | cn=admin,dc=example,dc=org  |
| Admin Password  | admin_pass  |
| Server IP  | 172.31.0.10  |
| Port over TLS (STARTTLS)  |  389 |
| Port over SSL  | 636  |
| CA Certificate  | ./data/certs/ldap-ca.pem  |
| username1  | developer  |
| password1  | developer_pass  |
| username2  | maintainer  |
| password2  | maintainer_pass  |  
