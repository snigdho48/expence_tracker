import 'package:expence_tracker/pages/expense_add_page.dart';
import 'package:expence_tracker/pages/loan_add.dart';
import 'package:expence_tracker/pages/loan_page.dart';
import 'package:expence_tracker/pages/multi_screen_pages.dart';
import 'package:expence_tracker/providers/expence_provider.dart';
import 'package:expence_tracker/providers/lone_provider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../utils/notifications_util.dart';
import '../utils/pie_cart.dart';
import 'destinatio_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/homepage";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final NotificationService notificationService;
  @override
  void initState() {
    notificationService = NotificationService();
    listenToNotificationStream();
    notificationService.init();
    super.initState();
  }

  void listenToNotificationStream() =>
      notificationService.behaviorSubject.listen((payload) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(payload: payload)));
      });


  @override
  void didChangeDependencies() {
    Provider.of<ExpenceProvider>(context,listen: false).getAllExpence();
    Provider.of<LoneProvider>(context,listen: false).getAlllone();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:HexColor("#D0E0E8") ,
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),

                  )
              ),
              onPressed: (){
                Navigator.pushNamed(context, MultiScreenPages.routeName);
              },
              child:const Text("Show Catagory")
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
              onPressed: (){
                Navigator.pushNamed(context, LoanPage.routeName);
              },
              child:const Text("Show Lone")
          )
        ],
        elevation: 0,
      ),
      body: Consumer<ExpenceProvider>(
            builder:(context,provider,child)=> Column(
              children: [
                Container(
                  color:HexColor("#D0E0E8") ,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          "Total Expences: \$ ${provider.gettotalexpence()}", style: const TextStyle(fontSize: 28, color: Colors.green),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Total Lone: \$ ${Provider.of<LoneProvider>(context,listen: false).gettotallone() }", style: const TextStyle(fontSize: 28, color: Colors.green),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Pie_chart(context,provider),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0,right: 14.0),
                        child: Row(
                          children: const [
                            Text('Expences',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Spacer(),
                            Text('Cost',style: TextStyle(color: Colors.red,fontSize: 18, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 7,
                  child:Container(
                    height: MediaQuery.of(context).size.height*1.5,
                    child: ListView.builder(
                      // //physics: ScrollableScrollPhysics(),
                      // shrinkWrap: false,
                      itemCount:provider.expenceList.length,
                      itemBuilder: (context, index) {
                        final expence = provider.expenceList[index];
                          return Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,top: 7),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: Text(expence.catagory,style:const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                            subtitle: Text(expence.datetime),
                            trailing: Text("\$ ${expence.cost.toString()}",style:const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                            tileColor: Colors.green,

                          ),
                        );
                      },

                    ),
                  ),
                ),

                Expanded(
                  child:Container(
                    height: 20,
                      color:HexColor("#D0E0E8") ,
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                       ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )
                          ),
                          onPressed: (){
                            Navigator.pushNamed(context, ExpenseAddPage.routeName);
                          },
                          child:const Text("Add Expense")
                       ),

                         SizedBox(width:MediaQuery.of(context).size.width/2.2),
                       ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )
                          ),
                          onPressed: (){
                            Navigator.pushNamed(context, LoanAdd.routeName);
                          },
                          child:const Text("Add Lone")
                      ),
                    ],
                  ),
    )
                ),

              ],
            ),
          ),
    );
  }


}
