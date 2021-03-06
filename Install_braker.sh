#!/bin/bash

now_path=$(pwd)

# >>> Install Modules >>>
sudo apt-get install libboost-iostreams-dev
sudo apt-get install zlib1g-dev
sudo apt-get install libgsl-dev
sudo apt-get install libboost-all-dev
sudo apt-get install libsuitesparse-dev
sudo apt-get install liblpsolve55-dev
sudo apt-get install libsqlite3-dev
sudo apt-get install libmysql++-dev
sudo apt-get install libbamtools-dev
sudo apt-get install libboost-all-dev
sudo apt-get install libboost-all-dev

cpan install File::Spec::Functions
cpan install Hash::Merge
cpan install List::Util
cpan install MCE::Mutex
cpan install Module::Load::Conditional
cpan install Parallel::ForkManager
cpan install POSIX
cpan install Scalar::Util::Numeric
cpan install YAML
cpan install Math::Utils
cpan install threads
cpan install File::HomeDir
# <<< Install Modules <<<

# <<< Install braker <<<
git clone https://github.com/Gaius-Augustus/BRAKER.git
braker_path=$(realpath ./BRAKER/scripts/)
# >>> Install braker <<<

# >>> Install GeneMark-EX >>>

python3 Download_GeneMarkEX.py

while read line; 
do
  wget $line;
done < gmes_urls.txt
rm gmes_urls.txt

tar zxvf gmes_linux_64.tar.gz
cd gmes_linux_64
gmes_path=$(pwd)
cp gm_key ~/.gm_key
cd ..
rm gmes_linux_64.tar.gz

# gunzip gm_key_64.gz
# mv gm_key_64 /home/
# cd /home/
# mv gm_key_64 .gm_key

cd $now_path
# <<< Install GeneMark-EX <<<

# >>> Install August >>>
git clone https://github.com/Gaius-Augustus/Augustus.git
cd ./Augustus
Augustus_path=$(pwd)
makefile_path=/auxprogs/Makefile
sed -i 's/	cd bam2wig; make/	#cd bam2wig; make/g' $Augustus_path$makefile_path
Augustus_path=${Augustus_path}/config
echo $Augustus_path
make
cd ..
# <<< Install August <<<

# >>> Install Bamtools <<<
sudo apt-get -y install cmake
git clone https://github.com/pezmaster31/bamtools.git
cd ./bamtools
bamtools_path=$(pwd)/bin
mkdir build
cd build
cmake ..
make
cd ../..
# <<< Install Bamtools <<<

# >>> Install DIAMOND >>>
mkdir diamond
cd ./diamond
diamond_path=$(pwd)
wget http://github.com/bbuchfink/diamond/releases/download/v0.9.24/diamond-linux64.tar.gz
tar xzf diamond-linux64.tar.gz
rm diamond-linux64.tar.gz
cd ..
# <<< Install DIAMOND <<<

# >>> Install ProtHint >>>
git clone https://github.com/gatech-genemark/ProtHint.git
cd ./ProtHint
prothint_path=$(pwd)/bin
cd ..
# <<< Install ProtHint

# >>> Install cdbfasta >>>
git clone https://github.com/gpertea/cdbfasta.git
cd cdbfasta
cdbfasta_path=$(pwd)
make all
cd ..
# <<< Install cdbfasta <<<

# >>> TSEBRA >>>
git clone https://github.com/Gaius-Augustus/TSEBRA
tsebra_path=$(realpath ./TSEBRA/bin/)
# <<< TSEBRA <<<

# >>> change mod >>>
chmod -R 777 ./
# <<< change mod <<<

echo 'Install finished.'


# >>> Write Paths to ~/.bashrc >>>
cd
path=$(pwd)
echo $path
sed -i 's/# >>> Path of Braker >>>//g' $path/.bashrc
sed -i "s|export DIAMOND_PATH=$diamond_path||g" $path/.bashrc
sed -i "s|export AUGUSTUS_CONFIG_PATH=$Augustus_path||g" $path/.bashrc
sed -i "s|export BAMTOOLS_PATH=$bamtools_path||g" $path/.bashrc
sed -i "s|export PROTHINT_PATH=$prothint_path||g" $path/.bashrc
sed -i "s|export CDBTOOLS_PATH=$cdbfasta_path||g" $path/.bashrc
sed -i "s|export GENEMARK_PATH=$gmes_path||g" $path/.bashrc
sed -i "s|export PATH=$tsebra_path:$PATH||g" $path/.bashrc
sed -i "s|export PATH=$braker_path:$PATH||g" $path/.bashrc
sed -i 's/# <<< Path of Braker <<<//g' $path/.bashrc

echo '# >>> Path of Braker >>>' >> $path/.bashrc
echo "export DIAMOND_PATH=$diamond_path" >> $path/.bashrc
echo "export AUGUSTUS_CONFIG_PATH=$Augustus_path" >> $path/.bashrc
echo "export BAMTOOLS_PATH=$bamtools_path" >> $path/.bashrc
echo "export PROTHINT_PATH=$prothint_path" >> $path/.bashrc
echo "export CDBTOOLS_PATH=$cdbfasta_path" >> $path/.bashrc
echo "export GENEMARK_PATH=$gmes_path" >> $path/.bashrc
echo "export PATH=$tsebra_path:$PATH" >> $path/.bashrc
echo "export PATH=$braker_path:$PATH" >> $path/.bashrc

echo '# <<< Path of Braker <<<' >> $path/.bashrc
# <<< Write Paths to ~/.bashrc <<<

echo 'Env variable added.'
echo 'Please run the command: source ~/.bashrc'
