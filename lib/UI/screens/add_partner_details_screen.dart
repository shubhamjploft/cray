import 'dart:io';

import 'package:cray/base_components/base_button.dart';
import 'package:cray/base_components/base_scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../base_components/base_text.dart';
import '../../base_components/base_textfield.dart';
import '../../controller/add_partner_detail_controller.dart';
import '../../utils/base_assets.dart';
import '../../utils/base_colors.dart';
import '../../utils/base_functions.dart';


class AddPartnerDetailsScreen extends StatefulWidget {
  const AddPartnerDetailsScreen({super.key});

  @override
  State<AddPartnerDetailsScreen> createState() => _AddPartnerDetailsScreenState();
}

class _AddPartnerDetailsScreenState extends State<AddPartnerDetailsScreen> {
  final GlobalKey<FormState> formKeyPartnerDetail = GlobalKey<FormState>();



  Future<void> pickContact() async {
    if (await FlutterContacts.requestPermission()) {
      final Contact? contact = await FlutterContacts.openExternalPick();
      if (contact != null && contact.phones.isNotEmpty) {
        addPartnerDetailCtrl.phoneCtrl.text = contact.phones.first.number;
        addPartnerDetailCtrl.update();
      }
    } else {
      Get.snackbar(
        "Permission Denied",
        "Enable contact access from settings",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }


  AddPartnerDetailController  addPartnerDetailCtrl  = Get.put(AddPartnerDetailController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.white,
      body: BaseScaffoldBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: formKeyPartnerDetail,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSizeHeight(50),
                    const BaseText(
                      value: "Add your partner details",
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: BaseColors.black,
                    ),
                    buildSizeHeight(30),
                    Row(
                      children: [
                        Expanded(
                          child: BaseTextField(
                            labelText: '',
                            hintText: 'First Name',
                            controller: addPartnerDetailCtrl.firstNameCtrl,
                            textInputType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: SvgPicture.asset(
                                BaseAssets.personIc,
                              ),
                            ),
                            validator: (String? val) {
                              if (addPartnerDetailCtrl.firstNameCtrl.text
                                  .trim()
                                  .isEmpty) {
                                return "Please First Name";
                              }
                              return null;
                            },
                          ),
                        ),
                        buildSizeWidth(10),
                        Expanded(
                          child: BaseTextField(
                            labelText: '',
                            hintText: 'Last Name',
                           controller: addPartnerDetailCtrl.lastNameCtrl,
                            textInputType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: SvgPicture.asset(
                                BaseAssets.personIc,
                              ),
                            ),
                            validator: (String? val) {
                              if (addPartnerDetailCtrl.lastNameCtrl.text.trim().isEmpty) {
                                return "Please Last Name";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    buildSizeHeight(20),
                    BaseTextField(
                      labelText: '',
                      hintText: 'Email address',
                      controller: addPartnerDetailCtrl.emailAddressCtrl,
                      textCapitalization: TextCapitalization.words,
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: SvgPicture.asset(
                          BaseAssets.emailIc,
                        ),
                      ),
                      validator: (String? val) {
                        String email =
                        addPartnerDetailCtrl.emailAddressCtrl.text.trim();
                        if (email.isEmpty) {
                          return "Please enter an email address";
                        }
                        bool isValidEmail = RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                            .hasMatch(email);

                        if (!isValidEmail) {
                          return "Please enter a valid email address";
                        }

                        return null;
                      },
                    ),
                    buildSizeHeight(20),
                    GestureDetector(
                      onTap: () {
                        pickContact();
                      },
                      child: BaseTextField(
                        labelText: '',
                        hintText: 'Phone',
                        readOnly: true,
                        controller: addPartnerDetailCtrl.phoneCtrl,
                        textInputType: TextInputType.number,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: SvgPicture.asset(
                            BaseAssets.phoneIc,
                          ),
                        ),
                        validator: (String? val) {
                          if (addPartnerDetailCtrl.lastNameCtrl.text
                              .trim()
                              .isEmpty) {
                            return "Please Enter number";
                          }
                          return null;
                        },
                      ),
                    ),

                    buildSizeHeight(20),
                    BaseTextField(
                      labelText: '',
                      hintText: 'Age',
                      textInputType: TextInputType.number,
                      controller: addPartnerDetailCtrl.ageCtrl,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: SvgPicture.asset(
                          BaseAssets.ageIc,
                        ),
                      ),
                      validator: (String? val) {
                        if (addPartnerDetailCtrl.ageCtrl.text
                            .trim()
                            .isEmpty) {
                          return "Please Enter Age";
                        }
                        return null;
                      },
                    ),
                    buildSizeHeight(20),
                    BaseTextField(
                      labelText: '',
                      hintText: 'Ethnicity',
                      textInputType: TextInputType.text,
                      controller: addPartnerDetailCtrl.ethnicityCtrl,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: SvgPicture.asset(
                          BaseAssets.ethnicityIc,
                        ),
                      ),
                      validator: (val) {
                        if (addPartnerDetailCtrl.ethnicityCtrl.text
                            .trim()
                            .isEmpty) {
                          return "Please Enter Ethnicity";
                        }
                        return null;
                      },
                    ),
                    buildSizeHeight(20),
                    BaseTextField(
                      labelText: '',
                      hintText: 'Upload Picture',
                      textInputType: TextInputType.none,
                      controller: addPartnerDetailCtrl.uploadPictureCtrl,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: SvgPicture.asset(BaseAssets.galleryIc),
                      ),
                      validator: (String? val) {
                        if (addPartnerDetailCtrl.uploadPictureCtrl.text.trim().isEmpty) {
                          return "Please Enter Upload Picture";
                        }
                        return null;
                      },
                      onTap: () async {
                        File? pickedFile = await showMediaPicker();
                        if (pickedFile != null) {
                          addPartnerDetailCtrl.selectedImage.value = pickedFile;
                          addPartnerDetailCtrl.uploadPictureCtrl.text = pickedFile.path.split('/').last;
                          addPartnerDetailCtrl.imageError.value = "";
                        }
                      },
                    ),
                    buildSizeHeight(40),
                    BaseButton(
                      title: "Submit",
                      onPressed: () {
                        if (formKeyPartnerDetail.currentState?.validate() ??
                            false) {
                          addPartnerDetailCtrl.addPartnerDetail();
                        // Get.to(() => const AddPartnerSocialMedia());
                      }
                        },
                    ),
                    buildSizeHeight(20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
