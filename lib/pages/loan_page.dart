import 'package:expence_tracker/pages/loan_add.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../providers/lone_provider.dart';

class LoanPage extends StatefulWidget {
  static const  String routeName="/loanpage";
   LoanPage({Key? key}) : super(key: key);

  @override
  State<LoanPage> createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage> {
  int total=0;

  String cat='';

  @override
  void didChangeDependencies() {
    Provider.of<LoneProvider>(context,listen: false).getAlllone();
    total = Provider.of<LoneProvider>(context, listen: true).gettotallone();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: (){
          Navigator.pushNamed(context, LoanAdd.routeName);
        },
        child:const Icon(Icons.add,size: 30,),
      ),
      backgroundColor:HexColor("#D0E0E8") ,
      appBar: AppBar(
        title:const Text("Loan Page"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height*0.80,
            child: Consumer<LoneProvider>(
                builder:(context,provider,child)=>ListView.builder(
                  itemCount:provider.loneList.length,
                  itemBuilder: (context, index) {
                    final loan = provider.loneList[index];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,top: 7),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: Text(loan.lendersName,style:const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                            subtitle: Text(loan.loanDate),
                            trailing:Column(
                              children: [
                                Text("\$ ${loan.loan.toString()}",style:const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                const SizedBox(height: 9,),
                                Text(" last date: ${loan.lastDate}",style:const TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)),
                              ],
                            ),
                            tileColor: Colors.green,
                          ),
                        ),
                      ],
                    );
                  },
                )
            ),
          ),


          Expanded(
            child: Container(
              color:HexColor("#D0E0E8"),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min ,
                children:[Text('Total Loan: ''$total',style: const TextStyle(fontSize: 20,color: Colors.green,fontWeight: FontWeight.bold),)],
              ),
            ),
          ),

        ],
      ),
    );
  }
}

