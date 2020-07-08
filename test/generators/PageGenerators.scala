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

package generators

import org.scalacheck.Arbitrary
import pages._

trait PageGenerators {

  implicit lazy val arbitraryPreviouslyBasedPage: Arbitrary[PreviouslyBasedPage.type] =
    Arbitrary(PreviouslyBasedPage)

  implicit lazy val arbitraryOffshoreTrustPage: Arbitrary[OffshoreTrustPage.type] =
    Arbitrary(OffshoreTrustPage)

  implicit lazy val arbitraryExpressTrustPage: Arbitrary[ExpressTrustPage.type] =
    Arbitrary(ExpressTrustPage)

  implicit lazy val arbitraryTrusteesBasedInUKPage: Arbitrary[TrusteesBasedInUKPage.type] =
    Arbitrary(TrusteesBasedInUKPage)

  implicit lazy val arbitraryTrustsNamePage: Arbitrary[TrustsNamePage.type] =
    Arbitrary(TrustsNamePage)

  implicit lazy val arbitraryDateTrustStartedPage: Arbitrary[DateTrustStartedPage.type] =
    Arbitrary(DateTrustStartedPage)

  implicit lazy val arbitrarySettlorsInUKPage: Arbitrary[SettlorsInUKPage.type] =
    Arbitrary(SettlorsInUKPage)
}
