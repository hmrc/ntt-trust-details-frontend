package generators

import org.scalacheck.Arbitrary
import pages._

trait PageGenerators {

  implicit lazy val arbitraryTrusteesInUKPage: Arbitrary[TrusteesInUKPage.type] =
    Arbitrary(TrusteesInUKPage)

  implicit lazy val arbitraryTrustsNamePage: Arbitrary[TrustsNamePage.type] =
    Arbitrary(TrustsNamePage)
}
