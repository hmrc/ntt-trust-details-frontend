package generators

import models._
import org.scalacheck.Arbitrary
import org.scalacheck.Arbitrary.arbitrary
import pages._
import play.api.libs.json.{JsValue, Json}

trait UserAnswersEntryGenerators extends PageGenerators with ModelGenerators {

  implicit lazy val arbitraryTrusteesInUKUserAnswersEntry: Arbitrary[(TrusteesInUKPage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[TrusteesInUKPage.type]
        value <- arbitrary[TrusteesInUK].map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryTrustsNameUserAnswersEntry: Arbitrary[(TrustsNamePage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[TrustsNamePage.type]
        value <- arbitrary[String].suchThat(_.nonEmpty).map(Json.toJson(_))
      } yield (page, value)
    }
}
