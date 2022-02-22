import 'package:customized_pager/views/onboarding/setup_onboarding_container_pages.dart'
    as sharedProvider;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/button.dart';

class SetupOnboardingPhonePage extends StatefulHookWidget {
  SetupOnboardingPhonePage();

  @override
  _SetupOnboardingPhonePageState createState() =>
      _SetupOnboardingPhonePageState();
}

class _SetupOnboardingPhonePageState extends State<SetupOnboardingPhonePage> {
  String? _selectedOption;
  TextEditingController textController = new TextEditingController();
  String countryCode = '+1';

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
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width - 150;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: ListView(
                children: const [
                  SizedBox(
                    height: 72,
                  ),
                  Text(
                      "Next, what’s your phone number?",
                      textAlign: TextAlign.center,
                      ),
                  SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Text(
                        "This is so you can verify your account",
                        ),
                  ),
                  SizedBox(
                    height: 32,
                  ),

                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 96,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/lock.svg"),
                        SizedBox(
                          width: 8,
                        ),
                        const Text(
                            "We won’t use this for anything else")
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
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
                          )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
