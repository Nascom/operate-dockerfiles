# Usage

To get the version :
```
docker run --user=$(id -u):$(id -g) --rm nascom/php:7.1-cli-alpine --version
```

To run a php script named script.php :
```
docker run --user=$(id -u):$(id -g) --rm nascom/php:7.1-cli-alpine script.php
```

To run the cli container and send mails you should mount your ssmtp config in /etc/ssmtp/ssmtp.conf.

e.g. create a file with the following contents :
```
root=user@domain.com
mailhub=mail.domain.com
FromLineOverride=YES
```

where mail.domain.com is a valid SMTP server and user@domain.com is your email address.

