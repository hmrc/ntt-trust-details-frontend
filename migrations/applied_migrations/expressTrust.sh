#!/bin/bash

echo ""
echo "Applying migration ExpressTrust"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /expressTrust                        controllers.ExpressTrustController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /expressTrust                        controllers.ExpressTrustController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeExpressTrust                  controllers.ExpressTrustController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeExpressTrust                  controllers.ExpressTrustController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "expressTrust.title = expressTrust" >> ../conf/messages.en
echo "expressTrust.heading = expressTrust" >> ../conf/messages.en
echo "expressTrust.checkYourAnswersLabel = expressTrust" >> ../conf/messages.en
echo "expressTrust.error.required = Select yes if expressTrust" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryExpressTrustUserAnswersEntry: Arbitrary[(ExpressTrustPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[ExpressTrustPage.type]";\
    print "        value <- arbitrary[Boolean].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryExpressTrustPage: Arbitrary[ExpressTrustPage.type] =";\
    print "    Arbitrary(ExpressTrustPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(ExpressTrustPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def expressTrust: Option[Row] = userAnswers.get(ExpressTrustPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"expressTrust.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(yesOrNo(answer)),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.ExpressTrustController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"expressTrust.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration ExpressTrust completed"
