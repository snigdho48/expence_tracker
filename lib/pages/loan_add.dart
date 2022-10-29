import 'package:expence_tracker/models/loan_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../custom_list/helper_function&list.dart';
import '../providers/lone_provider.dart';
import '../utils/notifications_util.dart';

class LoanAdd extends StatefulWidget {
  static const String routeName = "/loanadd";
  const LoanAdd({Key? key}) : super(key: key);

  @override
  State<LoanAdd> createState() => _LoanAddState();
}

class _LoanAddState extends State<LoanAdd> {
  final _formKey = GlobalKey<FormState>();
  final loan_name_controller = TextEditingController();
  final loan_controller = TextEditingController();

  @override
  void dispose() {
    loan_controller.dispose();
    loan_name_controller.dispose();
    super.dispose();
  }
  var isno=false;
  var isno1=false;
  var isno2=false;
  DateTime? loan_date;
  DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Add"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Lender's Name : ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: isno?Colors.red:Colors.green),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: loan_name_controller,
                decoration: InputDecoration(
                    hintText: "Lender's Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(width: 1, color: Colors.green))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select catagory';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Loan Amount : ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: isno1?Colors.red:Colors.green),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: loan_controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Amount",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(width: 1, color: Colors.green))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      isno=true;
                    });
                    return 'Please input an Amount';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),



              Text(
                "Last Date : ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: isno2?Colors.red:Colors.green),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      selectDate();

                    },
                    icon: Icon(
                      Icons.calendar_month,
                      color:isno2?Colors.red:Colors.green,
                      size: 25,
                    ),
                    label: Text(
                      "Selected Last Date : ",
                      style: TextStyle(
                        color: isno2?Colors.red:Colors.green,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    lastDate == null
                        ? "No Date chosen"
                        : getFormattedDate(lastDate!, "dd-MM-yyyy"),
                    style: TextStyle(fontSize: 18, color: isno2?Colors.red:Colors.green),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isno?Colors.red:Colors.green,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
                onPressed: () {
                  addLoan();
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 40, right: 40),
                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 50),
    );
    if (selectedDate != null) {
      setState(() {
        lastDate = selectedDate;
        isno2=false;
      });
      }else{
      setState(() {
        isno2=true;
      });
  }}

  void addLoan() {
    final provider = Provider.of<LoneProvider>(context, listen: false);
    if (lastDate == null) {
      setState(() {
        isno2=true;
      });
    }
    if(loan_controller.text.isEmpty){
      setState(() {
        isno1=true;
      });}
    if(loan_name_controller.text.isEmpty){
      setState(() {
        isno=true;
      });}
    if (_formKey.currentState!.validate() &&  lastDate != null) {
      isno=isno1=isno2=false;
      print('$lastDate coun');
      final loanDate = DateTime.now();
      int loan = int.parse(loan_controller.text);
      final loanModel = LoanModel(
        lendersName: loan_name_controller.text,
        loan: loan,
        loanDate: getFormattedDate(loanDate, "dd/MM/yyyy HH:mm a"),
        lastDate: lastDate!
            .add(Duration(hours: loanDate.hour, minutes: loanDate.minute + 1,seconds: loanDate.second))
            .toLocal()
            .toString(),
      );

      provider.insertLone(loanModel).then((value) {
        provider.getAlllone();
        Navigator.pop(context);
        var lone = Provider.of<LoneProvider>(context, listen: false).count + 1;
        NotificationService().scheduleNotification(
            lone,
            'Pay lone quickly to ${loanModel.lendersName} ',
            'Time Up: ${loanModel.loan}\$',
            lastDate!
                .add(Duration(
                    hours: DateTime.now().hour,
                    minutes: DateTime.now().minute + 1,
                    seconds: DateTime.now().second))
                .toLocal(),
            loanModel.loanDate);

      }).catchError((error) {
      });
    }
  }
}
