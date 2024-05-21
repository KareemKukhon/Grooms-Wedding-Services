import 'package:flutter/cupertino.dart';

class WidgetProvider extends ChangeNotifier {
  List<int> OTP = [];
  int currentPage = 0;
  int pageCount = 3;
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();

  saveOTP(List<int> otp) {
    OTP = otp;
    notifyListeners();
  }

  deleteOTP(int index) {
    OTP.removeAt(index);
    notifyListeners();
  }

  void nextPage() {
    currentPage = (currentPage + 1) % pageCount;
    notifyListeners();
  }

  void prevPage() {
    currentPage = (currentPage - 1 + pageCount) % pageCount;
    notifyListeners();
  }

  void notifyControllers() {
    controller1;
    controller2;
    controller3;
    controller4;
    notifyListeners();
  }
}
