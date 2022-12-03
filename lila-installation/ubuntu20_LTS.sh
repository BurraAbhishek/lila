# Run this first and restart your terminal!
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
home_directory=$HOME
sudo apt update
sudo apt install -y git
curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash && . ~/.jabba/jabba.sh
cd $home_directory
mkdir dev
cd dev
mkdir lichess
cd lichess
git clone --recursive https://github.com/lichess-org/lila.git
git clone --recursive https://github.com/lichess-org/lila-ws.git
git clone --recursive https://github.com/lichess-org/lila-db-seed.git
cd $home_directory
jabba install openjdk@1.17.0
sudo apt install -y python3-pip
nvm install node
npm install --global yarn
sudo apt install -y redis-server
echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list
echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
sudo apt-get update
sudo apt-get install -y sbt
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb
sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb
sudo apt update
sudo apt install -y mongodb-org
sudo systemctl start mongod
cd $home_directory
cd dev
cd lichess
cd lila
mongosh lichess bin/mongodb/indexes.js
./ui/build
jabba use openjdk@1.17.0
./lila run
