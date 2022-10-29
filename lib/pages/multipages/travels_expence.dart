import 'package:expence_tracker/providers/multi_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../providers/expence_provider.dart';
import 'ListExpence.dart';


class TravelsExpence extends StatefulWidget {
  const TravelsExpence({Key? key}) : super(key: key);

  @override
  State<TravelsExpence> createState() => _TravelsExpenceState();
}

class _TravelsExpenceState extends State<TravelsExpence> {

  String cat="Travels Cost";

  @override
  void didChangeDependencies() {
    Provider.of<MultiScreenProvider>(context,listen: false).getExpence(cat);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return ListExpence(cat);
  }
}
