import 'dart:convert';

import 'package:api_call/models/Employee.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8080';

  Future<List<Employee>> getEmployees() async {
    final response = await http.get(Uri.parse('$baseUrl/employee'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Employee.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load employees');
    }
  }

  Future<Employee> getEmployeeById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/employee/$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return Employee.fromJson(jsonData);
    } else {
      throw Exception('Failed to load employee with id $id');
    }
  }

  Future<Employee> saveEmployee(Employee employee) async {
    final response = await http.post(
      Uri.parse('$baseUrl/employee'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(employee.toJson()),
    );

    if (response.statusCode == 200) {
      return Employee.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to save employee');
    }
  }

  Future<Employee> updateEmployee(int id, Employee employee) async {
    final response = await http.put(
      Uri.parse('$baseUrl/employee/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(employee.toJson()),
    );
    if (response.statusCode == 200) {
      return Employee.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update employee');
    }
  }

  Future<void> deleteEmployee(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/employee/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete employee with id $id');
    }
  }
}
