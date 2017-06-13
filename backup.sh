# Change the default SSH PORT - Change the default port 22 to any unassigned port (use netstat -tulp)
sudo nano /etc/ssh/sshd_config

# Restart SSH service
sudo service sshd Restart

# Backup server
# Sync files/folders using Rsync with non-standard ssh port
rsync -arvz -e 'ssh -p <port-number>' --progress --delete user@remote-server:/path/to/remote/folder /path/to/local/folder
## Backup after a predefined time
5 * * * * rsync -arvz -e 'ssh -p <port-number>' --progress --delete user@remote-server:/path/to/remote/folder /path/to/local/folder


# Remote server
rsync -arvz -e 'ssh -p <port-number>' --progress --delete /path/to/local/file user@backup-server:/path/to/backup
