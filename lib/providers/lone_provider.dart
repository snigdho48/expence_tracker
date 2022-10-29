import 'dart:math';

import 'package:expence_tracker/db/db_helper.dart';
import 'package:flutter/material.dart';

import '../models/loan_model.dart';


class LoneProvider extends ChangeNotifier{

  List<LoanModel>loneList=[];
  late int total,count;


  Future<int>insertLone(LoanModel LoanModel)=>
      DbHelper.insertLoan(LoanModel);

  void getAlllone()async{
    loneList=await DbHelper.getAllLoan();
    count=loneList.length;
    notifyListeners();
  }
  int gettotallone() {
    int total=0;
    for (var element in loneList) {total=total+(element.loan);}
    total=total;
    return total;
  }





}
