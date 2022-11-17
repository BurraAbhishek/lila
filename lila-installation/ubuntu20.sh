sudo apt install build-essential
sudo apt install git
curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash && . ~/.jabba/jabba.sh
jabba ls-remote
jabba install openjdk@1.17.0
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
nvm install node
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
sudo apt update
sudo apt-get install -y mongodb-org
sudo apt install redis-server
npm install --global yarn
sudo systemctl start mongod
echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list
echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
sudo apt-get update
sudo apt-get install sbt
mkdir dev
cd dev
mkdir lichess
cd lichess
git clone --recursive https://github.com/lichess-org/lila.git
git clone --recursive https://github.com/lichess-org/lila-ws.git
git clone https://github.com/lichess-org/lila-db-seed.git
git clone https://github.com/lichess-org/lila.wiki.git
cd lila-db-seed
mongorestore dump
cd ..
export JAVA_HOME="$HOME/.jabba/jdk/openjdk@1.17.0"
export PATH="$JAVA_HOME/bin:$PATH"
sudo systemctl start mongod
./ui/build
./lila
