import 'package:customized_pager/views/onboarding/setup_onboarding_container_pages.dart'
    as sharedProvider;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/button.dart';


class SetupOnboardingNamePage extends StatefulHookWidget {
  SetupOnboardingNamePage();

  @override
  _SetupOnboardingNamePageState createState() =>
      _SetupOnboardingNamePageState();
}

class _SetupOnboardingNamePageState extends State<SetupOnboardingNamePage> {
  String? _selectedOption;
  TextEditingController textController = new TextEditingController();

  @override
  void initState() {
    initialiseAnswer();
    super.initState();
  }

  Future<void> initialiseAnswer() async {
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      _selectedOption = context
          .read(sharedProvider.userProfileProvider)
          .getCurrentPageAnswer();
    });
    textController.text = _selectedOption ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final currentPage =
        useProvider(sharedProvider.userProfileProvider).currentPage;
    final isPageValidated =
        useProvider(sharedProvider.userProfileProvider).pages[currentPage];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: ListView(
                children: [
                  const SizedBox(
                    height: 72,
                  ),
                  const SizedBox(
                    child: Text(
                        "Ok, lets set up your profile! \nFirst, what’s your name?",
                      textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22
                        ) ,

                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Center(
                    child: Text(
                        "Please enter your first and last name",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22
                      ) ,),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  FocusScope(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: textController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value;
                            context
                                .read(sharedProvider.userProfileProvider)
                                .updatePageAnswers(value);
                            final input = value.toString().trim().split(" ");
                            context
                                .read(sharedProvider.userProfileProvider)
                                .pageValidated(input.length == 2);
                            input.first;
                          });
                        },
                        maxLines: null,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 16,
                ),
                child: BawoAppButton(
                    onPressed: () async {
                      context.read(sharedProvider.userProfileProvider).moveToNextPage();
                    },
                    title: 'Continue',
                    disabledColor: Colors.orange.withOpacity(0.2),
                    titleColor: Colors.white,
                    enabledColor: Colors.orange,
                    enabled: true),
              ),
            )
          ],
        ),
      ),
    );
  }
}
