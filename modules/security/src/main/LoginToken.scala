package lila.security

import org.joda.time.DateTime

import lila.common.config.Secret
import lila.user.{ User, UserRepo }

final class LoginToken(secret: Secret, userRepo: UserRepo)(using Executor):

  def generate(user: User): Fu[String] = tokener make user.id

  def consume(token: String): Fu[Option[User]] =
    tokener read token flatMapz userRepo.byId

  private val tokener = LoginToken.makeTokener(secret, 1 minute)

private object LoginToken:

  import StringToken.DateStr

  def makeTokener(secret: Secret, lifetime: FiniteDuration)(using Executor) =
    new StringToken[UserId](
      secret = secret,
      getCurrentValue = _ => fuccess(DateStr toStr DateTime.now),
      currentValueHashSize = none,
      valueChecker = StringToken.ValueChecker.Custom(v =>
        fuccess {
          DateStr.toDate(v) exists DateTime.now.minusSeconds(lifetime.toSeconds.toInt).isBefore
        }
      )
    )
