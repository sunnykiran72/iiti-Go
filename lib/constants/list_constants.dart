// List of routes for schedule

import 'enums.dart';

const Map<int, List<String>> cadyRoutesWithId = {
  1: [healthcenter, jcbose, pod1b, library, gate1],
  2: [gate1, library, pod1b, jcbose, healthcenter],
  3: [library, hub, sic],
  4: [sic, hub, library],
};

const Map<int, List<String>> cadyIdWithTime = {
  1: [
    '10:00',
    '10:30',
    '11:00',
    '11:30',
    '12:00',
    '12:30',
    '13:00',
    '13:30',
    '14:00',
    '14:30',
    '15:00',
    '15:30',
    '16:00',
    '16:30',
    '17:00',
    '17:30'
  ],
  2: [
    '10:15',
    '10:45',
    '11:15',
    '11:45',
    '12:15',
    '12:45',
    '13:15',
    '13:45',
    '14:15',
    '14:45',
    '15:15',
    '15:45',
    '16:15',
    '16:45',
    '17:15',
    '17:45'
  ],
  3: [
    '10:00',
    '10:30',
    '11:00',
    '11:30',
    '12:00',
    '12:30',
    '13:00',
    '13:30',
    '14:00',
    '14:30',
    '15:00',
    '15:30',
    '16:00',
    '16:30',
    '17:00',
    '17:30'
  ],
  4: [
    '10:15',
    '10:45',
    '11:15',
    '11:45',
    '12:15',
    '12:45',
    '13:15',
    '13:45',
    '14:15',
    '14:45',
    '15:15',
    '15:45',
    '16:15',
    '16:45',
    '17:15',
    '17:45'
  ],
};

const Map<int, List<String>> routeIdMapGeoFence = {
  7: [healthcenter, jcbose, pod1b, library, gate1],
  //2: [gate1, library, pod1b, jcbose, healthcenter],
  6: [library, hub, sic],
  // 4: [sic, hub, library],
};

const Map<int, int> routeIdMapGeoFence1 = {6: 3};
