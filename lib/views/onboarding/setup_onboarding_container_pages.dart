import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../main.dart';
import '../../viewmodel/base/base_view_model.dart';
import '../../viewmodel/pager_viewmodel.dart';


final userProfileProvider =
    ChangeNotifierProvider.autoDispose<PagerViewModel>((ref) {
  ref.onDispose(() {});
  final viewmodel = locator.get<PagerViewModel>();
  //viewmodel.getUserGenders();
  //Load all setup questions here

  return viewmodel;
});

final _eventStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(userProfileProvider).viewState;
});
final eventStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_eventStateProvider);
});

class SetupOnboardingPagerContainer extends StatefulHookWidget {
  final genderId;
  SetupOnboardingPagerContainer(this.genderId);

  @override
  _SetupOnboardingPagerContainerState createState() => _SetupOnboardingPagerContainerState();
}

class _SetupOnboardingPagerContainerState extends State<SetupOnboardingPagerContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final currentPage = useProvider(userProfileProvider).currentPage;
    final totalPages = context.read(userProfileProvider).pages.length - 1;
    final progress =
    (currentPage / totalPages == 0) ? 0.05 : currentPage / totalPages;

    final pageview = PageView(
        controller: context.read(userProfileProvider).controller,
        onPageChanged: (position) {
          context.read(userProfileProvider).pageChanged(position);
        },
        physics: new NeverScrollableScrollPhysics(),
        children: context.read(userProfileProvider).widgetPages);

    return Scaffold(
      //backgroundColor: Pallet.colorWhite,
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              pageview,
              Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () async{
                              if(context.read(userProfileProvider).currentPage == 0) {
                                Navigator.of(context).pop();
                              } else {
                                context.read(userProfileProvider).moveToPreviousPage();
                              }
                            },
                            child:
                            SvgPicture.asset("assets/images/arrow_back.svg")),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  width: size.width,
                  child: ClipRRect(
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 5,
                      backgroundColor: Colors.grey,
                      color: Colors.orange,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    context.read(userProfileProvider).controller.dispose();
    super.dispose();
  }
}