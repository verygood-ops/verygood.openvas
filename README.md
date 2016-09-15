# verygood.openvas
An installation of the OpenVAS vulnerability scanner

## Development

```
vagrant up
vagrant ssh -c "sudo apt-get install python2.7 python-virtualenv"
vagrant ssh -c "sudo echo \"nameserver 8.8.8.8 >> /etc/resolv.conf"
vagrant provision
```

This will take a pretty long time, as there are many steps in setting up openvas. When the playbook finishes running, you should be able to https://localhost:4443 and see the default web UI. Default user/pass is admin:admin.
