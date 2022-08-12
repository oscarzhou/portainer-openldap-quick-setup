# portainer-openldap-quick-setup
This will setup portainer with testing image and openldap service with bootstrap data + StartTLS/TLS enabled

## How to start?

```
git clone https://github.com/oscarzhou/portainer-openldap-quick-setup.git && cd portainer-openldap-quick-setup
chmod +x ldap-run.sh
./ldap-run.sh
```

![setup-openldap](/images/setup-openldap.gif)

After the output `Portainer run up successfully` shows up, it may take a while for portainer to finish initialization. You can refresh the web page every 5 seconds.  