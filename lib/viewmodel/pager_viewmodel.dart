import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../views/onboarding/setup_onboarding_email_page.dart';
import '../views/onboarding/setup_onboarding_name_page.dart';
import '../views/onboarding/setup_onboarding_phone_page.dart';
import 'base/base_view_model.dart';

class PagerViewModel extends BaseViewModel {
  //List<Gender> userGenders = [];
  Set<String> currentUserGender = Set();
  ViewState _state = ViewState.Idle;
  ViewState get viewState => _state;
  String image = "";
  String errorMessage = "";
  bool isValidImage = false;
  bool isValidOnboaridngImages = false;
  String? base64Image;
  String selectedGender = "";
  String _searchString = "";
  String phoneNumber = "";
  Timer? debouncer;
  bool isValidBirthDate = false;
  List<String> onboardingTwoImages = ["", ""];

  TextEditingController d1Controller = new TextEditingController();
  TextEditingController d2Controller = new TextEditingController();
  TextEditingController m1Controller = new TextEditingController();
  TextEditingController m2Controller = new TextEditingController();
  TextEditingController y1Controller = new TextEditingController();
  TextEditingController y2Controller = new TextEditingController();
  TextEditingController y3Controller = new TextEditingController();
  TextEditingController y4Controller = new TextEditingController();

  int currentPage = 0;
  bool isHidePassword = true;
  PageController controller = PageController(
    initialPage: 0,
  );
  final widgetPages = [
    Container(
        padding: const EdgeInsets.only(bottom: 40), child: SetupOnboardingNamePage()),
    Container(padding: const EdgeInsets.only(bottom: 40), child: SetupOnboardingEmailPage()),
    Container(padding: const EdgeInsets.only(bottom: 40), child: SetupOnboardingPhonePage()),

    Container(padding: const EdgeInsets.only(bottom: 40), child: SetupOnboardingNamePage()),
    Container(padding: const EdgeInsets.only(bottom: 40), child: SetupOnboardingEmailPage()),
  ];
  late var pages = _initWidgetPages();
  late var pagesAnswers = _initSetupAnswers();
  var genderId = 0;
  List<bool> _initWidgetPages() {
    return List<bool>.filled(widgetPages.length, false, growable: false);
  }

  List<dynamic> _initSetupAnswers() {
    return List<dynamic>.filled(widgetPages.length, null, growable: false);
  }

  void moveToNextPage() {
    controller.jumpToPage(currentPage + 1);
  }

  void moveToPreviousPage() {
    controller.jumpToPage(currentPage - 1);
  }

  void pageChanged(int position) {
    currentPage = position;
    notifyListeners();
  }

  void pageValidated(bool validated) {
    pages[currentPage] = validated;
    notifyListeners();
  }

  void updatePageAnswers(dynamic answer) {
    pagesAnswers[currentPage] = answer;
    notifyListeners();
  }

  dynamic getCurrentPageAnswer() {
    final index = currentPage;
    return pagesAnswers[index];
  }

  dynamic getPreviousPageAnswer() {
    final index = currentPage - 1;
    return pagesAnswers[index];
  }

  void togglePassword() {
    isHidePassword = !isHidePassword;
    notifyListeners();
  }

  void setViewState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  void setError(String error) {
    errorMessage = error;
    notifyListeners();
  }

  void setImage(image) {
    this.image = image;
    notifyListeners();
  }

  bool isValidUploadImage() {
    return isValidImage = image.isNotEmpty;
  }

  void setupOnboardingImages(images) {
    this.onboardingTwoImages = images;
    notifyListeners();
  }

  bool isValidOnboardingUploadImages() {
    return isValidOnboaridngImages = onboardingTwoImages.first.isNotEmpty &&
        onboardingTwoImages.last.isNotEmpty;
  }

  void validateDOB() {
    isValidBirthDate = d1Controller.text.trim().isNotEmpty &&
        d2Controller.text.trim().isNotEmpty &&
        m1Controller.text.trim().isNotEmpty &&
        m2Controller.text.trim().isNotEmpty &&
        y1Controller.text.trim().isNotEmpty &&
        y2Controller.text.trim().isNotEmpty &&
        y3Controller.text.trim().isNotEmpty &&
        y4Controller.text.trim().isNotEmpty;

    notifyListeners();
  }

}
