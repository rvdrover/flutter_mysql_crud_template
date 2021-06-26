import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:personal_mysql/action_pages.dart';
import 'package:personal_mysql/personal_model.dart';
 
class Services {
  static const _CREATE_TABLE = 'CREATE_TABLE';
  static const _FETCH_DATA = 'FETCH_DATA';
  static const _ADD_PERSON= 'ADD_PERSON';
  static const _UPDATE_PERSON = 'UPDATE_PERSON';
  static const _DELETE_PERSON = 'DELETE_PERSON';
 

   static Future<String> createTable() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE;
      final response = await http.post(Uri.parse(ActionPages.CREATE), body: map);
      print('Create Table Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

 
  static Future<List<PersonalModal>> fetchData() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _FETCH_DATA;
      final response = await http.post(Uri.parse(ActionPages.FETCH), body: map);
      // print('Fetch Data Response: ${response.body}');
      if (200 == response.statusCode) {
        List<PersonalModal> list = parseResponse(response.body);
        return list;
      } else {
        return <PersonalModal>[];
      }
    } catch (e) {
      return <PersonalModal>[]; 
    }
  }
 
  static List<PersonalModal> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<PersonalModal>((json) => PersonalModal.fromJson(json)).toList();
  }
 
 
  static Future<String> addPerson(String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_PERSON;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      final response = await http.post(Uri.parse(ActionPages.ADD), body: map);
      print('Add Person Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
 
  static Future<String> updatePerson(String id, String firstname, String lastname) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_PERSON;
      map['id'] = id;
      map['first_name'] = firstname;
      map['last_name'] = lastname;
      final response = await http.post(Uri.parse(ActionPages.UPDATE), body: map);
      print('Update Person Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
 
  static Future<String> deletePerson(String id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_PERSON;
      map['id'] = id;
      final response = await http.post(Uri.parse(ActionPages.DELETE), body: map);
      print('Delete Person Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; 
    }
  }
}
