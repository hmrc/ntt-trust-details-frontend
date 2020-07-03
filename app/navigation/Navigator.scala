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

package navigation

import javax.inject.{Inject, Singleton}

import play.api.mvc.Call
import controllers.routes
import pages._
import models._

@Singleton
class Navigator @Inject()() {

  private val normalRoutes: Page => UserAnswers => Call = {
    case TrustsNamePage        => _ => routes.DateTrustStartedController.onPageLoad(NormalMode)
    case DateTrustStartedPage  => _ => routes.TrusteesBasedInUKController.onPageLoad(NormalMode)
    case TrusteesBasedInUKPage => _ => routes.SettlorsInUKController.onPageLoad(NormalMode)
    case SettlorsInUKPage      => _ => routes.OffshoreTrustController.onPageLoad(NormalMode)
    case OffshoreTrustPage     => _ => routes.PreviouslyBasedController.onPageLoad(NormalMode)
    case PreviouslyBasedPage   => _ => routes.ExpressTrustController.onPageLoad(NormalMode)
    case ExpressTrustPage      => _ => routes.CheckYourAnswersController.onPageLoad()
  }

  private val checkRouteMap: Page => UserAnswers => Call = {
    case _ => _ => routes.CheckYourAnswersController.onPageLoad()
  }

  def nextPage(page: Page, mode: Mode, userAnswers: UserAnswers): Call = mode match {
    case NormalMode =>
      normalRoutes(page)(userAnswers)
    case CheckMode =>
      checkRouteMap(page)(userAnswers)
  }
}
