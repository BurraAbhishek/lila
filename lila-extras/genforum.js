// Run it with `mongo lichess gen-forum.js`

const makeForumPost = (postId, topicId, categId) => ({
  _id : postId,
  topicId : topicId,
  categId : categId,
  text : 'Welcome fellow lila devs!',
  number : 1,
  troll : false,
  hidden : false,
  createdAt : ISODate('2020-06-20T19:32:44.134Z'),
  userId : 'lichess',
  lang : 'en',
  modIcon : true,
});

const makeForumTopic = (topicId, postId, categId) => ({
  _id : topicId,
  categId : categId,
  slug : 'welcome-devs',
  name : 'Welcome devs!',
  views : 14,
  createdAt : ISODate('2020-06-20T19:32:44.128Z'),
  updatedAt : ISODate('2020-06-20T19:32:44.128Z'),
  nbPosts : 1,
  lastPostId : postId,
  updatedAtTroll : ISODate('2020-06-20T19:32:44.128Z'),
  nbPostsTroll : 1,
  lastPostIdTroll : postId,
  troll : false,
  closed : false,
  hidden : false,
  userId : 'lichess',
});

const makeForumCateg = (categId, name, desc, postId) => ({
  _id : categId,
  name : name,
  desc : desc,
  pos : 1,
  nbTopics : 1,
  nbPosts : 1,
  lastPostId: postId,
  nbTopicsTroll : 1,
  nbPostsTroll : 1,
  lastPostIdTroll : postId,
  quiet : false,
});

const feedback = {
  id : 'lichess-feedback',
  name : 'Lichess Feedback',
  desc : 'Bug reports, feature requests, suggestions',
  postId : 'p1111111',
  topicId : 't0000000',
};

const gameAnalysis = {
  id : 'game-analysis',
  name : 'Game analysis',
  desc : 'Show your game and analyse it with the community',
  postId : 'p1111112',
  topicId : 't0000001',
};

const gen = {
  id : 'general-chess-discussion',
  name : 'General Chess Discussion',
  desc : 'The place to discuss general chess topics',
  postId : 'p1111113',
  topicId : 't0000002',
};

const ot = {
  id : 'off-topic-discussion',
  name : 'Off-Topic Discussion',
  desc : 'Everything that isn\'t related to chess',
  postId : 'p1111114',
  topicId : 't0000003',
};


[feedback, gameAnalysis, gen, ot].forEach(function(x) {
  db.f_post.insertOne(makeForumPost(x.postId, x.topicId, x.id));
  db.f_topic.insertOne(makeForumTopic(x.topicId, x.postId, x.id));
  db.f_categ.insertOne(makeForumCateg(x.id, x.name, x.desc, x.postId));
});
