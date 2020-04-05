from ftplib import FTP

ftp = FTP('172.16.1.13')

ftp.login()

lines = ftp.retrlines('LIST')

print lines

ftp.quit()
