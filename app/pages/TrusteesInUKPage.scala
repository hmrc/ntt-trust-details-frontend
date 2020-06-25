package pages

import models.TrusteesInUK
import play.api.libs.json.JsPath

case object TrusteesInUKPage extends QuestionPage[Set[TrusteesInUK]] {

  override def path: JsPath = JsPath \ toString

  override def toString: String = "trusteesInUK"
}
