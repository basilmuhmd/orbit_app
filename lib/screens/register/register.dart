import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:orbit_teams_flutter/localization/app_localization.dart';
import 'package:orbit_teams_flutter/screens/register/register_store.dart';
import 'package:orbit_teams_flutter/utils/constents/colors.dart';
import 'package:orbit_teams_flutter/utils/constents/sizes.dart';
import 'package:orbit_teams_flutter/utils/theme/theme_provider/theme_provider.dart';
import 'package:orbit_teams_flutter/utils/theme/widget_theme/floating_action_button_theme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../utils/app_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final RegisterStore _store = RegisterStore();
  late TabController _tabController;
  final isAadharLoading = false; //added for solving mobx error dummy
  int _currentIndex = 0;

  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  @override
  void initState() {
    super.initState();
    // _store.setupValidations();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();

  final List<Tab> myTabs = <Tab>[
    const Tab(
        icon: Icon(
          Icons.person_2_outlined,
        ),
        text: 'Basic Info'),
    const Tab(icon: Icon(Icons.work_history_outlined), text: 'Job Info'),
    const Tab(
        icon: Icon(Icons.account_balance_wallet_outlined), text: 'Bank Info'),
    const Tab(icon: Icon(Icons.file_copy_outlined), text: 'Document'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        initialIndex: _currentIndex,
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: IgnorePointer(
                ignoring: true,
                child: TabBar(
                  tabs: myTabs,
                  controller: _tabController,
                ),
              ),
            ),
            title: const Text('Register'),
          ),
          body: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Form(
                key: _formKey1,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _store.fullNameCont,
                        focusNode: _store.fullNameFocus,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                        ),
                        decoration: InputDecoration(
                          label: text("FullName".translate(context)),
                          icon: const Icon(Icons.person),
                        ),
                        validator: (s) {
                          if (s.isEmptyOrNull) {
                            return 'Full Name is required';
                          }
                          return null;
                        },
                      ),
                      10.height,
                      FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return DropdownButtonFormField(
                            items: _store.gender.map((item) {
                              return DropdownMenuItem(
                                  value: item,
                                  child: Row(
                                    children: <Widget>[
                                      Text(item),
                                    ],
                                  ));
                            }).toList(),
                            onChanged: (newValue) {
                              _store.selectedGender = newValue;
                            },
                            borderRadius: BorderRadius.circular(20.0),
                            value: _store.selectedGender,
                            decoration: InputDecoration(
                              label: text(
                                'Gender'.translate(context),
                              ),
                              icon: Icon(Icons.person),
                            ),
                            validator: (s) {
                              if (s.isEmptyOrNull) {
                                return 'Gender is required';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      10.height,
                      TextFormField(
                        controller: _store.addressCont,
                        focusNode: _store.addressFocus,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        decoration: InputDecoration(
                          label: text(
                            'Address'.translate(context),
                          ),
                          icon: Icon(Icons.house),
                        ),
                        validator: (s) {
                          if (s.isEmptyOrNull) {
                            return 'Address is required';
                          }
                          return null;
                        },
                      ),
                      10.height,
                      TextFormField(
                        controller: _store.phoneNumberCont,
                        focusNode: _store.phoneNumberFocus,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        decoration: InputDecoration(
                          label: text(
                            "MobileNumber".translate(context),
                          ),
                          icon: Icon(Icons.phone),
                        ),
                        validator: (s) {
                          if (s.isEmptyOrNull) {
                            return 'Mobile number is required';
                          }
                          return null;
                        },
                      ),
                      10.height,
                      TextFormField(
                        controller: _store.emailCont,
                        focusNode: _store.emailFocus,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        decoration: InputDecoration(
                          label: text(
                            'Email'.translate(context),
                          ),
                          icon: Icon(Icons.email),
                        ),
                        validator: (s) {
                          if (s.isEmptyOrNull) {
                            return 'Email is required';
                          }
                          return null;
                        },
                      ),
                      10.height,
                      TextFormField(
                        controller: _store.dobCont,
                        focusNode: _store.dobFocus,
                        onTap: () {
                          hideKeyboard(context);
                          _selectDobDate(context);
                        },
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        decoration: InputDecoration(
                          label: text('Date of birth'),
                          icon: const Icon(Icons.date_range),
                        ),
                        validator: (s) {
                          if (s.isEmptyOrNull) {
                            return 'Date of birth is required';
                          }
                          return null;
                        },
                      ),
                      10.height,
                      FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return DropdownButtonFormField(
                            items: _store.maritalStatusList.map((item) {
                              return DropdownMenuItem(
                                  value: item,
                                  child: Row(
                                    children: <Widget>[
                                      Text(item),
                                    ],
                                  ));
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _store.selectedMaritalStatus = newValue;
                              });
                            },
                            borderRadius:
                                BorderRadius.circular(AppSizes.borderRadious20),
                            value: _store.selectedMaritalStatus,
                            decoration: InputDecoration(
                              label: text(
                                'MaritalStatus'.translate(context),
                              ),
                              icon: Icon(Icons.person),
                            ),
                            validator: (s) {
                              if (s.isEmptyOrNull) {
                                return 'Marital status is required';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      10.height,
                      FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return DropdownButtonFormField(
                            items: _store.bloodGroupList.map((item) {
                              return DropdownMenuItem(
                                  value: item,
                                  child: Row(
                                    children: <Widget>[
                                      Text(item),
                                    ],
                                  ));
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _store.selectedBloodGroup = newValue;
                              });
                            },
                            borderRadius: BorderRadius.circular(20.0),
                            value: _store.selectedBloodGroup,
                            decoration: InputDecoration(
                              label: text(
                                'BloodGroup'.translate(context),
                              ),
                              icon: Icon(Icons.bloodtype),
                            ),
                            validator: (s) {
                              if (s.isEmptyOrNull) {
                                return 'Blood group is required';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      10.height,
                      TextFormField(
                        controller: _store.relationCont,
                        focusNode: _store.relationFocus,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        decoration: InputDecoration(
                          label: text(
                            'GuardianName'.translate(context),
                          ),
                          icon: Icon(Icons.people),
                        ),
                        validator: (s) {
                          if (s.isEmptyOrNull) {
                            return 'Father’s/Husband’s/Spouse’s name is required';
                          }
                          return null;
                        },
                      ),
                      100.height,
                    ],
                  ).paddingAll(16),
                ),
              ),
              Form(
                key: _formKey2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _store.designationCont,
                        focusNode: _store.designationFocus,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        decoration: InputDecoration(
                          label: text('Designation'.translate(context)),
                          icon: Icon(Icons.account_box_sharp),
                        ),
                        validator: (s) {
                          if (s.isEmptyOrNull) {
                            return 'Designation is required';
                          }
                          return null;
                        },
                      ),
                      10.height,
                      TextFormField(
                        controller: _store.workLocationCont,
                        focusNode: _store.workLocationFocus,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        decoration: InputDecoration(
                          label: text('WorkLocation'.translate(context)),
                          icon: Icon(Icons.location_on),
                        ),
                        validator: (s) {
                          if (s.isEmptyOrNull) {
                            return 'Work location is required';
                          }
                          return null;
                        },
                      ),
                      10.height,
                      TextFormField(
                        controller: _store.workEmailIdCont,
                        focusNode: _store.workEmailIdFocus,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        decoration: InputDecoration(
                          label: text('WorkEmailId'.translate(context)),
                          icon: Icon(Icons.email),
                        ),
                        validator: (s) {
                          if (s.isEmptyOrNull) {
                            return 'Work email is required';
                          }
                          return null;
                        },
                      ),
                      10.height,
                      TextFormField(
                        controller: _store.workMobileNumberCont,
                        focusNode: _store.workMobileNumberFocus,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          label: text('WorkMobileNo'.translate(context)),
                          icon: Icon(Icons.phone),
                        ),
                        validator: (s) {
                          if (s.isEmptyOrNull) {
                            return 'Work phone number is required';
                          }
                          return null;
                        },
                      ),
                      10.height,
                      TextFormField(
                        controller: _store.joiningDateCont,
                        focusNode: _store.joiningDateFocus,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        onTap: () {
                          hideKeyboard(context);
                          _selectJoiningDate(context);
                        },
                        decoration: InputDecoration(
                          label: text('JoiningDate'.translate(context)),
                          icon: Icon(Icons.calendar_month),
                        ),
                        validator: (s) {
                          if (s.isEmptyOrNull) {
                            return 'Joining date is required';
                          }
                          return null;
                        },
                      ),
                      10.height,
                      TextFormField(
                        controller: _store.salaryCont,
                        focusNode: _store.salaryFocus,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        decoration: InputDecoration(
                          label: text('Salary'.translate(context)),
                          icon: Icon(Icons.money),
                        ),
                        validator: (s) {
                          if (s.isEmptyOrNull) {
                            return 'Salary is required';
                          }
                          return null;
                        },
                      ),
                      10.height,
                      TextFormField(
                        controller: _store.uanNumberCont,
                        focusNode: _store.uanNumberFocus,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        decoration: InputDecoration(
                          label: text('UanNo'.translate(context)),
                          icon: Icon(Icons.perm_identity),
                        ),
                        validator: (s) {
                          if (s.isEmptyOrNull) {
                            return 'UAN (PF) number is required';
                          }
                          return null;
                        },
                      ),
                      10.height,
                    ],
                  ).paddingAll(16),
                ),
              ),
              Form(
                  key: _formKey3,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _store.bankNameCont,
                          focusNode: _store.bankNameFocus,
                          style: const TextStyle(
                            fontSize: AppSizes.fontSizeLg,
                            // fontFamily: fontRegular
                          ),
                          decoration: InputDecoration(
                            label: text('BankName'.translate(context)),
                            icon: Icon(Icons.account_balance),
                          ),
                          validator: (s) {
                            if (s.isEmptyOrNull) {
                              return 'Bank Name is required';
                            }
                            return null;
                          },
                        ),
                        10.height,
                        TextFormField(
                          controller: _store.accountNumberCont,
                          focusNode: _store.accountNumberFocus,
                          style: const TextStyle(
                            fontSize: AppSizes.fontSizeLg,
                            // fontFamily: fontRegular
                          ),
                          decoration: InputDecoration(
                            label: text('AccountNumber'.translate(context)),
                            icon: Icon(Icons.account_balance_wallet),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (s) {
                            if (s.isEmptyOrNull) {
                              return 'Account Number is required';
                            }
                            return null;
                          },
                        ),
                        10.height,
                        TextFormField(
                          controller: _store.branchNameCont,
                          focusNode: _store.branchNameFocus,
                          style: const TextStyle(
                            fontSize: AppSizes.fontSizeLg,
                            // fontFamily: fontRegular
                          ),
                          decoration: InputDecoration(
                            label: text(
                              'BranchName'.translate(context),
                            ),
                            icon: Icon(Icons.account_balance_wallet),
                          ),
                          validator: (s) {
                            if (s.isEmptyOrNull) {
                              return 'Branch is required';
                            }
                            return null;
                          },
                        ),
                        10.height,
                        TextFormField(
                          controller: _store.ifscCodeCont,
                          focusNode: _store.ifscCodeFocus,
                          style: const TextStyle(
                            fontSize: AppSizes.fontSizeLg,
                            // fontFamily: fontRegular
                          ),
                          decoration: InputDecoration(
                            label: text('IFSCCode'.translate(context)),
                            icon: Icon(Icons.account_balance_wallet),
                          ),
                          validator: (s) {
                            if (s.isEmptyOrNull) {
                              return 'IFSC code is required';
                            }
                            return null;
                          },
                        ),
                        10.height,
                        TextFormField(
                          controller: _store.bankMobileNumberCont,
                          focusNode: _store.bankMobileNumberFocus,
                          style: const TextStyle(
                            fontSize: AppSizes.fontSizeLg,
                            // fontFamily: fontRegular
                          ),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            label: text('MobileNumber'.translate(context)),
                            icon: Icon(Icons.phone),
                          ),
                          validator: (s) {
                            if (s.isEmptyOrNull) {
                              return 'Phone number is required';
                            }
                            return null;
                          },
                        ),
                        10.height,
                        Row(
                          children: [
                            SizedBox(
                              height: 50,
                              child: Card(
                                color: AppColors.primary,
                                child: Center(
                                    child: Text(
                                  'EmergencyContactInfo'.translate(context),
                                  style: primaryTextStyle(color: Colors.white),
                                )),
                              ),
                            ).expand(),
                          ],
                        ),
                        10.height,
                        TextFormField(
                          controller: _store.emergenryContactNameCont,
                          focusNode: _store.emergenryContactNameFocus,
                          style: const TextStyle(
                            fontSize: AppSizes.fontSizeLg,
                          ),
                          decoration: InputDecoration(
                            label: text(
                              'GuardianName'.translate(context),
                            ),
                            icon: Icon(Icons.people),
                          ),
                          validator: (s) {
                            if (s.isEmptyOrNull) {
                              return 'Emergency contact is required';
                            }

                            if (s!.length == 1) {
                              return 'Minimum length is 5';
                            }
                            return null;
                          },
                        ),
                        10.height,
                        TextFormField(
                          controller: _store.emergenryContactAddressCont,
                          focusNode: _store.emergenryContactAddressFocus,
                          style: const TextStyle(
                            fontSize: AppSizes.fontSizeLg,
                            // fontFamily: fontRegular
                          ),
                          decoration: InputDecoration(
                            label: text('Address'.translate(context)),
                            icon: Icon(Icons.location_on),
                          ),
                          validator: (s) {
                            if (s.isEmptyOrNull) {
                              return 'Address is required';
                            }

                            return null;
                          },
                        ),
                        10.height,
                        TextFormField(
                          controller: _store.emergenryContactMobileNumberCont,
                          focusNode: _store.emergenryContactMobileNumberFocus,
                          style: const TextStyle(
                            fontSize: AppSizes.fontSizeLg,
                            // fontFamily: fontRegular
                          ),
                          decoration: InputDecoration(
                            label: text('MobileNumber'.translate(context)),
                            icon: Icon(Icons.phone),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (s) {
                            if (s.isEmptyOrNull) {
                              return 'Phone Number is required';
                            }

                            if (s!.length > 10) {
                              return 'Maximum length is 10';
                            }
                            return null;
                          },
                        ),
                        10.height,
                        TextFormField(
                          controller: _store.emergenryContactRelationCont,
                          focusNode: _store.emergenryContactRelationFocus,
                          style: const TextStyle(
                            fontSize: AppSizes.fontSizeLg,
                            // fontFamily: fontRegular
                          ),
                          decoration: InputDecoration(
                            label: text('Relationship'.translate(context)),
                            icon: Icon(Icons.people),
                          ),
                          validator: (s) {
                            if (s.isEmptyOrNull) {
                              return 'Relation is required';
                            }

                            return null;
                          },
                        ),
                        100.height,
                      ],
                    ).paddingAll(16),
                  )),
              Form(
                  key: _formKey4,
                  child: SingleChildScrollView(
                    child: Observer(
                        builder: (_) => Column(children: [
                              10.height,
                              _store.isAadharLoading
                                  ? buildShimmer(150, context.width())
                                  : _store.isAadharDone
                                      ? verifyCompleteCard(
                                          image: _store.aadharFile!,
                                          title: "Aadhar Front",
                                          iconHeading: 'images/fa_camera.png',
                                          buttonClick: () =>
                                              _store.removePhoto(),
                                          isDoc: true,
                                          context: context)
                                      : verifyCard(
                                          image: 'images/id_card.png',
                                          title: "Aadhar Front",
                                          description: 'Description',
                                          iconHeading: 'images/fa_camera.png',
                                          iconHeadingText: "Take a photo",
                                          buttonClick: () async {
                                            showFilePickerDialog(
                                              context,
                                              (File selectedFile) {
                                                _store.aadharFile =
                                                    selectedFile;
                                                _store.aadharFilePath =
                                                    selectedFile.path;
                                                _store.processAadhar();
                                              },
                                              allowedExtensions: ['pdf'],
                                            );
                                          },
                                          isDoc: true,
                                          context: context,
                                        ),
                              16.height,
                              _store.isAadharBackLoading
                                  ? buildShimmer(150, context.width())
                                  : _store.isAadharBackDone
                                      ? verifyCompleteCard(
                                          image: _store.aadharBackFile!,
                                          title: "Aadhar Back",
                                          iconHeading: 'images/fa_camera.png',
                                          buttonClick: () =>
                                              _store.removePhoto(),
                                          isDoc: true,
                                          context: context)
                                      : verifyCard(
                                          image: 'images/id_card.png',
                                          title: "Aadhar Back",
                                          description: 'Description',
                                          iconHeading: 'images/fa_camera.png',
                                          iconHeadingText: "Take a photo",
                                          buttonClick: () async {
                                            showFilePickerDialog(
                                              context,
                                              (File selectedFile) {
                                                _store.aadharBackFile =
                                                    selectedFile;
                                                _store.aadharBackPath =
                                                    selectedFile.path;
                                                _store.processAadharBack();
                                              },
                                              allowedExtensions: ['pdf'],
                                            );
                                          },
                                          isDoc: true,
                                          context: context,
                                        ),
                              16.height,
                              _store.isPanLoading
                                  ? buildShimmer(150, context.width())
                                  : _store.isPanDone
                                      ? verifyCompleteCard(
                                          image: _store.panFile!,
                                          title: "Pan Card",
                                          iconHeading: 'images/fa_user.png',
                                          buttonClick: () =>
                                              _store.removePhoto(),
                                          isDoc: true,
                                          context: context)
                                      : verifyCard(
                                          image: 'images/pan.png',
                                          title: "Pan Card",
                                          description: 'Description',
                                          iconHeading: 'images/fa_camera.png',
                                          iconHeadingText: "Take a photo",
                                          buttonClick: () async {
                                            showFilePickerDialog(
                                              context,
                                              (File selectedFile) {
                                                _store.panFile = selectedFile;
                                                _store.panFilePath =
                                                    selectedFile.path;
                                                _store.processPan();
                                              },
                                              allowedExtensions: ['pdf'],
                                            );
                                          },
                                          isDoc: true,
                                          context: context),
                              16.height,
                              _store.isProfileLoading
                                  ? buildShimmer(150, context.width())
                                  : _store.isProfileDone
                                      ? verifyCompleteCard(
                                          image: _store.profileFile!,
                                          title: "Selfie",
                                          iconHeading: 'images/fa_user.png',
                                          buttonClick: () =>
                                              _store.removePhoto(),
                                          isDoc: true,
                                          context: context)
                                      : verifyCard(
                                          image: 'images/fa_user.png',
                                          title: "Selfie",
                                          description: 'Description',
                                          iconHeading: 'images/fa_camera.png',
                                          iconHeadingText: "Take a photo",
                                          buttonClick: () async {
                                            showFilePickerDialog(
                                              context,
                                              (File selectedFile) {
                                                _store.profileFile =
                                                    selectedFile;
                                                _store.profileFilePath =
                                                    selectedFile.path;
                                                _store.processProfile();
                                              },
                                              allowedExtensions: ['pdf'],
                                            );
                                          },
                                          isDoc: true,
                                          context: context),
                              16.height,
                              _store.isBankStatementLoading
                                  ? buildShimmer(150, context.width())
                                  : _store.isBankStatementDone
                                      ? verifyCompleteCard(
                                          image: _store.bankStatementFile!,
                                          title:
                                              "3Months\nBank Statement\n or\n Pay slip",
                                          iconHeading: 'images/fa_user.png',
                                          buttonClick: () =>
                                              _store.removePhoto(),
                                          isDoc: true,
                                          context: context)
                                      : verifyCard(
                                          image: 'images/BankStmt.png',
                                          title:
                                              " 3Months\n Bank Statements\n or Pay slip",
                                          description:
                                              'Description'.translate(context),
                                          iconHeading: 'images/fa_camera.png',
                                          iconHeadingText:
                                              "TakePhoto".translate(context),
                                          buttonClick: () async {
                                            showFilePickerDialog(
                                              context,
                                              (File selectedFile) {
                                                _store.bankStatementFile =
                                                    selectedFile;
                                                _store.bankStatementFilePath =
                                                    selectedFile.path;
                                                _store.processBankStatement();
                                              },
                                              allowedExtensions: ['pdf'],
                                            );
                                          },
                                          isDoc: true,
                                          context: context),
                              16.height,
                              _store.isUgCertificateLoading
                                  ? buildShimmer(150, context.width())
                                  : _store.isUgCertificateDone
                                      ? verifyCompleteCard(
                                          image: _store.ugCertificateFile!,
                                          title: "UGCertificate"
                                              .translate(context),
                                          iconHeading: 'images/fa_user.png',
                                          buttonClick: () =>
                                              _store.removePhoto(),
                                          isDoc: true,
                                          context: context)
                                      : verifyCard(
                                          image: 'images/cert.png',
                                          title: "UGCertificate"
                                              .translate(context),
                                          description:
                                              'Description'.translate(context),
                                          iconHeading: 'images/fa_camera.png',
                                          iconHeadingText:
                                              "TakePhoto".translate(context),
                                          buttonClick: () async {
                                            showFilePickerDialog(
                                              context,
                                              (File selectedFile) {
                                                _store.ugCertificateFile =
                                                    selectedFile;
                                                _store.ugCertificateFilePath =
                                                    selectedFile.path;
                                                _store.processUgCertificate();
                                              },
                                              allowedExtensions: ['pdf'],
                                            );
                                          },
                                          isDoc: true,
                                          context: context),
                              16.height,
                              _store.isPgCertificateLoading
                                  ? buildShimmer(150, context.width())
                                  : _store.isPgCertificateDone
                                      ? verifyCompleteCard(
                                          image: _store.pgCertificateFile!,
                                          title: "PGCertificate"
                                              .translate(context),
                                          iconHeading: 'images/fa_user.png',
                                          buttonClick: () =>
                                              _store.removePhoto(),
                                          isDoc: true,
                                          context: context)
                                      : verifyCard(
                                          image: 'images/cert.png',
                                          title: "PGCertificate"
                                              .translate(context),
                                          description:
                                              'Description'.translate(context),
                                          iconHeading: 'images/fa_camera.png',
                                          iconHeadingText:
                                              "TakePhoto".translate(context),
                                          buttonClick: () async {
                                            showFilePickerDialog(context,
                                                (File selectedFile) {
                                              _store.pgCertificateFile =
                                                  selectedFile;
                                              _store.pgCertificateFilePath =
                                                  selectedFile.path;
                                              _store.processPgCertificate();
                                            }, allowedExtensions: ['pdf']);
                                          },
                                          isDoc: true,
                                          context: context),
                              16.height,
                              _store.isBankChequeLoading
                                  ? buildShimmer(150, context.width())
                                  : _store.isBankChequeDone
                                      ? verifyCompleteCard(
                                          image: _store.bankChequeFile!,
                                          title:
                                              "BankCheque".translate(context),
                                          iconHeading: 'images/fa_user.png',
                                          buttonClick: () =>
                                              _store.removePhoto(),
                                          isDoc: true,
                                          context: context)
                                      : verifyCard(
                                          image: 'images/check.png',
                                          title:
                                              "BankCheque".translate(context),
                                          description:
                                              'Description'.translate(context),
                                          iconHeading: 'images/fa_camera.png',
                                          iconHeadingText:
                                              "TakePhoto".translate(context),
                                          buttonClick: () async {
                                            showFilePickerDialog(
                                              context,
                                              (File selectedFile) {
                                                _store.bankChequeFile =
                                                    selectedFile;
                                                _store.bankChequeFilePath =
                                                    selectedFile
                                                        .path; // Update the file path
                                                _store
                                                    .processBankCheque(); // Call the processing method
                                              },
                                              allowedExtensions: [
                                                'pdf'
                                              ], // Only allow PDFs for bank cheque
                                            );
                                            // FilePickerResult? result =
                                            //     await FilePicker.platform
                                            //         .pickFiles(
                                            //             type: FileType.custom,
                                            //             allowedExtensions: [
                                            //       'pdf'
                                            //     ]);
                                            // if (result != null) {
                                            //   _store.bankChequeFile = File(
                                            //       result.files.single.path!);
                                            //   _store.file = File(
                                            //       result.files.single.path!);
                                            //   _store.bankChequeFilePath =
                                            //       result.files.single.path!;
                                            //   _store.filePath =
                                            //       result.files.single.path!;
                                            //   _store.processBankCheque();
                                            // } else {
                                            //   toast('Please select a file');
                                            // }
                                          },
                                          isDoc: true,
                                          context: context),
                              16.height,
                              _store.isResumeLoading
                                  ? buildShimmer(150, context.width())
                                  : _store.isResumeDone
                                      ? verifyCompleteCard(
                                          image: _store.resumeFile!,
                                          title: "Resume".translate(context),
                                          iconHeading: 'images/fa_user.png',
                                          buttonClick: () =>
                                              _store.removePhoto(),
                                          isDoc: true,
                                          context: context)
                                      : verifyCard(
                                          image: 'images/resume.png',
                                          title: "Resume".translate(context),
                                          description: 'Description',
                                          iconHeading: 'images/fa_camera.png',
                                          iconHeadingText:
                                              "TakePhoto".translate(context),
                                          buttonClick: () async {
                                            showFilePickerDialog(
                                              context,
                                              (File selectedFile) {
                                                _store.resumeFile =
                                                    selectedFile;
                                                _store.resumeFilePath = selectedFile
                                                    .path; // Update the file path
                                                _store.processResume();
                                              },
                                              allowedExtensions: ['pdf'],
                                            );
                                          },
                                          isDoc: true,
                                          context: context),
                              100.height,
                            ]).paddingAll(16)),
                  ))
            ],
          ),
          floatingActionButton: Observer(
              builder: (_) => FloatingActionButton.extended(
                    backgroundColor: AppFloatingActionButtonTheme
                        .lightFloatingActionButtonTheme.backgroundColor,
                    foregroundColor: AppFloatingActionButtonTheme
                        .lightFloatingActionButtonTheme.foregroundColor,
                    elevation: AppFloatingActionButtonTheme
                        .lightFloatingActionButtonTheme.elevation,
                    shape: AppFloatingActionButtonTheme
                        .lightFloatingActionButtonTheme.shape,
                    onPressed: () async {
                      if (_currentIndex == 0 &&
                          _formKey1.currentState!.validate()) {
                        // _store.validatePhoneNumber(_store.phoneNumberCont.text);
                        _currentIndex += 1;
                        _tabController.animateTo(_currentIndex);
                      } else if (_currentIndex == 1 &&
                          _formKey2.currentState!.validate()) {
                        _currentIndex += 1;
                        _tabController.animateTo(_currentIndex);
                      } else if (_currentIndex == 2 &&
                          _formKey3.currentState!.validate()) {
                        _currentIndex += 1;
                        _tabController.animateTo(_currentIndex);
                      } else if (_currentIndex == 3) {
                        _formKey4.currentState!.validate();
                        if (_store.selectedBloodGroup == null) {
                          toast('Blood group is required');
                          return;
                        }

                        if (_store.selectedGender == null) {
                          toast('gender is required');
                          return;
                        }

                        if (_store.selectedMaritalStatus == null) {
                          toast('Maritial status is required');
                          return;
                        }
                        if (!_store.areAllFilesSelected()) {
                          toast('Please add all required files');
                          return;
                        }
                        // var result = await _store.registerUser();

                        if (!mounted) return;

                        // if(result){
                        //   toast('Registered successfully');
                        //   const RegisterSuccessScreen().launch(context, isNewTask: true);
                        // }
                      }
                    },
                    label: Row(
                      children: [
                        _currentIndex == 3
                            ? const Text('Register')
                            : const Text('Next'),
                        10.width,
                        _currentIndex == 3
                            ? text('')
                            : const Icon(Icons.arrow_forward),
                      ],
                    ),
                  )),
        ),
      ),
    );
  }

  Future<void> _selectJoiningDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        helpText: 'Date',
        cancelText: 'Cancel',
        confirmText: "Choose",
        fieldLabelText: 'From Date',
        fieldHintText: 'Month/Date/Year',
        errorFormatText: 'Enter valid date',
        errorInvalidText: 'Enter date in valid range',
        context: context,
        builder: (BuildContext context, Widget? child) {
          return CustomTheme(
            child: child,
          );
        },
        initialDate: _store.today,
        firstDate: DateTime(2020),
        lastDate: _store.today);
    if (picked != null && picked != _store.selectedJoiningDate) {
      if (!_store.selectedJoiningDate.isAfter(_store.today)) {
        toast('You cannot select older dates');
        return;
      } else {
        setState(() {
          _store.selectedJoiningDate = picked;
          _store.joiningDateCont.text =
              formatter.format(_store.selectedJoiningDate);
        });
      }
    }
  }

  Future<void> _selectDobDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        helpText: 'Date',
        cancelText: 'Cancel',
        confirmText: "Choose",
        fieldLabelText: 'From Date',
        fieldHintText: 'Month/Date/Year',
        errorFormatText: 'Enter valid date',
        errorInvalidText: 'Enter date in valid range',
        context: context,
        builder: (BuildContext context, Widget? child) {
          return CustomTheme(
            child: child,
          );
        },
        initialDate: _store.today,
        firstDate: DateTime(1950),
        lastDate: _store.today);
    if (picked != null && picked != _store.selectedDate) {
      _store.selectedDate = picked;
      if (_store.selectedDate.isAfter(_store.today)) {
        toast('You cannot select future dates');
        return;
      } else {
        setState(() {
          _store.selectedDate = picked;
          _store.dobCont.text = formatter.format(_store.selectedDate);
        });
      }
    }
  }

  /*Widget uploadCard(String name) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: context.width() / 2,
            child: Text(
              name,
              style: primaryTextStyle(),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Column(
            children: [
              button('Take Photo', onTap: () {}),
            ],
          )
        ],
      ).paddingAll(16),
    );
  }*/
}

Widget verifyCard({
  required String image,
  required String title,
  required String description,
  required String iconHeadingText,
  required String iconHeading,
  required Function buttonClick,
  required bool isDoc,
  required BuildContext context,
}) {
  final theme = Provider.of<ThemeNotifier>(context);
  return Container(
    decoration: boxDecorationWithShadow(
      borderRadius: radius(AppSizes.borderRadiusXlg),
      backgroundColor: theme.isDarkMode ? Colors.blueGrey : Colors.white,
    ),
    padding: const EdgeInsets.all(16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: 70, width: 70, fit: BoxFit.fill),
            16.height,
            Text(title, style: boldTextStyle()),
            8.height,
            Text(description,
                style: primaryTextStyle(), textAlign: TextAlign.center),
            10.height,
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton(
                  width: 50,
                  color: AppColors.primary,
                  shapeBorder: buildButtonCorner(),
                  onTap: buttonClick,
                  child: isDoc
                      ? Row(
                          children: [
                            const Icon(
                              Icons.file_upload_outlined,
                              size: AppSizes.iconMd,
                              color: Colors.white,
                            ),
                            3.width,
                            Text(
                              "Upload".translate(context),
                              style: primaryTextStyle(color: white),
                            )
                          ],
                        )
                      : Row(
                          children: [
                            Image.asset(iconHeading,
                                height: AppSizes.iconMd,
                                width: AppSizes.iconMd,
                                color: Colors.white,
                                fit: BoxFit.fill),
                            3.width,
                            Text(
                              "TakePhoto".translate(context),
                              style: primaryTextStyle(color: white),
                            )
                          ],
                        ),
                ),
              ],
            )
          ],
        )
      ],
    ),
  );
}

Widget verifyCompleteCard({
  required File image,
  required String title,
  required String iconHeading,
  required Function buttonClick,
  required bool isDoc,
  required BuildContext context,
}) {
  final theme = Provider.of<ThemeNotifier>(context);
  return Container(
    decoration: boxDecorationWithShadow(
      borderRadius: radius(AppSizes.borderRadiusXlg),
      backgroundColor: theme.isDarkMode ? Colors.blueGrey : Colors.white,
    ),
    padding: const EdgeInsets.all(AppSizes.md),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            isDoc
                ? Lottie.asset('assets/success.json',
                    repeat: false, height: 125, width: 125)
                : Image.file(image, height: 100, width: 100, fit: BoxFit.fill)
                    .cornerRadiusWithClipRRect(10),
            8.height,
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton(
                  width: 50,
                  color: AppColors.error,
                  shapeBorder:
                      buildRoundedCorner(radius: AppSizes.borderRadious30),
                  onTap: buttonClick,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.delete_forever,
                        size: AppSizes.icon20,
                        color: white,
                      ),
                      3.width,
                      Text(
                        "Delete".translate(context),
                        style: primaryTextStyle(color: white),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        )
      ],
    ),
  );
}

Future<void> showFilePickerDialog(
  BuildContext context,
  Function(File) onFilePicked, {
  List<String>? allowedExtensions,
}) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'ChooseOption'.translate(context),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        content: SizedBox(
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Camera Option Card
              _optionCard(
                context,
                icon: Icons.camera_alt,
                label: 'OpenCamera'.translate(context),
                onTap: () async {
                  Navigator.pop(context); // Close dialog
                  try {
                    final pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                      imageQuality: 85,
                    );
                    if (pickedFile != null) {
                      onFilePicked(File(pickedFile.path));
                    } else {
                      toast("Please select a file");
                    }
                  } catch (e) {
                    toast("Camera permission is required");
                  }
                },
              ),
              // File Option Card
              _optionCard(
                context,
                icon: Icons.folder,
                label: 'PickfromFiles'.translate(context),
                onTap: () async {
                  var status = await Permission.storage.request();
                  if (status.isGranted) {
                    Navigator.pop(context);
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions:
                          allowedExtensions ?? ['pdf', 'jpg', 'jpeg', 'png'],
                    );
                    if (result != null) {
                      onFilePicked(File(result.files.single.path!));
                    } else {
                      toast("Please select a file");
                    }
                  } else if (status.isDenied) {
                    toast("Storage permission is required");
                  } else if (status.isPermanentlyDenied) {
                    openAppSettings();
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancel".translate(context),
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}

Widget _optionCard(BuildContext context,
    {required IconData icon,
    required String label,
    required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Container(
        width: 110,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: AppColors.primary,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
