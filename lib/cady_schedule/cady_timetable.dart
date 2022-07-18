import '../constants/list_constants.dart';

class CadyTimeTable {
  List<int> searchingRouteId({required String start, required String end}) {
    List<int> routeIds = [];
    cadyRoutesWithId.forEach((key, value) {
      if (value.contains(start) && value.contains(end)) {
        if (value.indexOf(start) < value.indexOf(end)) {
          routeIds.add(key);
        }
      }
    });
    return routeIds;
  }
}
