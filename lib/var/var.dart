import 'package:Rafeed/models/AdModel.dart';
import 'package:Rafeed/models/categoryModel.dart';
import 'package:Rafeed/models/userModel.dart';

bool flag = false;
bool isFirstTime = true;
String auth = "";

double longitude = 35.227163;
double latitude = 31.947351;

// TextEditingController? neighborhood;
String? dropdownValue = 'صباحا';
String? selectedCity;
DateTime? dateTime = DateTime.now();
int? marriageDays;
//  https://rafeedsa.com:8083/
String server = "https://rafeedsa.com:8083";
String secretPassword = '';
List<Category> categories = [];
List<Ad> allAds = [];

bool isLogin = false;
