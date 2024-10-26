import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:orbit_teams_flutter/localization/app_localization.dart';
import 'package:orbit_teams_flutter/screens/register/register_store.dart';
import 'package:orbit_teams_flutter/utils/constents/colors.dart';
import 'package:orbit_teams_flutter/utils/constents/sizes.dart';
import 'package:orbit_teams_flutter/utils/theme/theme_provider/theme_provider.dart';
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
                        // controller: _store.fullNameCont,
                        // focusNode: _store.fullNameFocus,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                        ),
                        decoration: editTextDecoration(
                            "lblFullName".translate(context),
                            Icons.person,
                            context),
                        // validator: (s) {
                        //   if (s.isEmptyOrNull) {
                        //     return 'Full Name is required';
                        //   }
                        //   return null;
                        // },
                      ),
                      10.height,
                      // FormField<String>(
                      //   builder: (FormFieldState<String> state) {
                      //     return DropdownButtonFormField(
                      //       items: _store.gender.map((item) {
                      //         return DropdownMenuItem(
                      //             value: item,
                      //             child: Row(
                      //               children: <Widget>[
                      //                 Text(item),
                      //               ],
                      //             ));
                      //       }).toList(),

                      FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return DropdownButtonFormField<String>(
                            items: ['Male', 'Female', 'Other']
                                .map((String gender) {
                              return DropdownMenuItem<String>(
                                value: gender,
                                child: Row(
                                  children: <Widget>[
                                    Text(gender),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {},
                            borderRadius: BorderRadius.circular(20.0),
                            // value: _store.selectedGender,
                            decoration: editTextDecoration(
                                'lblGender'.translate(context),
                                Icons.person,
                                context),
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
                        // controller: _store.addressCont,
                        // focusNode: _store.addressFocus,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        decoration: editTextDecoration(
                            'lblAddress'.translate(context),
                            Icons.house,
                            context),
                        validator: (s) {
                          if (s.isEmptyOrNull) {
                            return 'Address is required';
                          }
                          return null;
                        },
                      ),
                      10.height,
                      TextFormField(
                        // controller: _store.phoneNumberCont,
                        // focusNode: _store.phoneNumberFocus,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        decoration: editTextDecoration(
                            "lblMobileNumber".translate(context),
                            Icons.phone,
                            context),
                        validator: (s) {
                          if (s.isEmptyOrNull) {
                            return 'Mobile number is required';
                          }
                          return null;
                        },
                      ),
                      10.height,
                      TextFormField(
                        // controller: _store.emailCont,
                        // focusNode: _store.emailFocus,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        decoration: editTextDecoration(
                            'lblEmail'.translate(context),
                            Icons.email,
                            context),
                        validator: (s) {
                          if (s.isEmptyOrNull) {
                            return 'Email is required';
                          }
                          return null;
                        },
                      ),
                      10.height,
                      TextFormField(
                        // controller: _store.dobCont,
                        // focusNode: _store.dobFocus,
                        onTap: () {
                          hideKeyboard(context);
                          _selectDobDate(context);
                        },
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        decoration: editTextDecoration(
                            'lblDateOfBirth'.translate(context),
                            Icons.date_range,
                            context),
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
                          return DropdownButtonFormField<String>(
                            items: ['Single', 'Married', 'Divorced', 'Widowed']
                                .map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Row(
                                  children: <Widget>[
                                    Text(item),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                // selectedMaritalStatus = newValue;
                              });
                            },
                            borderRadius:
                                BorderRadius.circular(AppSizes.borderRadious20),
                            // value: _store.selectedMaritalStatus,
                            decoration: editTextDecoration(
                                'lblMaritalStatus'.translate(context),
                                Icons.person,
                                context),
                            /*validator: (s) {
                            if (s.isEmptyOrNull) {
                              return 'Marital status is required';
                            }
                            return null;
                          },*/
                          );
                        },
                      ),
                      10.height,
                      FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return DropdownButtonFormField<String>(
                            items: [
                              'A+',
                              'A-',
                              'B+',
                              'B-',
                              'O+',
                              'O-',
                              'AB+',
                              'AB-'
                            ].map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Row(
                                  children: <Widget>[
                                    Text(item),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                // selectedBloodGroup = newValue;
                              });
                            },
                            borderRadius: BorderRadius.circular(20.0),

                            // value: _store.selectedBloodGroup,
                            decoration: editTextDecoration(
                                'lblBloodGroup'.translate(context),
                                Icons.bloodtype,
                                context),
                            // validator: (s) {
                            //   if (s.isEmptyOrNull) {
                            //     return 'Blood group is required';
                            //   }
                            //   return null;
                            // },
                          );
                        },
                      ),
                      10.height,
                      TextFormField(
                        // controller: _store.relationCont,
                        // focusNode: _store.relationFocus,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        decoration: editTextDecoration(
                            'lblGuardianName'.translate(context),
                            Icons.people,
                            context),
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
                        // controller: _store.designationCont,
                        // focusNode: _store.designationFocus,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        decoration: editTextDecoration(
                            'lblDesignation'.translate(context),
                            Icons.account_box_sharp,
                            context),
                        validator: (s) {
                          if (s.isEmptyOrNull) {
                            return 'Designation is required';
                          }
                          return null;
                        },
                      ),
                      10.height,
                      TextFormField(
                        // controller: _store.workLocationCont,
                        // focusNode: _store.workLocationFocus,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        decoration: editTextDecoration(
                            'lblWorkLocation'.translate(context),
                            Icons.location_on,
                            context),
                        validator: (s) {
                          if (s.isEmptyOrNull) {
                            return 'Work location is required';
                          }
                          return null;
                        },
                      ),
                      10.height,
                      TextFormField(
                        // controller: _store.workEmailIdCont,
                        // focusNode: _store.workEmailIdFocus,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        decoration: editTextDecoration(
                            'lblWorkEmailId'.translate(context),
                            Icons.email,
                            context),
                        /*validator: (s) {
                        if (s.isEmptyOrNull) {
                          return 'Work email is required';
                        }
                        return null;
                      },*/
                      ),
                      10.height,
                      TextFormField(
                        // controller: _store.workMobileNumberCont,
                        // focusNode: _store.workMobileNumberFocus,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        keyboardType: TextInputType.number,
                        decoration: editTextDecoration(
                            'lblWorkMobileNo'.translate(context),
                            Icons.phone,
                            context),
                        /*validator: (s) {
                        if (s.isEmptyOrNull) {
                          return 'Work phone number is required';
                        }
                        return null;
                      },*/
                      ),
                      10.height,
                      TextFormField(
                        // controller: _store.joiningDateCont,
                        // focusNode: _store.joiningDateFocus,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        onTap: () {
                          hideKeyboard(context);
                          _selectJoiningDate(context);
                        },
                        decoration: editTextDecoration(
                            'lblJoiningDate'.translate(context),
                            Icons.calendar_month,
                            context),
                        validator: (s) {
                          if (s.isEmptyOrNull) {
                            return 'Joining date is required';
                          }
                          return null;
                        },
                      ),
                      10.height,
                      TextFormField(
                        // controller: _store.salaryCont,
                        // focusNode: _store.salaryFocus,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        decoration: editTextDecoration(
                            'lblSalary'.translate(context),
                            Icons.money,
                            context),
                        validator: (s) {
                          if (s.isEmptyOrNull) {
                            return 'Salary is required';
                          }
                          return null;
                        },
                      ),
                      10.height,
                      TextFormField(
                        // controller: _store.uanNumberCont,
                        // focusNode: _store.uanNumberFocus,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeLg,
                          // fontFamily: fontRegular
                        ),
                        decoration: editTextDecoration(
                            'lblUanNo'.translate(context),
                            Icons.perm_identity,
                            context),
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
                          // controller: _store.bankNameCont,
                          // focusNode: _store.bankNameFocus,
                          style: const TextStyle(
                            fontSize: AppSizes.fontSizeLg,
                            // fontFamily: fontRegular
                          ),
                          decoration: editTextDecoration(
                              'lblBankName'.translate(context),
                              Icons.account_balance,
                              context),
                          validator: (s) {
                            if (s.isEmptyOrNull) {
                              return 'Bank Name is required';
                            }
                            return null;
                          },
                        ),
                        10.height,
                        TextFormField(
                          // controller: _store.accountNumberCont,
                          // focusNode: _store.accountNumberFocus,
                          style: const TextStyle(
                            fontSize: AppSizes.fontSizeLg,
                            // fontFamily: fontRegular
                          ),
                          decoration: editTextDecoration(
                              'lblAccountNumber'.translate(context),
                              Icons.account_balance_wallet,
                              context),
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
                          // controller: _store.branchNameCont,
                          // focusNode: _store.branchNameFocus,
                          style: const TextStyle(
                            fontSize: AppSizes.fontSizeLg,
                            // fontFamily: fontRegular
                          ),
                          decoration: editTextDecoration(
                              'lblBranchName'.translate(context),
                              Icons.account_balance_wallet,
                              context),
                          validator: (s) {
                            if (s.isEmptyOrNull) {
                              return 'Branch is required';
                            }
                            return null;
                          },
                        ),
                        10.height,
                        TextFormField(
                          // controller: _store.ifscCodeCont,
                          // focusNode: _store.ifscCodeFocus,
                          style: const TextStyle(
                            fontSize: AppSizes.fontSizeLg,
                            // fontFamily: fontRegular
                          ),
                          decoration: editTextDecoration(
                              'lblIFSCCode'.translate(context),
                              Icons.account_balance_wallet,
                              context),
                          validator: (s) {
                            if (s.isEmptyOrNull) {
                              return 'IFSC code is required';
                            }
                            return null;
                          },
                        ),
                        10.height,
                        TextFormField(
                          // controller: _store.bankMobileNumberCont,
                          // focusNode: _store.bankMobileNumberFocus,
                          style: const TextStyle(
                            fontSize: AppSizes.fontSizeLg,
                            // fontFamily: fontRegular
                          ),
                          keyboardType: TextInputType.number,
                          decoration: editTextDecoration(
                              'lblMobileNumber'.translate(context),
                              Icons.phone,
                              context),
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
                                  'lblEmergencyContactInfo'.translate(context),
                                  style: primaryTextStyle(color: Colors.white),
                                )),
                              ),
                            ).expand(),
                          ],
                        ),
                        10.height,
                        TextFormField(
                          // controller: _store.emergenryContactNameCont,
                          // focusNode: _store.emergenryContactNameFocus,
                          style: const TextStyle(
                            fontSize: AppSizes.fontSizeLg,
                          ),
                          decoration: editTextDecoration(
                              'lblGuardianName'.translate(context),
                              Icons.people,
                              context),
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
                          // controller: _store.emergenryContactAddressCont,
                          // focusNode: _store.emergenryContactAddressFocus,
                          style: const TextStyle(
                            fontSize: AppSizes.fontSizeLg,
                            // fontFamily: fontRegular
                          ),
                          decoration: editTextDecoration(
                              'lblAddress'.translate(context),
                              Icons.location_on,
                              context),
                          validator: (s) {
                            if (s.isEmptyOrNull) {
                              return 'Address is required';
                            }

                            return null;
                          },
                        ),
                        10.height,
                        TextFormField(
                          // controller: _store.emergenryContactMobileNumberCont,
                          // focusNode: _store.emergenryContactMobileNumberFocus,
                          style: const TextStyle(
                            fontSize: AppSizes.fontSizeLg,
                            // fontFamily: fontRegular
                          ),
                          decoration: editTextDecoration(
                              'lblMobileNo'.translate(context),
                              Icons.phone,
                              context),
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
                          // controller: _store.emergenryContactRelationCont,
                          // focusNode: _store.emergenryContactRelationFocus,
                          style: const TextStyle(
                            fontSize: AppSizes.fontSizeLg,
                            // fontFamily: fontRegular
                          ),
                          decoration: editTextDecoration(
                              'lblRelationship'.translate(context),
                              Icons.people,
                              context),
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
                                            FilePickerResult? result =
                                                await FilePicker.platform
                                                    .pickFiles(
                                                        type: FileType.custom,
                                                        allowedExtensions: [
                                                  'pdf'
                                                ]);
                                            if (result != null) {
                                              _store.aadharFile = File(
                                                  result.files.single.path!);
                                              _store.file = File(
                                                  result.files.single.path!);
                                              _store.aadharFilePath =
                                                  result.files.single.path!;
                                              _store.filePath =
                                                  result.files.single.path!;
                                              _store.processAadhar();
                                            } else {
                                              toast('Please select a file');
                                            }
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
                                            FilePickerResult? result =
                                                await FilePicker.platform
                                                    .pickFiles(
                                                        type: FileType.custom,
                                                        allowedExtensions: [
                                                  'pdf'
                                                ]);
                                            if (result != null) {
                                              _store.aadharBackFile = File(
                                                  result.files.single.path!);
                                              _store.file = File(
                                                  result.files.single.path!);
                                              _store.aadharBackPath =
                                                  result.files.single.path!;
                                              _store.filePath =
                                                  result.files.single.path!;
                                              _store.processAadharBack();
                                            } else {
                                              toast('Please select a file');
                                            }
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
                                            FilePickerResult? result =
                                                await FilePicker.platform
                                                    .pickFiles(
                                                        type: FileType.custom,
                                                        allowedExtensions: [
                                                  'pdf'
                                                ]);
                                            if (result != null) {
                                              _store.panFile = File(
                                                  result.files.single.path!);
                                              _store.file = File(
                                                  result.files.single.path!);
                                              _store.panFilePath =
                                                  result.files.single.path!;
                                              _store.filePath =
                                                  result.files.single.path!;
                                              _store.processPan();
                                            } else {
                                              toast('Please select a file');
                                            }
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
                                            FilePickerResult? result =
                                                await FilePicker.platform
                                                    .pickFiles(
                                                        type: FileType.custom,
                                                        allowedExtensions: [
                                                  'pdf'
                                                ]);
                                            if (result != null) {
                                              _store.profileFile = File(
                                                  result.files.single.path!);
                                              _store.file = File(
                                                  result.files.single.path!);
                                              _store.profileFilePath =
                                                  result.files.single.path!;
                                              _store.filePath =
                                                  result.files.single.path!;
                                              _store.processProfile();
                                            } else {
                                              toast('Please select a file');
                                            }
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
                                              "3Months \n Bank Statement \n or Pay slip",
                                          iconHeading: 'images/fa_user.png',
                                          buttonClick: () =>
                                              _store.removePhoto(),
                                          isDoc: true,
                                          context: context)
                                      : verifyCard(
                                          image: 'images/BankStmt.png',
                                          title:
                                              "3Months \n Bank Statements \n or Pay slip",
                                          description: 'Description',
                                          iconHeading: 'images/fa_camera.png',
                                          iconHeadingText: "Take a photo",
                                          buttonClick: () async {
                                            FilePickerResult? result =
                                                await FilePicker.platform
                                                    .pickFiles(
                                                        type: FileType.custom,
                                                        allowedExtensions: [
                                                  'pdf'
                                                ]);
                                            if (result != null) {
                                              _store.bankStatementFile = File(
                                                  result.files.single.path!);
                                              _store.file = File(
                                                  result.files.single.path!);
                                              _store.bankStatementFilePath =
                                                  result.files.single.path!;
                                              _store.filePath =
                                                  result.files.single.path!;
                                              _store.processBankStatement();
                                            } else {
                                              toast('Please select a file');
                                            }
                                          },
                                          isDoc: true,
                                          context: context),
                              16.height,
                              _store.isUgCertificateLoading
                                  ? buildShimmer(150, context.width())
                                  : _store.isUgCertificateDone
                                      ? verifyCompleteCard(
                                          image: _store.ugCertificateFile!,
                                          title: "UG Certificate",
                                          iconHeading: 'images/fa_user.png',
                                          buttonClick: () =>
                                              _store.removePhoto(),
                                          isDoc: true,
                                          context: context)
                                      : verifyCard(
                                          image: 'images/cert.png',
                                          title: "UG Certificate",
                                          description: 'Description',
                                          iconHeading: 'images/fa_camera.png',
                                          iconHeadingText: "Take a photo",
                                          buttonClick: () async {
                                            FilePickerResult? result =
                                                await FilePicker.platform
                                                    .pickFiles(
                                                        type: FileType.custom,
                                                        allowedExtensions: [
                                                  'pdf'
                                                ]);
                                            if (result != null) {
                                              _store.ugCertificateFile = File(
                                                  result.files.single.path!);
                                              _store.file = File(
                                                  result.files.single.path!);
                                              _store.ugCertificateFilePath =
                                                  result.files.single.path!;
                                              _store.filePath =
                                                  result.files.single.path!;
                                              _store.processUgCertificate();
                                            } else {
                                              toast('Please select a file');
                                            }
                                          },
                                          isDoc: true,
                                          context: context),
                              16.height,
                              _store.isPgCertificateLoading
                                  ? buildShimmer(150, context.width())
                                  : _store.isPgCertificateDone
                                      ? verifyCompleteCard(
                                          image: _store.pgCertificateFile!,
                                          title: "PG Certificate\n(optional)",
                                          iconHeading: 'images/fa_user.png',
                                          buttonClick: () =>
                                              _store.removePhoto(),
                                          isDoc: true,
                                          context: context)
                                      : verifyCard(
                                          image: 'images/cert.png',
                                          title: "PG Certificate\n(optional)",
                                          description: 'Description',
                                          iconHeading: 'images/fa_camera.png',
                                          iconHeadingText: "Take a photo",
                                          buttonClick: () async {
                                            FilePickerResult? result =
                                                await FilePicker.platform
                                                    .pickFiles(
                                                        type: FileType.custom,
                                                        allowedExtensions: [
                                                  'pdf'
                                                ]);
                                            if (result != null) {
                                              _store.pgCertificateFile = File(
                                                  result.files.single.path!);
                                              _store.file = File(
                                                  result.files.single.path!);
                                              _store.pgCertificateFilePath =
                                                  result.files.single.path!;
                                              _store.filePath =
                                                  result.files.single.path!;
                                              _store.processPgCertificate();
                                            } else {
                                              toast('Please select a file');
                                            }
                                          },
                                          isDoc: true,
                                          context: context),
                              16.height,
                              _store.isBankChequeLoading
                                  ? buildShimmer(150, context.width())
                                  : _store.isBankChequeDone
                                      ? verifyCompleteCard(
                                          image: _store.bankChequeFile!,
                                          title: "BankCheque",
                                          iconHeading: 'images/fa_user.png',
                                          buttonClick: () =>
                                              _store.removePhoto(),
                                          isDoc: true,
                                          context: context)
                                      : verifyCard(
                                          image: 'images/check.png',
                                          title: "Bank Cheque",
                                          description: 'Description',
                                          iconHeading: 'images/fa_camera.png',
                                          iconHeadingText: "Take a photo",
                                          buttonClick: () async {
                                            FilePickerResult? result =
                                                await FilePicker.platform
                                                    .pickFiles(
                                                        type: FileType.custom,
                                                        allowedExtensions: [
                                                  'pdf'
                                                ]);
                                            if (result != null) {
                                              _store.bankChequeFile = File(
                                                  result.files.single.path!);
                                              _store.file = File(
                                                  result.files.single.path!);
                                              _store.bankChequeFilePath =
                                                  result.files.single.path!;
                                              _store.filePath =
                                                  result.files.single.path!;
                                              _store.processBankCheque();
                                            } else {
                                              toast('Please select a file');
                                            }
                                          },
                                          isDoc: true,
                                          context: context),
                              16.height,
                              _store.isResumeLoading
                                  ? buildShimmer(150, context.width())
                                  : _store.isResumeDone
                                      ? verifyCompleteCard(
                                          image: _store.resumeFile!,
                                          title: "Resume",
                                          iconHeading: 'images/fa_user.png',
                                          buttonClick: () =>
                                              _store.removePhoto(),
                                          isDoc: true,
                                          context: context)
                                      : verifyCard(
                                          image: 'images/resume.png',
                                          title: "Resume",
                                          description: 'Description',
                                          iconHeading: 'images/fa_camera.png',
                                          iconHeadingText: "Take a photo",
                                          buttonClick: () async {
                                            FilePickerResult? result =
                                                await FilePicker.platform
                                                    .pickFiles(
                                                        type: FileType.custom,
                                                        allowedExtensions: [
                                                  'pdf'
                                                ]);
                                            if (result != null) {
                                              _store.resumeFile = File(
                                                  result.files.single.path!);
                                              _store.file = File(
                                                  result.files.single.path!);
                                              _store.resumeFilePath =
                                                  result.files.single.path!;
                                              _store.filePath =
                                                  result.files.single.path!;
                                              _store.processResume();
                                            } else {
                                              toast('Please select a file');
                                            }
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
                      } else {
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
                            ? Container()
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
      lastDate: DateTime.now(),
      // initialDate: _store.today,
      firstDate: DateTime(2020),
      // lastDate: _store.today
    );
    // if (picked != null && picked != _store.selectedJoiningDate) {
    //   if (!_store.selectedJoiningDate.isAfter(_store.today)) {
    //     toast('You cannot select older dates');
    //     return;
    //   } else {
    //     setState(() {
    //       _store.selectedJoiningDate = picked;
    //       _store.joiningDateCont.text =
    //           formatter.format(_store.selectedJoiningDate);
    //     });
    //   }
    // }
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
      // initialDate: _store.today,
      firstDate: DateTime(1950), lastDate: DateTime.now(),
      // lastDate: _store.today
    );
    // if (picked != null && picked != _store.selectedDate) {
    //   _store.selectedDate = picked;
    //   if (_store.selectedDate.isAfter(_store.today)) {
    //     toast('You cannot select future dates');
    //     return;
    //   } else {
    //     setState(() {
    //       _store.selectedDate = picked;
    //       _store.dobCont.text = formatter.format(_store.selectedDate);
    //     });
    //   }
    // }
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
      borderRadius: radius(16),
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
                              size: 24,
                              color: Colors.white,
                            ),
                            3.width,
                            Text(
                              "Upload",
                              style: primaryTextStyle(color: white),
                            )
                          ],
                        )
                      : Row(
                          children: [
                            Image.asset(iconHeading,
                                height: 24,
                                width: 24,
                                color: Colors.white,
                                fit: BoxFit.fill),
                            3.width,
                            Text(
                              "Take a photo",
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

// Widget verifyCompleteCard(
//     {required File image,
//     required String title,
//     required String iconHeading,
//     required Function buttonClick,
//     required bool isDoc,
//     required BuildContext context,}) {
//       final theme = Provider.of<ThemeNotifier>(context);
//   return Container(
//     decoration: boxDecorationWithShadow(
//       borderRadius: radius(16),
//       backgroundColor: theme.isDarkMode ? Colors.blueGrey : Colors.white,
//     ),
//     padding: const EdgeInsets.all(16),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(title),
//             isDoc
//                 ? Lottie.asset('assets/success.json',
//                     repeat: false, height: 125, width: 125)
//                 : Image.file(image, height: 100, width: 100, fit: BoxFit.fill)
//                     .cornerRadiusWithClipRRect(10),
//             8.height,
//           ],
//         ),
//         Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 AppButton(
//                   width: 50,
//                   color: Colors.red,
//                   shapeBorder: buildRoundedCorner(radius: 30),
//                   onTap: buttonClick,
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Icons.delete_forever,
//                         size: 20,
//                         color: white,
//                       ),
//                       3.width,
//                       Text(
//                         "Delete",
//                         style: primaryTextStyle(color: white),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             )
//           ],
//         )
//       ],
//     ),
//   );
// }
