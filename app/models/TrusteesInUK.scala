package models

import play.api.data.Form
import play.api.i18n.Messages
import uk.gov.hmrc.viewmodels._

sealed trait TrusteesInUK

object TrusteesInUK extends Enumerable.Implicits {

  case object AllTheTrusteesAreBasedInTheUk extends WithName("all the trustees are based in the UK") with TrusteesInUK
  case object None extends WithName("none") with TrusteesInUK

  val values: Seq[TrusteesInUK] = Seq(
    AllTheTrusteesAreBasedInTheUk,
    None
  )

  def checkboxes(form: Form[_])(implicit messages: Messages): Seq[Checkboxes.Item] = {

    val field = form("value")
    val items = Seq(
      Checkboxes.Checkbox(msg"trusteesInUK.all the trustees are based in the UK", AllTheTrusteesAreBasedInTheUk.toString),
      Checkboxes.Checkbox(msg"trusteesInUK.none", None.toString)
    )

    Checkboxes.set(field, items)
  }

  implicit val enumerable: Enumerable[TrusteesInUK] =
    Enumerable(values.map(v => v.toString -> v): _*)
}
