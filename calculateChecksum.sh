## Calculate checkum for checking the integrity of the transferred file

# Create a archive file
echo "Enter the archive file name"
read archiveFileName

mkdir Check
touch Check/sampleFile

echo "Enter the contents of sample file"
read contents
echo $contents | cat >> Check/sampleFile

# Create a sample archive file
tar cvf $archiveFileName Check/sampleFile

# Print the checksum
cksum $archiveFileName
