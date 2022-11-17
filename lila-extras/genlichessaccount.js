// Run it with `mongo lichess gen-lichess-account.js`

const makeLichessAccount = {
  _id: 'lichess',
  username: 'Lichess',
  email: 'lichess@gmail.com',
  bpass: BinData(0, 'iO9XlIIKKujwzIxjh0h312gsKYiohjlNnhz+W8aa7+RmtobKvvjZ'), // password is "Lichess"
  perfs: {},
  count: { ai: 0, draw: 0, drawH: 0, game: 0, loss: 0, lossH: 0, rated: 0, win: 0, winH: 0 },
  enabled: true,
  createdAt: ISODate('2010-11-22T00:00:00.000Z'),
  seenAt: ISODate('2010-11-22T00:00:00.000Z'),
  time: { total: 0, tv: 0 },
  len: 7,
  lang: 'en-GB',
  roles: [
    'ROLE_VERIFIED',
    'ROLE_DEVELOPER',
    'ROLE_TEACHER',
    'ROLE_COACH',
    'ROLE_API_CHALLENGE_ADMIN',
    'ROLE_PUBLIC_MOD',
    'ROLE_BETA',
    'ROLE_SUPER_ADMIN',
    'ROLE_CONTENT_TEAM',
  ],
  plan: { months: 1, active: true, since: ISODate("2018-07-20T00:00:00.000Z")},
  profile: {"country": "_lichess"}
};

const makeLichessLifetimePatron = {
  "_id": "lichess",
  "free": {
    "at": ISODate("2018-07-20T00:00:00.000Z")
  },
  "lastLevelUp": ISODate("2018-07-20T00:00:00.000Z"),
  "lifetime": true
}

db.user4.insertOne(makeLichessAccount);
db.plan_patron.insertOne(makeLichessLifetimePatron);
