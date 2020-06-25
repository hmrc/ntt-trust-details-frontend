package generators

import models._
import org.scalacheck.Arbitrary.arbitrary
import org.scalacheck.{Arbitrary, Gen}

trait ModelGenerators {

  implicit lazy val arbitraryTrusteesInUK: Arbitrary[TrusteesInUK] =
    Arbitrary {
      Gen.oneOf(TrusteesInUK.values.toSeq)
    }
}
