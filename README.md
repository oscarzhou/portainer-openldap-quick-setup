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


## 3. How to configure on Portainer LDAP page?  

:exclamation: Note that if you want to display group, you'll need to select custom server type instead of OpenLDAP on Portainer page.  

### 3.1. Configure Connection

| Key  | Value  | 
|---|---|
| LDAP Server   | 172.31.0.10:389 |
| Reader DN   | cn=admin,dc=example,dc=org |
| Password   | admin_pass |

![ldap-configuration-1](/images/ldap-configuration-1.PNG)

### 3.2. Configure Users  


| Key  | Value  | 
|---|---|
| Base DN 1   | cn=maintainer,dc=example,dc=org |
| Username attribute 1  | uid |
| Base DN 2   | cn=developer,dc=example,dc=org |
| Username attribute 2  | uid |

![ldap-configuration-2](/images/ldap-configuration-2.PNG)
![ldap-configuration-3](/images/ldap-configuration-3.PNG)

### 3.2. Configure Groups

| Key  | Value  | 
|---|---|
| Group Base DN 1   | cn=Maintainers,ou=Groups,dc=example,dc=org |
| Group Membership Attribute 1  | uniqueMember |
| Group Filter 1   | (objectClass=groupOfUniqueNames) |
| Group Base DN 2   | cn=Admins,ou=Groups,dc=example,dc=org |
| Group Membership Attribute 2  | uniqueMember |
| Group Filter 2   | (objectClass=groupOfUniqueNames) |

![ldap-configuration-4](/images/ldap-configuration-4.PNG)
![ldap-configuration-5](/images/ldap-configuration-5.PNG)