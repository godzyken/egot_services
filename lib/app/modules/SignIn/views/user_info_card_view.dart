import 'package:egot_services/app/modules/SignIn/controllers/sign_in_controller.dart';
import 'package:egot_services/app/modules/SignIn/views/update_user_dialog_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class UserInfoCardView extends GetView {
  const UserInfoCardView({Key? key}) : super(key: key);

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
                      padding: const EdgeInsets.only(bottom: 8),
                      alignment: Alignment.center,
                      child: const Text(
                        'User info',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (_.user != null)
                      if (_.user!.photoURL != null)
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Image.network(_.user!.photoURL!),
                        )
                      else
                        Align(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(bottom: 8),
                            color: Colors.black,
                            child: const Text(
                              'No image',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    Text(_.user == null
                        ? 'Not Signed in'
                        : '${_.user!.isAnonymous ? 'User is anonymous\n\n' : ''}'
                            'Email: ${_.user!.email} (verified: ${_.user!.emailVerified})\n\n'
                            'Phone number: ${_.user!.phoneNumber}\n\n'
                            'Name: ${_.user!.displayName}\n\n\n'
                            'ID: ${_.user!.uid}\n\n'
                            'Tenant ID: ${_.user!.tenantId}\n\n'
                            'Refresh token: ${_.user!.refreshToken}\n\n\n'
                            'Created: ${_.user!.metadata.creationTime.toString()}\n\n'
                            'Last login: ${_.user!.metadata.lastSignInTime}\n\n'),
                    if (_.user != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            _.user!.providerData.isEmpty
                                ? 'No providers'
                                : 'Providers:',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          for (var provider in _.user!.providerData)
                            Dismissible(
                              key: Key(provider.uid!),
                              onDismissed: (action) =>
                                  _.user!.unlink(provider.providerId),
                              child: Card(
                                color: Colors.grey[300],
                                child: ListTile(
                                  leading: provider.photoURL == null
                                      ? IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: () => _.user!
                                              .unlink(provider.providerId))
                                      : Image.network(provider.photoURL!),
                                  title: Text(provider.providerId),
                                  subtitle: Text(
                                      "${provider.uid == null ? "" : "ID: ${provider.uid}\n"}"
                                      "${provider.email == null ? "" : "Email: ${provider.email}\n"}"
                                      "${provider.phoneNumber == null ? "" : "Phone number: ${provider.phoneNumber}\n"}"
                                      "${provider.displayName == null ? "" : "Name: ${provider.displayName}\n"}"),
                                ),
                              ),
                            ),
                        ],
                      ),
                    Visibility(
                        visible: _.user != null,
                        child: Container(
                          margin: const EdgeInsets.only(top: 8),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              IconButton(
                                onPressed: () => _.user!.reload(),
                                icon: const Icon(Icons.refresh),
                              ),
                              IconButton(
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) =>
                                      const UpdateUserDialogView(),
                                ),
                                icon: const Icon(Icons.text_snippet),
                              ),
                              IconButton(
                                onPressed: () => _.user!.delete(),
                                icon: const Icon(Icons.delete_forever),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ));
  }
}
