import 'package:http/http.dart' as http;
import 'dart:convert';

var api_key = "https://opentdb.com/api.php?amount=20&category=9";
// var api_key =
//     "https://opentdb.com/api.php?amount=20&category=26&difficulty=easy";

getQuizData() async {
  var res = await http.get(Uri.parse(api_key));
  if (res.statusCode == 200) {
    var data = jsonDecode(res.body.toString());
    return data;
  }
}
