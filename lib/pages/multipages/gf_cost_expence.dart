import 'package:expence_tracker/providers/multi_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../providers/expence_provider.dart';
import 'ListExpence.dart';


class GfCostExpence extends StatefulWidget {
  const GfCostExpence({Key? key}) : super(key: key);

  @override
  State<GfCostExpence> createState() => _GfCostExpenceState();
}

class _GfCostExpenceState extends State<GfCostExpence> {

  String cat='Gf Cost';

  @override
  void didChangeDependencies() {
    Provider.of<MultiScreenProvider>(context,listen: false).getExpence("Gf Cost");
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return ListExpence(cat);
  }
}
