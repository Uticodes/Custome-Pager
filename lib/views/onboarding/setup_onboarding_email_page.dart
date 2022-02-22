import 'package:customized_pager/views/onboarding/setup_onboarding_container_pages.dart'
    as sharedProvider;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/button.dart';

class SetupOnboardingEmailPage extends StatefulHookWidget {
  SetupOnboardingEmailPage();

  @override
  _SetupOnboardingEmailPageState createState() =>
      _SetupOnboardingEmailPageState();
}

class _SetupOnboardingEmailPageState extends State<SetupOnboardingEmailPage> {
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
                  Container(
                      child: const Text(
                          "Got it. Next, what’s your email",
                        textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black
                          ),

                          )),
                  const SizedBox(
                    height: 16,
                  ),

                  const SizedBox(
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
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                            "We won’t use this for anything else")
                      ],
                    ),
                    SizedBox(height: 16,),
                    Container(
                      margin: EdgeInsets.symmetric(
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
