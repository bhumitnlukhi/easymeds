import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/custom_app_bar.dart';
import '../../common/widgets/custom_button.dart';
import '../../common/widgets/custom_text_field.dart';
import '../../common/widgets/footer_view.dart';
import '../../common/widgets/menu_drawer.dart';
import '../../helper/custom_dropdown.dart';
import '../../helper/responsive_helper.dart';
import '../../util/dimensions.dart';
import '../../util/images.dart';
import '../auth/controllers/auth_controller.dart';
import '../language/controllers/language_controller.dart';
import '../splash/controllers/splash_controller.dart';
import 'controller/career_controller.dart';
import 'domain/career_repositort.dart';

class CareerScreen extends StatefulWidget {
  const CareerScreen({super.key});

  @override
  State<CareerScreen> createState() => _CareerScreenState();
}

class _CareerScreenState extends State<CareerScreen> {
  final CareerController careerController =
      Get.put(CareerController(careerRepo: Get.find<CareerRepo>()));

  final _formKey = GlobalKey<FormState>();
  String? _countryDialCode;

  @override
  void initState() {
    super.initState();
    _countryDialCode =
        Get.find<AuthController>().getUserCountryCode().isNotEmpty
            ? Get.find<AuthController>().getUserCountryCode()
            : CountryCode.fromCountryCode(
                    Get.find<SplashController>().configModel!.country!)
                .dialCode;
    Get.find<CareerController>().getJobRoleList(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Careers'.tr),
      endDrawer: const MenuDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: ResponsiveHelper.isDesktop(context)
              ? EdgeInsets.zero
              : const EdgeInsets.all(Dimensions.paddingSizeSmall),
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: FooterView(
              child: SizedBox(
                width: Dimensions.webMaxWidth,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(Images.logo, width: 100),
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      const SizedBox(height: 30),
                      // Layout Switch: GridView for web, ListView for mobile
                      ResponsiveHelper.isDesktop(context)
                          ? GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              childAspectRatio: 7,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 1,
                              children: [
                                _buildNameField(),
                                _buildEmailField(),
                                _buildPhoneNumberField(),
                                _buildJobLocationField(),
                                _buildGenderField(),
                                _buildJobRoleField(),
                                _buildQualificationField(),
                              ],
                            )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height * .58,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildNameField(),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeSmall),
                                  _buildEmailField(),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeSmall),
                                  _buildPhoneNumberField(),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeSmall),
                                  _buildQualificationField(),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeSmall),
                                  _buildGenderField(),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeSmall),
                                  _buildJobLocationField(),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeSmall),
                                  _buildJobRoleField(),
                                ],
                              ),
                            ),

                      const SizedBox(height: Dimensions.paddingSizeSmall),

                      // File Upload Button
                      GetBuilder<CareerController>(
                        builder: (careerController) {
                          return CustomButton(
                            fontSize: 12,
                            buttonText: careerController.selectedFileName != ''
                                ? careerController.selectedFileName
                                : 'Upload CV'.tr,
                            onPressed: () => careerController.pickFile(),
                            //  isLoading: careerController.isSubmitting,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                          );
                        },
                      ),

                      const SizedBox(height: Dimensions.paddingSizeSmall),

                      // Submit Button
                      GetBuilder<CareerController>(
                        builder: (controller) {
                          return CustomButton(
                            buttonText: controller.isSubmitting
                                ? 'Submitting...'.tr
                                : 'Submit Application'.tr,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Submit the application
                                controller.submitJobApplication();
                              }
                            },

                            //isLoading: controller.isSubmitting,
                            width: double.infinity, // Full width
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Full Name Field
  Widget _buildNameField() {
    return CustomTextField(
      labelText: 'Full Name'.tr,
      titleText: 'Full Name'.tr,
      hintText: 'Enter your full name'.tr,
      controller: careerController.nameController,
      inputType: TextInputType.name,
      isEnabled: true,
      showTitle: false,
    );
  }

  // Email Field
  Widget _buildEmailField() {
    return CustomTextField(
      labelText: 'Email'.tr,
      titleText: 'Email'.tr,
      hintText: 'Enter your email address'.tr,
      controller: careerController.emailController,
      inputType: TextInputType.emailAddress,
      isEnabled: true,
      showTitle: false,
    );
  }

  // Phone Number Field
  Widget _buildPhoneNumberField() {
    return CustomTextField(
      labelText: 'Phone Number'.tr,
      titleText: 'Phone Number'.tr,
      hintText: 'Enter your phone number'.tr,
      controller: careerController.phoneController,
      inputType: TextInputType.phone,
      isEnabled: true,
      iconSize: 5,
      showTitle: false,
      isPhone: true,
      onCountryChanged: (CountryCode countryCode) {
        _countryDialCode = countryCode.dialCode;
      },
      countryDialCode: _countryDialCode != null
          ? CountryCode.fromCountryCode(
                  Get.find<SplashController>().configModel!.country!)
              .code
          : Get.find<LocalizationController>().locale.countryCode,
    );
  }

  // Gender Field
  Widget _buildGenderField() {
    return Obx(() {
      return CustomDropdownWidget(
        labelText: 'Gender'.tr,
        options: careerController.genderOptions, // Reactive options
        selectedValue: careerController.selectedGender,
        onChanged: (value) {
          careerController.selectedGender = value!;
          print('Selected gender: $value');
        },
        validator: (value) => value == null || value.isEmpty
            ? 'Please select your gender'.tr
            : null,
      );
    });
  }

  // Preferred Job Location Field
  Widget _buildJobLocationField() {
    return CustomTextField(
      titleText: 'Preferred Job Location'.tr,
      labelText: 'Preferred Job Location'.tr,
      hintText: 'Enter your preferred job location'.tr,
      controller: careerController.jobLocationController,
      inputType: TextInputType.text,
      isEnabled: true,
      showTitle: false,
    );
  }

  // Job Role Field
  Widget _buildJobRoleField() {
    return Obx(() {
      return CustomDropdownWidget(
        labelText: 'Job Role'.tr,
        options: careerController.jobRoleNames, // Reactive options
        selectedValue: careerController.selectedJobRole,
        onChanged: (value) {
          var selectedJobRole = careerController.jobRoleList
              ?.firstWhere((job) => job.jobRole == value);
          careerController.selectedJobRole = value!;
          careerController.selectedJobRoleId.value = selectedJobRole!.id!;
          print('Selected JobRole: $value && $selectedJobRole');
        },
        validator: (value) =>
            value == null || value.isEmpty ? 'Please select Job Role'.tr : null,
      );
    });
  }

  // Highest Qualification Field
  Widget _buildQualificationField() {
    return CustomTextField(
      titleText: 'Highest Qualification'.tr,
      labelText: 'Highest Qualification'.tr,
      hintText: 'Enter your highest qualification'.tr,
      controller: careerController.qualificationController,
      inputType: TextInputType.text,
      isEnabled: true,
      showTitle: false,
    );
  }
}
