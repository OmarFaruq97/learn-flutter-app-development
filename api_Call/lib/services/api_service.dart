import 'dart:convert';
import 'dart:io';

import 'package:api_call/models/Employee.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8080';

  // static const String baseUrl = 'http://192.168.0.197:8080';

  Future<List<Employee>> getEmployees() async {
    final response = await http.get(Uri.parse('$baseUrl/employees'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Employee.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load employees');
    }
  }

  //himu copy
  Future<Employee> getEmployeeById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/employees/$id'));
    if (response.statusCode == 200) {
      return Employee.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load employee');
    }
  }

  Future<Employee> saveEmployee(Employee employee) async {
    final response = await http.post(
      Uri.parse('$baseUrl/employees'),
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
      Uri.parse('$baseUrl/employees/$id'),
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
    final response = await http.delete(Uri.parse('$baseUrl/employees/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete employee with id $id');
    }
  }

  Future<String> uploadImage(int employeeId, File image) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/employees/$employeeId/upload'),
    );
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        image.path,
        filename: basename(image.path),
      ),
    );
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final jsonResponse = jsonDecode(responseBody);
      return jsonResponse['url'];
    } else {
      throw Exception('Failed to upload image');
    }
  }
}
