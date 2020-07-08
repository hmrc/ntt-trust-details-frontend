#!/bin/bash

echo ""
echo "Applying migration previouslyBased"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /previouslyBased                        controllers.PreviouslyBasedController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /previouslyBased                        controllers.PreviouslyBasedController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changepreviouslyBased                  controllers.PreviouslyBasedController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changepreviouslyBased                  controllers.PreviouslyBasedController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "previouslyBased.title = previouslyBased" >> ../conf/messages.en
echo "previouslyBased.heading = previouslyBased" >> ../conf/messages.en
echo "previouslyBased.checkYourAnswersLabel = previouslyBased" >> ../conf/messages.en
echo "previouslyBased.error.required = Enter previouslyBased" >> ../conf/messages.en
echo "previouslyBased.error.length = previouslyBased must be 100 characters or less" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryPreviouslyBasedUserAnswersEntry: Arbitrary[(PreviouslyBasedPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[PreviouslyBasedPage.type]";\
    print "        value <- arbitrary[String].suchThat(_.nonEmpty).map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryPreviouslyBasedPage: Arbitrary[PreviouslyBasedPage.type] =";\
    print "    Arbitrary(PreviouslyBasedPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(PreviouslyBasedPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def PreviouslyBased: Option[Row] = userAnswers.get(PreviouslyBasedPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"previouslyBased.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(lit\"$answer\"),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.PreviouslyBasedController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"previouslyBased.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration PreviouslyBased completed"
