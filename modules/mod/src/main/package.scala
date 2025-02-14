package lila.mod

import lila.security.UserLogins
import lila.user.User
import org.joda.time.DateTime

export lila.Lila.{ *, given }

private val logger = lila.log("mod")

final class ModlogRepo(val coll: lila.db.dsl.Coll)
final class AssessmentRepo(val coll: lila.db.dsl.Coll)
final class HistoryRepo(val coll: lila.db.dsl.Coll)
final class ModQueueStatsRepo(val coll: lila.db.dsl.Coll)

case class UserWithModlog(user: User, log: List[Modlog.UserEntry]):
  export user.*
  def dateOf(action: Modlog.type => String): Option[DateTime] =
    log.find(_.action == action(Modlog)).map(_.date)

object UserWithModlog:
  given UserIdOf[UserWithModlog] = _.user.id
