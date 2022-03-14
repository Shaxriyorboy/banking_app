import 'package:banking_app/models/card_model.dart';
import 'package:banking_app/pages/creat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../servece/http_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = " home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<VIsaCard> cardList = [];
  bool isLoading = false;

  getCards() async {
    print(cardList.length);
    setState(() {
      isLoading = true;
    });
    await Network.GET(Network.API_LIST, Network.paramsEmpty()).then((response) {
      _showResponse(response!);
    });
  }

  void _showResponse(String response)async {
    List<VIsaCard> _list =Network.parsePostList(response);
    setState(() {
      isLoading = false;
      cardList = _list;
    });

  }

  _openCreatPage()async{
    var result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) {
      return CreatPage();
    }));
    if(result == true){
      getCards();
      setState(() {});
    }
  }

  delete(String id)async{
    await Network.DEL(Network.API_DELETE+id.toString(), Network.paramsEmpty()).then((value) => {
      // _resPostDelete(value!),
      getCards(),
      print(value),
    });
  }

  void _resPostDelete(String response){
    setState(() {
      isLoading = false;
    });
    if(response != null) getCards();
  }


  @override
  void initState() {
    getCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 10,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: !isLoading?SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Good morning",
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      ),
                      Text(
                        "Shaxriyor",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: ClipRRect(
                        child: Image(
                          image: AssetImage("assets/images/img.png"),
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cardList.length,
                itemBuilder: (context, index) {
              return visaCard(index);
            }),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                _openCreatPage();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)),
                height: 220,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_box_outlined,
                      color: Colors.black,
                    ),
                    Text("Add new card"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ):Center(child: CircularProgressIndicator(),),
    );
  }

  Slidable visaCard(index) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed:(ctx)=> {
              delete(cardList[index].id!),
            },
            foregroundColor: Colors.black,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey,
        ),
        height: 220,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 50,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white38,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 60,
                      child: Text(
                        "Visa",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(cardList[index].cardNumber!.substring(0,4),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                  Text(cardList[index].cardNumber!.substring(5,9),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                  Text(cardList[index].cardNumber!.substring(10,14),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                  Text(cardList[index].cardNumber!.substring(15,19),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("CARD HOLDER",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10)),
                        Text(cardList[index].firstName!,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("EXPIRES",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10)),
                        Text(cardList[index].creatData!,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {

}
