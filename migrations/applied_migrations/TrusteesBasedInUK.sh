#!/bin/bash

echo ""
echo "Applying migration trusteesBasedInUK"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /trusteesBasedInUK                        controllers.trusteesBasedInUKController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /trusteesBasedInUK                        controllers.trusteesBasedInUKController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changetrusteesBasedInUK                  controllers.trusteesBasedInUKController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changetrusteesBasedInUK                  controllers.trusteesBasedInUKController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "trusteesBasedInUK.title = Are the trustees based in the UK?" >> ../conf/messages.en
echo "trusteesBasedInUK.heading = Are the trustees based in the UK?" >> ../conf/messages.en
echo "trusteesBasedInUK.all = All the trustees are based in the UK" >> ../conf/messages.en
echo "trusteesBasedInUK.none = None of the trustees are based in the UK" >> ../conf/messages.en
echo "trusteesBasedInUK.checkYourAnswersLabel = Are the trustees based in the UK?" >> ../conf/messages.en
echo "trusteesBasedInUK.error.required = Select trusteesBasedInUK" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitrarytrusteesBasedInUKUserAnswersEntry: Arbitrary[(trusteesBasedInUKPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[trusteesBasedInUKPage.type]";\
    print "        value <- arbitrary[trusteesBasedInUK].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitrarytrusteesBasedInUKPage: Arbitrary[trusteesBasedInUKPage.type] =";\
    print "    Arbitrary(trusteesBasedInUKPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to ModelGenerators"
awk '/trait ModelGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitrarytrusteesBasedInUK: Arbitrary[trusteesBasedInUK] =";\
    print "    Arbitrary {";\
    print "      Gen.oneOf(trusteesBasedInUK.values.toSeq)";\
    print "    }";\
    next }1' ../test/generators/ModelGenerators.scala > tmp && mv tmp ../test/generators/ModelGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(trusteesBasedInUKPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def trusteesBasedInUK: Option[Row] = userAnswers.get(trusteesBasedInUKPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"trusteesBasedInUK.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(msg\"trusteesBasedInUK.$answer\"),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.trusteesBasedInUKController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"trusteesBasedInUK.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration trusteesBasedInUK completed"
