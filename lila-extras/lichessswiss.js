// Run it with `mongo lichess gen-lichess-swiss.js`

const makeLichessSwiss = {
  _id: "lichess-swiss",
  name: "Lichess Swiss",
  description: "The official Lichess Swiss team. We organize regular swiss tournaments for all to join.",
  nbMembers: 1,
  enabled: true,
  open: true,
  createdAt: ISODate('2021-01-01T00:00:00'),
  createdBy: 'lichess',
  leaders: [ 'lichess' ],
  chat: 20,
  forum: 20
};

const addLichessToLichessSwiss = {
    _id: 'lichess@lichess-swiss',
    team: 'lichess-swiss',
    user: 'lichess',
    date: ISODate('2021-01-01T00:00:00')
  }

db.team.insertOne(makeLichessSwiss);
db.team_member.insertOne(addLichessToLichessSwiss);
