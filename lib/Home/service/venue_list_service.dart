import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:slot_booking_app/Home/model/venue_list_model.dart';

class VenueListService {
  static Future<List<VenueListModel>?> fetchVenueList() async {

    const String apiUrl = 'https://phtest.demosoftfruit.com/venue-api/';
    try {
      Response response = await http.get(Uri.parse(apiUrl));
      List<dynamic> jsonResponse = json.decode(response.body);
      log("venue list data $jsonResponse");
      return  jsonResponse.map((data) => VenueListModel.fromJson(data)).toList();
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

}