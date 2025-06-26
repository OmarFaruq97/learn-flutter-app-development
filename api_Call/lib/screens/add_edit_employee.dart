import 'dart:io';

import 'package:api_call/models/Employee.dart';
import 'package:api_call/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class AddEditEmployeeScreen extends StatefulWidget {
  final Employee? employee;

  const AddEditEmployeeScreen({super.key, this.employee});

  @override
  State<AddEditEmployeeScreen> createState() => _AddEditEmployeeScreenState();
}

class _AddEditEmployeeScreenState extends State<AddEditEmployeeScreen> {
  // Controllers for each input field
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _designationController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  final _dobController = TextEditingController();
  final _salaryController = TextEditingController();
  final _imageController = TextEditingController();

  // Variables to hold selected image and its URL
  File? _image;
  String? imageUrl;

  // API service instance
  final ApiService _apiService = ApiService();

  // Image picker instance
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.employee != null) {
      _nameController.text = widget.employee!.name;
      _emailController.text = widget.employee!.email;
      _designationController.text = widget.employee!.designation;
      _ageController.text = widget.employee!.toString();
      _addressController.text = widget.employee!.address;
      _dobController.text = widget.employee!.dob;
      _salaryController.text = widget.employee!.salary.toString();
      _imageController.text = widget.employee!.image ?? '';
      imageUrl = widget.employee!.image;
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
    _imageController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveEmployee() async {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
