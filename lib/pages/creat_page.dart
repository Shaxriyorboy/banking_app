import 'package:banking_app/models/card_model.dart';
import 'package:banking_app/servece/http_service.dart';
import 'package:flutter/material.dart';

class CreatPage extends StatefulWidget {
  const CreatPage({Key? key}) : super(key: key);
  static const String id = "creat_page";

  @override
  _CreatPageState createState() => _CreatPageState();
}

class _CreatPageState extends State<CreatPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  save(){
    String name = nameController.text.trim();
    String number = numberController.text.trim();
    String date = dateController.text.trim();
    String cvv = cvvController.text.trim();
    VIsaCard vIsaCard = VIsaCard(firstName: name,secondName: name,creatData: date,cardNumber: number,cvv: cvv);
    Network.POST(Network.API_CREATE, Network.paramsCreate(vIsaCard)).then((value) => {
      print(value),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [
        //       Colors.blue.withOpacity(1),
        //       Colors.blue.withOpacity(0.5),
        //       Colors.white.withOpacity(1),
        //     ]
        //   ),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        "Add your card",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.api,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
            Text("Fill in the fields below or use camera phone",
                style: TextStyle(color: Colors.white, fontSize: 16)),
            SizedBox(
              height: 30,
            ),
            Text("Your card number",
                style: TextStyle(color: Colors.white, fontSize: 20)),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: TextField(
                controller: numberController,

                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.credit_card),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Card Number',
                    hintText: 'Card Number',
                    labelStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold)),
                onChanged: (text) {
                  setState(() {});
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          child: Text("Expiry date",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          alignment: Alignment.centerLeft,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: dateController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'Enter Date',
                                hintText: 'Enter Date',
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold)),
                            onChanged: (text) {
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            "CVV2",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: cvvController,

                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'Enter CVV',
                                hintText: 'Enter CVV',
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold)),
                            onChanged: (text) {
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text("Your Name",
                style: TextStyle(color: Colors.white, fontSize: 20)),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Your name',
                    hintText: 'Your name',
                    labelStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold)),
                onChanged: (text) {
                  setState(() {});
                },
              ),
            ),
            MaterialButton(
              child: Text("Save"),
              color: Colors.white,
                onPressed: (){
              save();
              Navigator.pop(context,true);
            }),
          ],
        ),
      ),
    );
  }
}
