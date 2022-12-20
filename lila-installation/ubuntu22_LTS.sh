# Run this first and restart your terminal!
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
# Do NOT use sudo to run this. Just run this normally, and enter password when prompted
# example: use: ./lila.sh, not sudo ./lila.sh if the file is called lila.sh
home_directory=$HOME
nvm install node
npm i -g pnpm
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
curl -fL https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz | gzip -d > cs
chmod +x cs
./cs setup
sudo apt install -y redis-server
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc > ~/mongodb.key
gpg --no-default-keyring --keyring ./mongodb_keyring.gpg --import mongodb.key
gpg --no-default-keyring --keyring ./mongodb_keyring.gpg --export > ./mongodb.gpg
sudo mv ./mongodb.gpg /etc/apt/trusted.gpg.d/
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
