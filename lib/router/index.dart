import 'package:get/get.dart';
import 'package:task_app/screens/detail_screen.dart';
import 'package:task_app/screens/home_screen.dart';
import 'package:task_app/widgets/add_dialog.dart';

class RouteHelper {
  static const String initial = '/';
  static const String addDialog = '/add-dialog';
  static const String detailScreen = '/detail-screen';
  static String getInitial() => '$initial';
  static String getAddDialog() => '$addDialog';
  static String getDetailScreen() => '$detailScreen';

  static List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: addDialog,
      page: () => AddDialog(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: detailScreen,
      page: () => DetailPage(),
    ),
  ];
}
