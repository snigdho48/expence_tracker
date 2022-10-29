import 'package:expence_tracker/providers/multi_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../providers/expence_provider.dart';
import 'ListExpence.dart';

class EducationExpence extends StatefulWidget {
  const EducationExpence({Key? key}) : super(key: key);

  @override
  State<EducationExpence> createState() => _EducationExpenceState();
}

class _EducationExpenceState extends State<EducationExpence> {
  String cat = 'Education Cost';
  @override
  void didChangeDependencies() {
    Provider.of<MultiScreenProvider>(context, listen: false)
        .getExpence("Education Cost");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ListExpence(cat);

  }
}
