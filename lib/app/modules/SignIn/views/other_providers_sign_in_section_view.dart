import 'package:egot_services/app/modules/SignIn/controllers/sign_in_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import 'package:get/get.dart';

class OtherProvidersSignInSectionView extends GetView {
  const OtherProvidersSignInSectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(
        builder: (_) => Card(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: const Text('Social Authentication',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 16),
                        alignment: Alignment.center,
                        child: kIsWeb
                            ? const Text(
                                'When using Flutter Web, API keys are configured through the Firebase Console. The below providers demonstrate how this works')
                            : const Text(
                                'We do not provide an API to obtain the token for below providers apart from Google '
                                'Please use a third party service to obtain token for other providers.'),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 16),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                       /*     ListTile(
                              title: const Text('GitHub'),
                              leading: Radio<int>(
                                value: 0,
                                groupValue: _.selection,
                                onChanged: _.handleRadioButtonSelected,
                              ),
                            ),
                            Visibility(
                              visible: !kIsWeb,
                              child: ListTile(
                                title: const Text('Facebook'),
                                leading: Radio<int>(
                                  value: 1,
                                  groupValue: _.selection,
                                  onChanged: _.handleRadioButtonSelected,
                                ),
                              ),
                            ),
                            ListTile(
                              title: const Text('Twitter'),
                              leading: Radio<int>(
                                value: 2,
                                groupValue: _.selection,
                                onChanged: _.handleRadioButtonSelected,
                              ),
                            ),*/
                            ListTile(
                              title: const Text('Google'),
                              leading: Radio<int>(
                                value: 3,
                                groupValue: _.selection,
                                onChanged: _.handleRadioButtonSelected,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: _.showProviderTokenField && !kIsWeb,
                        child: TextField(
                          controller: _.tokenController,
                          decoration: const InputDecoration(
                              labelText: "Enter provider's token"),
                        ),
                      ),
                      Visibility(
                        visible: _.showAuthSecretTextField && !kIsWeb,
                        child: TextField(
                          controller: _.tokenSecretController,
                          decoration: const InputDecoration(
                              labelText: "Enter provider's authTokenSecret"),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 16, bottom: 27),
                        alignment: Alignment.center,
                        child: SignInButton(
                          _.provider == 'GitHub'
                              ? Buttons.GitHub
                              : (_.provider == 'Facebook'
                                  ? Buttons.Facebook
                                  : (_.provider == 'Twitter'
                                      ? Buttons.Twitter
                                      : Buttons.GoogleDark)),
                          text: 'Sign In',
                          onPressed: () async {
                            _.signInWithOtherProvider();
                          },
                        ),
                      ),
                    ],
                  )),
            ));
  }
}
