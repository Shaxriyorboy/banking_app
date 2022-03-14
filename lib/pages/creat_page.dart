import 'package:banking_app/models/card_model.dart';
import 'package:banking_app/servece/http_service.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';

class CreatPage extends StatefulWidget {
  const CreatPage({Key? key}) : super(key: key);
  static const String id = "creat_page";

  @override
  _CreatPageState createState() => _CreatPageState();
}

class _CreatPageState extends State<CreatPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final numberController = MaskedTextController(mask: "0000 0000 0000 0000");
  final dateController = MaskedTextController(mask: "00/00");
  final cvvController = MaskedTextController(mask: "0 0 0");

  save() {
    String name = nameController.text.trim().toString();
    String number = numberController.text.trim().toString();
    String date = dateController.text.trim().toString();
    String cvv = cvvController.text.trim().toString();
    VIsaCard vIsaCard = VIsaCard(
        firstName: name,
        secondName: name,
        creatData: date,
        cardNumber: number,
        cvv: cvv);

    if(number.isNotEmpty && date.isNotEmpty && name.isNotEmpty && cvv.isNotEmpty){
      Network.POST(Network.API_CREATE, Network.paramsCreate(vIsaCard))
          .then((value) => {
      Navigator.of(context).pop(true),
        print(value),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      body: Form(
        key: formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  children: [
                    Column(
                      children: const [
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
                          child: const Icon(
                            Icons.api,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
              const Text("Fill in the fields below or use camera phone",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(
                height: 30,
              ),
              const Text("Your card number",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              const SizedBox(
                height: 10,
              ),

              /// card number
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.length!=16?"Please enter 16 number":null,
                  controller: numberController,
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.credit_card),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Card Number',
                      hintText: 'Card Number',
                      labelStyle: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold)),
                  onChanged: (text) {
                    setState(() {});
                  },
                ),
              ),

              /// date and cvv
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  children: [

                    ///Creat time
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            child: const Text("Expiry date",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 20)),
                            alignment: Alignment.centerLeft,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              validator: (value) => value!.isNotEmpty?null:"Please enter 16 number",
                              keyboardType: TextInputType.number,
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
                    SizedBox(
                      width: 10,
                    ),

                    ///Cvv
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
                            child: TextFormField(
                              validator: (value) => value!.length==4?null:"Please enter 4 number",
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

              ///your name
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



              /// save button
              MaterialButton(
                  child: Text("Save"),
                  color: Colors.white,
                  onPressed: () {
                    save();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
