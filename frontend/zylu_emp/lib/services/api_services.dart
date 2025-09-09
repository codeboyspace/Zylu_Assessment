import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/employee.dart';
import '../app_constants.dart';

class ApiService {

  Future<List<Employee>> getEmployees() async {
    // Fetching employees because apparently we can't remember them all
    final response = await http.get(Uri.parse("${ApiConfig.baseUrl}${ApiConfig.employeesEndpoint}"));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Employee.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load employees");
    }
  }

  Future<void> createEmployee(Employee employee) async {
    // Adding new employees - hope they bring their own coffee
    final response = await http.post(
      Uri.parse("${ApiConfig.baseUrl}${ApiConfig.employeesEndpoint}"),
      headers: ApiConfig.jsonHeaders,
      body: json.encode(employee.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception("Failed to create employee");
    }
  }
}
