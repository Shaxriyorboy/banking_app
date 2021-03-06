import 'dart:convert';
import 'package:banking_app/models/card_model.dart';
import 'package:http/http.dart';

class Network {
  static bool isTester = true;

  static String SERVER_DEVELOPMENT = "622ac2de14ccb950d224953a.mockapi.io";
  static String SERVER_PRODUCTION = "622ac2de14ccb950d224953a.mockapi.io";

  /* Header */
  static Map<String, String> headers={
    "Content-Type" : "application/json"
  // "Authorization": "Client-ID 565RutOixmOocXRTpGVazfrMt5TXje7_YbeYS8rRlUc"
};

  /* Test Server */
  static String getServer() {
    if (isTester) return SERVER_DEVELOPMENT;
    return SERVER_PRODUCTION;
  }

  /*Http request*/
  static Future<String?> GET(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(getServer(), api, params); // http or https
    var response = await get(uri);
    if (response.statusCode == 200) return response.body;
    print(response.body);
    return null;
  }


  static Future<String?> GET_ONE(String api, Map<String, String> params) async {
    var uri = Uri.https(getServer(), api, params,); // http or https
    var response = await get(uri);
    if (response.statusCode == 200) return response.body;

    return null;
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    var uri = Uri.https(getServer(), api); // http or https
    var response = await post(uri, body: jsonEncode(params),headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201)
      return response.body;
    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    var uri = Uri.https(getServer(), api);
    var response =
        await put(uri, body: jsonEncode(params));

    if (response.statusCode == 200) return response.body;
    return null;
  }

  static Future<String?> DEL(String api, Map<String, String> params) async {
    var uri = Uri.https(getServer(), api, params); // http or https
    var response = await delete(uri);
    if (response.statusCode == 200) return response.body;

    return null;
  }

  /* Http apis for all */
  static String API_LIST = "/banking/cards";
  static String API_CREATE = "/banking/cards";
  static String API_UPDATE = "/banking/cards/"; //{id}
  static String API_DELETE = "/banking/cards/"; //{id}


  /* Http params */

  static Map<String, String> paramsEmpty() {
    Map<String, String> params = Map();
    return params;
  }


  static Map<String, dynamic> paramsPage(int pageNumber) {
    Map<String, String> params = {};
    params.addAll({
      "page":pageNumber.toString()
    });
    return params;
  }

  static Map<String, String> paramsCreate(VIsaCard card) {
    Map<String, String> params = {};
    params.addAll({
      'first_name': card.firstName!,
      'second_name': card.secondName!,
      'creat_data': card.creatData!,
      'card_number': card.cardNumber!.toString(),
      'cvv': card.cvv!
    });
    return params;
  }


  /* Http parsing */
  static List<VIsaCard> parsePostList(String body){
    List<VIsaCard> cards = uploadImageFromJson(body);
    return cards;
  }
}
