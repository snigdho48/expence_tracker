
import 'package:expence_tracker/providers/multi_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../providers/expence_provider.dart';
import 'ListExpence.dart';

class FoodExpence extends StatefulWidget {
  const FoodExpence({Key? key}) : super(key: key);


  @override
  State<FoodExpence> createState() => _FoodExpenceState();
}

class _FoodExpenceState extends State<FoodExpence> {


  String cat='Food Cost';

  @override
  void didChangeDependencies() {
    Provider.of<MultiScreenProvider>(context,listen: false).getExpence("Food Cost");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ListExpence(cat);
  }
}
