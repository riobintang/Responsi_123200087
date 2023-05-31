import 'base_Network.dart';

class Controller {
  static Controller instance = Controller();

  Future<Map<String, dynamic>> loadCategory() {
    return BaseNetwork.get("categories.php");
  }

  Future<Map<String, dynamic>> loadMeals(String category) {
    return BaseNetwork.get("filter.php?c=" + category);
  }

  Future<Map<String, dynamic>> loadFoodDetail(String id) {
      print(id);
    return BaseNetwork.get("lookup.php?i=" + id);
  }
}
