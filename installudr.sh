apt-get update
apt-get install git gcc g++ make libssl-dev incron 
git clone https://github.com/LabAdvComp/UDR.git
cd UDR
make -e os=LINUX arch=AMD64


