package utils

import java.time.format.DateTimeFormatter

import controllers.routes
import models.{CheckMode, UserAnswers}
import pages._
import play.api.i18n.Messages
import CheckYourAnswersHelper._
import uk.gov.hmrc.viewmodels._
import uk.gov.hmrc.viewmodels.SummaryList._
import uk.gov.hmrc.viewmodels.Text.Literal

class CheckYourAnswersHelper(userAnswers: UserAnswers)(implicit messages: Messages) {

  def trusteesInUK: Option[Row] = userAnswers.get(TrusteesInUKPage) map {
    answer =>
      Row(
        key     = Key(msg"trusteesInUK.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(Html(answer.map(a => msg"trusteesInUK.$a".resolve).mkString(",<br>"))),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.TrusteesInUKController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"trusteesInUK.checkYourAnswersLabel"))
          )
        )
      )
  }

  def trustsName: Option[Row] = userAnswers.get(TrustsNamePage) map {
    answer =>
      Row(
        key     = Key(msg"trustsName.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(lit"$answer"),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.TrustsNameController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"trustsName.checkYourAnswersLabel"))
          )
        )
      )
  }

  private def yesOrNo(answer: Boolean): Content =
    if (answer) {
      msg"site.yes"
    } else {
      msg"site.no"
    }
}

object CheckYourAnswersHelper {

  private val dateFormatter = DateTimeFormatter.ofPattern("d MMMM yyyy")
}
