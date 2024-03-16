git pull
rm -rf build/
rm slaynville
mkdir build/
cd build
cmake ..
make
cp -i slaynville ../
rm slaynville
cd ..