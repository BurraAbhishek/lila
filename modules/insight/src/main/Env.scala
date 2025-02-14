package lila.insight

import com.softwaremill.macwire.*
import com.softwaremill.tagging.*
import play.api.Configuration

import lila.common.config.*

@Module
final class Env(
    appConfig: Configuration,
    gameRepo: lila.game.GameRepo,
    userRepo: lila.user.UserRepo,
    analysisRepo: lila.analyse.AnalysisRepo,
    prefApi: lila.pref.PrefApi,
    relationApi: lila.relation.RelationApi,
    cacheApi: lila.memo.CacheApi,
    mongo: lila.db.Env
)(using
    ec: Executor,
    scheduler: akka.actor.Scheduler,
    mat: akka.stream.Materializer
):

  lazy val db = mongo
    .asyncDb(
      "insight",
      appConfig.get[String]("insight.mongodb.uri")
    )
    .taggedWith[InsightDb]

  lazy val share = wire[Share]

  lazy val jsonView = wire[JsonView]

  private lazy val storage = InsightStorage(db(CollName("insight")))

  private lazy val aggregationPipeline = wire[AggregationPipeline]

  private lazy val povToEntry = wire[PovToEntry]

  private lazy val indexer: InsightIndexer = wire[InsightIndexer]

  lazy val perfStatsApi = wire[InsightPerfStatsApi]

  lazy val api = wire[InsightApi]

  lila.common.Bus.subscribeFun("analysisReady") { case lila.analyse.actorApi.AnalysisReady(game, _) =>
    api.updateGame(game).unit
  }

trait InsightDb
