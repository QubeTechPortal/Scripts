## Calculate checkum for checking the integrity of the transferred file

# Create a archive file
echo "Enter the archive file name"
read archiveFileName

mkdir Check
touch Check/sampleFile.txt

echo "Enter the contents of sample file"
read contents | cat >> Check/sampleFile.txt


# Create a sample archive file
tar xvf $archiveFileName sampleFile

# Print the checksum
cksum $archiveFileName
