import 'package:expence_tracker/providers/multi_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../providers/expence_provider.dart';
import 'ListExpence.dart';


class MedicalExpence extends StatefulWidget {
  const MedicalExpence({Key? key}) : super(key: key);

  @override
  State<MedicalExpence> createState() => _MedicalExpenceState();
}

class _MedicalExpenceState extends State<MedicalExpence> {

  String cat='Medical Cost';

  @override
  void didChangeDependencies() {
    Provider.of<MultiScreenProvider>(context,listen: false).getExpence("Medical Cost");
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return ListExpence(cat);
  }
}
