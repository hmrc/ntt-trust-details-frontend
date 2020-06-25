package forms

import javax.inject.Inject

import forms.mappings.Mappings
import play.api.data.Form

class TrustsNameFormProvider @Inject() extends Mappings {

  def apply(): Form[String] =
    Form(
      "value" -> text("trustsName.error.required")
        .verifying(maxLength(100, "trustsName.error.length"))
    )
}
