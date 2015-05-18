1) c:\xampp\apache\conf\extra\httpd-vhosts.conf

<VirtualHost 127.0.0.1> 
    ServerAdmin a.shestmintsev@unitecsys.com
    DocumentRoot C:/xampp/htdocs/unitemplate.local
    <Directory "C:/xampp/htdocs/unitemplate.local/">
        Options Includes FollowSymLinks Multiviews
        AllowOverride ALL
        Order allow,deny
        Allow from all
    </Directory>
    ServerName unitemplate.local
    ServerAlias www.unitemplate.local
    ErrorLog "C:/xampp/apache/logs/unitemplate.local.error_log"
    CustomLog "C:/xampp/apache/logs/unitemplate.local.access_log" common
</VirtualHost> 

2) c:\Windows\System32\drivers\etc\hosts
127.0.0.1 unitemplate.local

3) http://unitemplate.local/