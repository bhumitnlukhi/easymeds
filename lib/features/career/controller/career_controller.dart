
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import 'package:flutter/foundation.dart';

import 'package:image_compression_flutter/image_compression_flutter.dart';

import '../../../api/api_checker.dart';
import '../../../common/widgets/custom_snackbar.dart';
import '../domain/career_model.dart';
import '../domain/career_repositort.dart';

class CareerController extends GetxController implements GetxService {
  final CareerRepo careerRepo;

  CareerController({required this.careerRepo});

  // Form Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _jobLocationController = TextEditingController();
  final TextEditingController _jobRoleController = TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();

  // Selected file details
  final RxString _selectedFilePath = ''.obs;
  final RxString _selectedFileName = ''.obs;
  XFile? _selectedFileBytes;

  // Gender options
  final RxList<String> genderOptions = ['Male', 'Female', 'Other'].obs;
  final RxString _selectedGender = ''.obs;

  // Job role details
  List<JobRoleModel>? _jobRoleList;
  RxList<String> jobRoleNames = <String>[].obs;
  final RxString _selectedJobRole = ''.obs;
  var selectedJobRoleId = 0.obs;

  // Submission status
  final RxBool _isSubmitting = false.obs;

  // Getters for controllers
  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get genderController => _genderController;
  TextEditingController get jobLocationController => _jobLocationController;
  TextEditingController get jobRoleController => _jobRoleController;
  TextEditingController get qualificationController => _qualificationController;

  // Getters for reactive variables
  String get selectedFilePath => _selectedFilePath.value;
  String get selectedFileName => _selectedFileName.value;
  List<JobRoleModel>? get jobRoleList => _jobRoleList;
  String get selectedGender => _selectedGender.value;
  String get selectedJobRole => _selectedJobRole.value;
  bool get isSubmitting => _isSubmitting.value;

  // Setters for reactive variables
  set selectedFilePath(String path) {
    _selectedFilePath.value = path;
    update();
  }

  set selectedJobRole(String value) {
    _selectedJobRole.value = value;
    update();
  }

  set isSubmitting(bool value) {
    _isSubmitting.value = value;
    update();
  }

  set selectedFileName(String name) {
    _selectedFileName.value = name;
    update();
  }

  set selectedGender(String value) {
    _selectedGender.value = value;
    update();
  }

  // Allowed file extensions
  final List<String> allowedExtensions = [
    'jpg',
    'jpeg',
    'png',
    'bmp',
    'tiff',
    'pdf',
    'doc',
    'docx'
  ];

  void submitJobApplication() async {
    isSubmitting = true;
    if (_selectedFileBytes == null || _selectedFileName.value.isEmpty) {
      isSubmitting = false;
      showCustomSnackBar("Please select a file before submitting.");
      return;
    }

    Map<String, String> bodyData = {
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'mob_no': _phoneController.text.trim(),
      'gender': _selectedGender.value,
      'preferred_job_loc': _jobLocationController.text.trim(),
      'job_role': selectedJobRoleId.toString(),
      'highest_qual': _qualificationController.text.trim(),
    };

    try {
      Response response =
          await careerRepo.submitCareer(bodyData, _selectedFileBytes);

      // Handle the response
      if (response.statusCode == 200) {
        isSubmitting = false;
        print('Job application submitted successfully.');
        clearFormFields();
        showCustomSnackBar(response.body['message'], isError: false);
      } else {
        ApiChecker.checkApi(response, getXSnackBar: false);
        print('Failed to submit job application: ${response.statusText}');
        isSubmitting = false;
      }
    } catch (e) {
      print('Error submitting job application: ${e.toString()}');
      showCustomSnackBar("Error submitting job application: ${e.toString()}");
      isSubmitting = false;
    }
    update();
  }

  /// Opens a file picker for the user to select a file
  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        _selectedFileBytes = XFile(
          kIsWeb ? "" : file.path!,
          name: _selectedFileName.value,
          bytes: file.bytes,
          mimeType: 'application/octet-stream',
        );
        // Handling Web case
        if (kIsWeb) {
          _selectedFileName.value = file.name;
          // _selectedFilePath.value = file.path!;
          _selectedFileBytes = XFile.fromData(file.bytes!);
        }
        // Handling Mobile/Desktop case
        else {
          if (file.path != null) {
            _selectedFilePath.value =
                file.path!; // Optional: If you need to process bytes later
            _selectedFileName.value = file.name;
          } else {
            throw 'No file path available for the selected file.';
          }
        }

        update(); // Updates the UI once file is selected
        print("Selected file: ${_selectedFileName.value}");
      } else {
        showCustomSnackBar("No file selected.");
      }
    } catch (e) {
      print('Error selecting file: $e');
      showCustomSnackBar("Error selecting file: $e");
    }
    update();
  }

  /// Fetches the job role list from the server
  Future<void> getJobRoleList(bool reload) async {
    if (_jobRoleList == null || reload) {
      _jobRoleList = null; // Reset job role list
      Response response = await careerRepo.getJobRoleList();

      if (response.statusCode == 200) {
        _jobRoleList = [];
        response.body.forEach((jobRole) {
          JobRoleModel jobRoleModel = JobRoleModel.fromJson(jobRole);
          _jobRoleList!.add(jobRoleModel);
        });
        jobRoleNames.value =
            _jobRoleList!.map((jobRole) => jobRole.jobRole ?? '').toList();
        update();
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getJobRoleList(true); // Load job roles on initialization
  }

  @override
  void dispose() {
    // Dispose of controllers to free resources
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    _jobLocationController.dispose();
    _jobRoleController.dispose();
    _qualificationController.dispose();
    super.dispose();
  }

  void clearFormFields() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _genderController.clear();
    _jobLocationController.clear();
    _jobRoleController.clear();
    _qualificationController.clear();

    // Clear other reactive variables if necessary
    _selectedFilePath.value = '';
    _selectedFileName.value = '';
    _selectedFileBytes = null;

    // Reset selected job role and gender
    _selectedGender.value = '';
    _selectedJobRole.value = '';
    selectedJobRoleId.value = 0;

    // Update the UI after clearing the fields
    update();
  }
}
