ulimit -c unlimited
sudo systemctl stop apport
sudo systemctl disable apport
while true;
do ./slaynville;
./remake.sh
done
