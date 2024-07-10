import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/event_model.dart';



class MainRepo {
  Future<EventsModel?> fetchEvents() async {
    final response = await http.get(
        Uri.parse('https://mock.apidog.com/m1/561191-524377-default/Event'));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return EventsModel
          .fromJson(body);
    } else {
      throw Exception('Failed to load events');
    }
  }
}