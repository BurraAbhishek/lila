package lila.swiss

import org.joda.time.DateTime

import lila.user.User
import lila.db.dsl.{ *, given }
import lila.swiss.BsonHandlers.given
import lila.game.Game

case class SwissBan(_id: UserId, until: DateTime, hours: Int)

/*
 * Failure to play a swiss game results in a 24h ban from swiss events.
 * Consecutive failures result in doubling ban duration.
 * Playing a swiss game resets the duration.
 */
final class SwissBanApi(mongo: SwissMongo)(using Executor):

  def bannedUntil(user: UserId): Fu[Option[DateTime]] =
    mongo.ban.primitiveOne[DateTime]($id(user) ++ $doc("until" $gt DateTime.now), "until")

  def get(user: UserId): Fu[Option[SwissBan]] = mongo.ban.byId[SwissBan](user)

  def onGameFinish(game: Game) =
    game.userIds
      .map { userId =>
        if (game.playerWhoDidNotMove.exists(_.userId has userId)) onStall(userId)
        else onGoodGame(userId)
      }
      .sequenceFu
      .void

  private def onStall(user: UserId): Funit = get(user) flatMap { prev =>
    val hours: Int = prev
      .fold(24) { ban =>
        if (ban.until.isBefore(DateTime.now)) ban.hours * 2 // consecutive
        else (ban.hours * 1.5).toInt                        // simultaneous
      }
      .atMost(30 * 24)
    mongo.ban.update
      .one(
        $id(user),
        SwissBan(user, DateTime.now plusHours hours, hours),
        upsert = true
      )
      .void
  }

  private def onGoodGame(user: UserId) = mongo.ban.delete.one($id(user))
