#!/bin/bash

echo ""
echo "Applying migration TrusteesBasedInUK"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /trusteesBasedInUK                        controllers.TrusteesBasedInUKController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /trusteesBasedInUK                        controllers.TrusteesBasedInUKController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeTrusteesBasedInUK                  controllers.TrusteesBasedInUKController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeTrusteesBasedInUK                  controllers.TrusteesBasedInUKController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "trusteesBasedInUK.title = Are the trustees based in the UK" >> ../conf/messages.en
echo "trusteesBasedInUK.heading = Are the trustees based in the UK" >> ../conf/messages.en
echo "trusteesBasedInUK.all = All the trustees are based in the UK" >> ../conf/messages.en
echo "trusteesBasedInUK.none = None of the trustees are based in the UK" >> ../conf/messages.en
echo "trusteesBasedInUK.checkYourAnswersLabel = Are the trustees based in the UK" >> ../conf/messages.en
echo "trusteesBasedInUK.error.required = Select trusteesBasedInUK" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryTrusteesBasedInUKUserAnswersEntry: Arbitrary[(TrusteesBasedInUKPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[TrusteesBasedInUKPage.type]";\
    print "        value <- arbitrary[TrusteesBasedInUK].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryTrusteesBasedInUKPage: Arbitrary[TrusteesBasedInUKPage.type] =";\
    print "    Arbitrary(TrusteesBasedInUKPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to ModelGenerators"
awk '/trait ModelGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryTrusteesBasedInUK: Arbitrary[TrusteesBasedInUK] =";\
    print "    Arbitrary {";\
    print "      Gen.oneOf(TrusteesBasedInUK.values.toSeq)";\
    print "    }";\
    next }1' ../test/generators/ModelGenerators.scala > tmp && mv tmp ../test/generators/ModelGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(TrusteesBasedInUKPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def trusteesBasedInUK: Option[Row] = userAnswers.get(TrusteesBasedInUKPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"trusteesBasedInUK.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(Html(answer.map(a => msg\"trusteesBasedInUK.$a\".resolve).mkString(\",<br>\"))),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.TrusteesBasedInUKController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"trusteesBasedInUK.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration TrusteesBasedInUK completed"
