import 'dart:io';

import 'package:api_call/models/Employee.dart';
import 'package:api_call/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddEditEmployeeScreen extends StatefulWidget {
  final Employee? employee;

  const AddEditEmployeeScreen({super.key, this.employee});

  @override
  State<AddEditEmployeeScreen> createState() => _AddEditEmployeeScreenState();
}

class _AddEditEmployeeScreenState extends State<AddEditEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _designationController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  final _dobController = TextEditingController();
  final _salaryController = TextEditingController();

  // Variables to hold image and URL
  File? _image;
  String? _imageUrl;

  final ApiService _apiService = ApiService();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.employee != null) {
      _nameController.text = widget.employee!.name;
      _emailController.text = widget.employee!.email;
      _designationController.text = widget.employee!.designation;
      _ageController.text = widget.employee!.age.toString();
      _addressController.text = widget.employee!.address;
      _dobController.text = widget.employee!.dob;
      _salaryController.text = widget.employee!.salary.toString();
      _imageUrl = widget.employee!.image;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _designationController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    _salaryController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveEmployee() async {
    if (_formKey.currentState!.validate()) {
      final employee = Employee(
        id: widget.employee?.id,
        name: _nameController.text,
        email: _emailController.text,
        designation: _designationController.text,
        age: int.parse(_ageController.text),
        address: _addressController.text,
        dob: _dobController.text,
        salary: double.parse(_salaryController.text),
        image: _imageUrl,
      );

      try {
        Employee savedEmployee;
        if (widget.employee == null) {
          savedEmployee = await _apiService.saveEmployee(employee);
        } else {
          savedEmployee = await _apiService.updateEmployee(
            widget.employee!.id!,
            employee,
          );
        }

        // Upload image after employee is saved
        if (_image != null) {
          final imageUrl = await _apiService.uploadImage(
            savedEmployee.id!,
            _image!,
          );

          final updatedEmployee = Employee(
            id: savedEmployee.id,
            name: savedEmployee.name,
            email: savedEmployee.email,
            designation: savedEmployee.designation,
            age: savedEmployee.age,
            address: savedEmployee.address,
            dob: savedEmployee.dob,
            salary: savedEmployee.salary,
            image: imageUrl,
          );

          await _apiService.updateEmployee(savedEmployee.id!, updatedEmployee);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.employee == null ? 'Employee added' : 'Employee updated',
            ),
          ),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.employee == null ? 'Add Employee' : 'Edit Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter name' : null,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter email';
                    }
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _designationController,
                  decoration: const InputDecoration(labelText: 'Designation'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter a designation'
                      : null,
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter age';
                    final age = int.tryParse(value);
                    if (age == null || age < 18 || age > 65) {
                      return 'Enter a valid age (18-65)';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter address' : null,
                ),
                TextFormField(
                  controller: _dobController,
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth (YYYY-MM-DD)',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter date of birth';
                    }
                    if (!RegExp(
                      r'^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$',
                    ).hasMatch(value)) {
                      return 'Enter a valid date (YYYY-MM-DD)';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _salaryController,
                  decoration: const InputDecoration(labelText: 'Salary'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter salary';
                    if (double.tryParse(value) == null ||
                        double.parse(value) <= 0) {
                      return 'Enter a valid number for salary';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Text('Profile Image'),
                const SizedBox(height: 10),
                _image != null
                    ? Image.file(
                        _image!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      )
                    : _imageUrl != null
                    ? Image.network(
                        _imageUrl!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 100,
                        width: 100,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _pickImage, // Your image picker function
                  child: const Text('Choose Image'),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Save or submit logic here
                      _saveEmployee();
                    }
                  },
                  child: Text(
                    widget.employee == null
                        ? 'Add Employee'
                        : 'Update Employee',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
