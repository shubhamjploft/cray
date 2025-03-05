import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cray/base_components/base_textfield.dart';
import 'package:cray/base_components/full_file_url.dart';
import 'package:cray/controller/profile_controller.dart';
import 'package:cray/utils/base_colors.dart';
import 'package:cray/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../base_components/base_button.dart';
import '../../base_components/base_scaffold_background.dart';
import '../../base_components/base_text.dart';
import '../../utils/base_assets.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> formKeyEditProfile = GlobalKey<FormState>();
  ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    // TODO: implement initState
    profileController. profileData.value = Get.arguments ?? profileController.profileData.value;
    profileController.setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BaseColors.white,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [BaseColors.white, BaseColors.lightPink],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SizedBox.expand(
            child: BaseScaffoldBackground(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: formKeyEditProfile,
                    child: Column(
                      children: [
                        buildSizeHeight(10),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: SvgPicture.asset(
                                BaseAssets.backButtonIc,
                              ),
                            ),
                            buildSizeWidth(15),
                            const BaseText(
                              value: "Edit Profile",
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: BaseColors.black,
                            ),
                          ],
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildSizeHeight(16),
                                Center(
                                  child: Container(
                                    height: 117,
                                    width: 117,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Stack(
                                      children: [
                                        Obx(() {
                                          return( profileController.selectedImage.value?.path ??"").isNotEmpty
                                              ? Image.file(
                                            File( profileController.selectedImage.value?.path ??""),
                                            height: 117,
                                            width: 117,
                                            fit: BoxFit.cover,
                                            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                              return Image.asset(
                                                BaseAssets.noProfileImg,
                                                height: 117,
                                                width: 117,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                           )
                                              : CachedNetworkImage(
                                            imageUrl: generateFullFileUrl(
                                                profileController.profileData.value?.profilePicture ?? ""),
                                            height: 117,
                                            width: 117,
                                            fit: BoxFit.cover,
                                            placeholder: (BuildContext context, String url) => const Center(child: CircularProgressIndicator()),
                                            errorWidget: (BuildContext context, String url, Object error) => Image.asset(
                                              BaseAssets.noProfileImg,
                                              height: 117,
                                              width: 117,
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        }),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          left: 0,
                                          child: GestureDetector(
                                            onTap: () async {
                                              File? pickedFile = await showMediaPicker();
                                              if (pickedFile != null) {
                                                profileController.selectedImage.value = pickedFile;
                                              }
                                            },
                                            child: Container(
                                              width: 148,
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.9),
                                                borderRadius: const BorderRadius.only(
                                                  bottomLeft: Radius.circular(30),
                                                  bottomRight: Radius.circular(30),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: SvgPicture.asset(
                                                  BaseAssets.profileEditIc,
                                                  height: 15,
                                                  width: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                buildSizeHeight(20),
                                const BaseText(
                                  value: "First Name",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: BaseColors.black,
                                ),
                                buildSizeHeight(5),
                                BaseTextField(
                                  labelText: '',
                                  hintText: 'First Name',
                                  controller: profileController.firstNameController,
                                  textCapitalization: TextCapitalization.words,
                                  borderRadius: 16,
                                  contentPadding: const EdgeInsets.all(12),
                                  fillColor: BaseColors.moreLightGreen,
                                  borderColor: BaseColors.moreLightGreen,
                                  textInputType: TextInputType.name,
                                  validator: (String? val) {
                                    if (profileController.firstNameController.text.trim().isEmpty) {
                                      return "Please First Name";
                                    }
                                    return null;
                                  },
                                ),
                                buildSizeHeight(16),
                                const BaseText(
                                  value: "Last Name",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: BaseColors.black,
                                ),
                                buildSizeHeight(5),
                                BaseTextField(
                                  labelText: '',
                                  hintText: 'Last Name',
                                  controller: profileController.lastNameController,
                                  textCapitalization: TextCapitalization.words,
                                  borderRadius: 16,
                                  contentPadding: const EdgeInsets.all(12),
                                  fillColor: BaseColors.moreLightGreen,
                                  borderColor: BaseColors.moreLightGreen,
                                  textInputType: TextInputType.name,
                                  validator: (val) {
                                    if (profileController.lastNameController.text.trim().isEmpty) {
                                      return "Please Last Name";
                                    }
                                    return null;
                                  },
                                ),
                                buildSizeHeight(16),
                                const BaseText(
                                  value: "Mobile Number",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: BaseColors.black,
                                ),
                                buildSizeHeight(5),
                                BaseTextField(
                                  labelText: '',
                                  hintText: "Mobile Number",
                                  controller: profileController.numberController,
                                  borderRadius: 16,
                                  contentPadding: const EdgeInsets.all(12),
                                  fillColor: BaseColors.moreLightGreen,
                                  borderColor: BaseColors.moreLightGreen,
                                  textInputType: TextInputType.name,
                                  validator: (val) {
                                    if (profileController.numberController.text.trim().isEmpty) {
                                      return "Please Mobile Number";
                                    }
                                    return null;
                                  },
                                ),
                                buildSizeHeight(16),
                                const BaseText(
                                  value: "Linkedin",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: BaseColors.black,
                                ),
                                buildSizeHeight(5),
                                BaseTextField(
                                  labelText: '',
                                  hintText: 'Linkedin',
                                  readOnly: true,
                                  controller: profileController.linkdinController,
                                  borderRadius: 16,
                                  contentPadding: const EdgeInsets.all(12),
                                  fillColor: BaseColors.moreLightGreen,
                                  borderColor: BaseColors.moreLightGreen,
                                  textInputType: TextInputType.name,
                                  validator: (val) {
                                    if (profileController.linkdinController.text.trim().isEmpty) {
                                      return "Please Enter LinkedinUrl";
                                    }
                                    return null;
                                  },
                                ),
                                buildSizeHeight(16),
                                const BaseText(
                                  value: "Facebook",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: BaseColors.black,
                                ),
                                buildSizeHeight(5),
                                BaseTextField(
                                  labelText: '',
                                  hintText: 'Facebook',
                                  readOnly: true,
                                  controller:
                                      profileController.facebookController,
                                  borderRadius: 16,
                                  contentPadding: const EdgeInsets.all(12),
                                  fillColor: BaseColors.moreLightGreen,
                                  borderColor: BaseColors.moreLightGreen,
                                  textInputType: TextInputType.name,
                                  validator: (String? val) {
                                    if (profileController.facebookController.text.trim().isEmpty) {
                                      return "Please Enter FacebookUrl";
                                    }
                                    return null;
                                  },
                                ),
                                buildSizeHeight(20),
                                BaseButton(
                                  title: "Save Changes",
                                  onPressed: () {
                                    if (formKeyEditProfile.currentState?.validate() ?? false) {
                                      profileController.editProfileDetail();
                                    }
                                  },
                                ),
                                buildSizeHeight(20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
