# Install:
>sudo apt install mailutils postfix

>sudo DEBIAN_PRIORITY=low apt install postfix

# In configuration:
* General type of mail configuration?: Internet Site
* System mail name: example.com (not mail.example.com)
* Root and postmaster mail recipient: The username of your primary Linux account
* Other destinations to accept mail for: $myhostname, example.com, mail.example.com, localhost.example.com, localhost
* Force synchronous updates on mail queue?: No
* Local networks: 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128
* Mailbox size limit: 0
* Local address extension character: +
* Internet protocols to use: all

# On `reports`

You can put the receiver of emails in the config files on repo `reports/data/configuration`

```json
{
    "chirpstack_api_url": "https://lns.campusiot.imag.fr",
    "report_email_to": "XX.XX@univ-grenoble-alpes.fr YY.YY@univ-grenoble-alpes.fr"
}
```