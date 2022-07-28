import 'package:flutter/material.dart';
import 'package:iiti_go/common_widgets/searching_widget/chip_data.dart';
import 'package:iiti_go/constants/enums.dart';

class LocationChips {
  static final chips = <ChipData>[
    ChipData(label: sic, backgroundColor: Colors.blueGrey, shorcut: 'SIC'),
    ChipData(label: jcbose, backgroundColor: Colors.brown, shorcut: 'JC'),
    ChipData(
        label: healthcenter, backgroundColor: Colors.redAccent, shorcut: 'HC'),
    ChipData(
        label: pod1b,
        backgroundColor: const Color.fromARGB(255, 124, 181, 63),
        shorcut: 'P'),
    ChipData(label: library, backgroundColor: Colors.teal, shorcut: 'L'),
    ChipData(label: gate1, backgroundColor: Colors.pinkAccent, shorcut: '1'),
    ChipData(
        label: hub,
        backgroundColor: const Color.fromARGB(255, 39, 36, 239),
        shorcut: 'H'),
  ];
}
