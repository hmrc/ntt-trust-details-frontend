package forms

import javax.inject.Inject

import forms.mappings.Mappings
import play.api.data.Form
import play.api.data.Forms.set
import models.TrusteesInUK

class TrusteesInUKFormProvider @Inject() extends Mappings {

  def apply(): Form[Set[TrusteesInUK]] =
    Form(
      "value" -> set(enumerable[TrusteesInUK]("trusteesInUK.error.required")).verifying(nonEmptySet("trusteesInUK.error.required"))
    )
}
