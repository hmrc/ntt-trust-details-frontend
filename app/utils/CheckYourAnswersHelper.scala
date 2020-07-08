/*
 * Copyright 2020 HM Revenue & Customs
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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

  def trusteesBasedInUK: Option[Row] = userAnswers.get(TrusteesBasedInUKPage) map {
    answer =>
      Row(
        key     = Key(msg"trusteesBasedInUK.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(msg"trusteesBasedInUK.$answer"),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.TrusteesBasedInUKController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"trusteesBasedInUK.checkYourAnswersLabel"))
          )
        )
      )
  }

  def previouslyBased: Option[Row] = userAnswers.get(PreviouslyBasedPage) map {
    answer =>
      Row(
        key     = Key(msg"previouslyBased.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(lit"$answer"),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.PreviouslyBasedController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"previouslyBased.checkYourAnswersLabel"))
          )
        )
      )
  }

  def offshoreTrust: Option[Row] = userAnswers.get(OffshoreTrustPage) map {
    answer =>
      Row(
        key     = Key(msg"offshoreTrust.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(yesOrNo(answer)),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.OffshoreTrustController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"offshoreTrust.checkYourAnswersLabel"))
          )
        )
      )
  }

  def expressTrust: Option[Row] = userAnswers.get(ExpressTrustPage) map {
    answer =>
      Row(
        key     = Key(msg"expressTrust.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(yesOrNo(answer)),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.ExpressTrustController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"expressTrust.checkYourAnswersLabel"))
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

  def dateTrustStarted: Option[Row] = userAnswers.get(DateTrustStartedPage) map {
    answer =>
      Row(
        key     = Key(msg"dateTrustStarted.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(Literal(answer.format(dateFormatter))),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.DateTrustStartedController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"dateTrustStarted.checkYourAnswersLabel"))
          )
        )
      )
  }

  def settlorsInUK: Option[Row] = userAnswers.get(SettlorsInUKPage) map {
    answer =>
      Row(
        key     = Key(msg"settlorsInUK.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(yesOrNo(answer)),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.SettlorsInUKController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"settlorsInUK.checkYourAnswersLabel"))
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
