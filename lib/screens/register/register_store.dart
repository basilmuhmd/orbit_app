import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'register_store.g.dart';

class RegisterStore = RegisterStoreBase with _$RegisterStore;

abstract class RegisterStoreBase with Store {
  @observable
  bool isLoading = false;

  final today = DateTime.now();
  DateTime selectedDate = DateTime.now();
  DateTime selectedJoiningDate = DateTime.now();
  @observable
  bool isAadharDone = false,
      isAadharBackDone = false,
      isPanDone = false,
      isProfileDone = false,
      isBankStatementDone = false,
      isUgCertificateDone = false,
      isPgCertificateDone = false,
      isBankChequeDone = false,
      isResumeDone = false;

  @observable
  bool isAadharLoading = false,
      isAadharBackLoading = false,
      isPanLoading = false,
      isProfileLoading = false,
      isBankStatementLoading = false,
      isUgCertificateLoading = false,
      isPgCertificateLoading = false,
      isBankChequeLoading = false,
      isResumeLoading = false;

  Type? type;

  List<String> bloodGroupList = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  String? selectedBloodGroup;

  List<String> maritalStatusList = [
    'Single',
    'Married',
    'Divorced',
    'Widowed',
  ];

  List<String> gender = ['Male', 'Female'];

  String? selectedGender;

  String? selectedMaritalStatus;

  final formKey = GlobalKey<FormState>();

  //Basic Details
  final fullNameCont = TextEditingController();
  final fullNameFocus = FocusNode();

  final addressCont = TextEditingController();
  final addressFocus = FocusNode();

  final phoneNumberCont = TextEditingController();
  final phoneNumberFocus = FocusNode();

  final emailCont = TextEditingController();
  final emailFocus = FocusNode();

  final dobCont = TextEditingController();
  final dobFocus = FocusNode();

  final bloodGroupCont = TextEditingController();
  final bloodGroupFocus = FocusNode();

  final maritalStatusCont = TextEditingController();
  final maritalStatusFocus = FocusNode();

  final relationCont = TextEditingController();
  final relationFocus = FocusNode();

  //Job info

  final designationCont = TextEditingController();
  final designationFocus = FocusNode();

  final workLocationCont = TextEditingController();
  final workLocationFocus = FocusNode();

  final workEmailIdCont = TextEditingController();
  final workEmailIdFocus = FocusNode();

  final workMobileNumberCont = TextEditingController();
  final workMobileNumberFocus = FocusNode();

  final joiningDateCont = TextEditingController();
  final joiningDateFocus = FocusNode();

  final salaryCont = TextEditingController();
  final salaryFocus = FocusNode();

  final uanNumberCont = TextEditingController();
  final uanNumberFocus = FocusNode();

  //Bank info

  final bankNameCont = TextEditingController();
  final bankNameFocus = FocusNode();

  final accountNumberCont = TextEditingController();
  final accountNumberFocus = FocusNode();

  final branchNameCont = TextEditingController();
  final branchNameFocus = FocusNode();

  final ifscCodeCont = TextEditingController();
  final ifscCodeFocus = FocusNode();

  final bankMobileNumberCont = TextEditingController();
  final bankMobileNumberFocus = FocusNode();

  //Emergency contact info

  final emergenryContactNameCont = TextEditingController();
  final emergenryContactNameFocus = FocusNode();

  final emergenryContactAddressCont = TextEditingController();
  final emergenryContactAddressFocus = FocusNode();

  final emergenryContactMobileNumberCont = TextEditingController();
  final emergenryContactMobileNumberFocus = FocusNode();

  final emergenryContactRelationCont = TextEditingController();
  final emergenryContactRelationFocus = FocusNode();

  @observable
  File? file,
      aadharFile,
      aadharBackFile,
      panFile,
      profileFile,
      bankStatementFile,
      ugCertificateFile,
      pgCertificateFile,
      bankChequeFile,
      resumeFile;
  String fileName = '', filePath = '';
  String aadharFileName = '', aadharFilePath = '';
  String aadharBackFileName = '', aadharBackPath = '';
  String panFileName = '', panFilePath = '';
  String profileFileName = '', profileFilePath = '';
  String bankStatementpanFileName = '', bankStatementFilePath = '';
  String ugCertificateFileName = '', ugCertificateFilePath = '';
  String pgCertificateFileName = '', pgCertificateFilePath = '';
  String bankChequeFileName = '', bankChequeFilePath = '';
  String resumeFileName = '', resumeFilePath = '';

  // final ImagePicker _picker = ImagePicker();

  final PhoneNumberError error = PhoneNumberError();

  // @observable
  // ObservableFuture<bool> phoneNumberCheck = ObservableFuture.value(true);

  // @computed
  // bool get isPhoneNumberCheckPending =>
  //     phoneNumberCheck.status == FutureStatus.pending;

  // Future validatePhoneNumber(String? value) async {
  //   if (isNull(value) || value == '') {
  //     error.phoneNumber = 'Cannot be blank';
  //     return;
  //   }

  //   if (value != null && value.length < 10) {
  //     error.phoneNumber = 'Invalid phone number';
  //     return;
  //   }

  //   try {
  //     phoneNumberCheck = ObservableFuture(apiRepo.checkPhoneNumber(value!));
  //     final isValid = await phoneNumberCheck;
  //     if (!isValid) {
  //       error.phoneNumber = 'Phone number not exists';
  //       return;
  //     }
  //     error.phoneNumber = null;
  //   } on Object catch (_) {
  //     error.phoneNumber = null;
  //   }

  //   error.phoneNumber = null;
  // }

  // List<ReactionDisposer> _disposers = [];

  // void setupValidations() {
  //   _disposers = [
  //     reaction((_) => phoneNumberCont.text, validatePhoneNumber),
  //   ];
  // }

  // void dispose() {
  //   for (final d in _disposers) {
  //     d();
  //   }
  // }

  @action
  Future processAadhar() async {
    type = Type.aadhar;
    //await takePhoto();
    if (file != null) {
      await uploadDocument();
    }
  }

  @action
  Future processAadharBack() async {
    type = Type.aadharBack;
    //await takePhoto();
    if (file != null) {
      await uploadDocument();
    }
  }

  @action
  Future processPan() async {
    type = Type.pan;
    //await takePhoto();
    if (file != null) {
      await uploadDocument();
    }
  }

  @action
  Future processProfile() async {
    type = Type.profile;
    //await takePhoto(isFront: true);
    if (file != null) {
      await uploadDocument();
    }
  }

  @action
  Future processBankStatement() async {
    type = Type.bankStatement;
    //await takePhoto();
    if (file != null) {
      await uploadDocument();
    }
  }

  @action
  Future processUgCertificate() async {
    type = Type.ugCertificate;
    //await takePhoto();
    if (file != null) {
      await uploadDocument();
    }
  }

  @action
  Future processPgCertificate() async {
    type = Type.pgCertificate;
    //await takePhoto();
    if (file != null) {
      await uploadDocument();
    }
  }

  @action
  Future processBankCheque() async {
    type = Type.bankCheque;
    //await takePhoto();
    if (file != null) {
      await uploadDocument();
    }
  }

  @action
  Future processResume() async {
    type = Type.resume;
    //await takePhoto();
    if (file != null) {
      await uploadDocument();
    }
  }

  // Future takePhoto({bool isFront = false}) async {
  //   var permission = await Permission.camera.status;
  //   toast(permission.toString());
  //   if (permission.isPermanentlyDenied || permission.isDenied) {
  //     toast('Please allow camera permission from app settings');
  //     if (!isIOS) {
  //       Future.delayed(const Duration(seconds: 1), () async {
  //         await openAppSettings();
  //       });
  //     }
  //     return;
  //   }
  //   if (permission.isGranted || permission.isLimited) {
  //     final XFile? photo = await _picker.pickImage(
  //         source: ImageSource.camera,
  //         preferredCameraDevice:
  //         isFront ? CameraDevice.front : CameraDevice.rear);

  //     if (photo != null) {
  //       fileName = photo.name;
  //       filePath = photo.path;
  //       file = File(photo.path);
  //       if (type == Type.aadharBack) {
  //         aadharBackFile = file;
  //       } else if (type == Type.aadhar) {
  //         aadharFile = file;
  //       } else if (type == Type.pan) {
  //         panFile = file;
  //       } else if (type == Type.bankStatement) {
  //         bankStatementFile = file;
  //       } else if (type == Type.ugCertificate) {
  //         ugCertificateFile = file;
  //       } else if (type == Type.pgCertificate) {
  //         pgCertificateFile = file;
  //       } else if (type == Type.bankCheque) {
  //         bankChequeFile = file;
  //       } else if (type == Type.resume) {
  //         resumeFile = file;
  //       } else {
  //         profileFile = file;
  //       }
  //     }
  //   }
  // }

  void removePhoto() {
    startStopLoading(true);
    fileName = '';
    file = null;
    if (type == Type.aadharBack) {
      isAadharBackDone = false;
      aadharBackFile = null;
    } else if (type == Type.aadhar) {
      isAadharDone = false;
      aadharFile = null;
    } else if (type == Type.pan) {
      isPanDone = false;
      panFile = null;
    } else if (type == Type.bankStatement) {
      isBankStatementDone = false;
      bankStatementFile = null;
    } else if (type == Type.ugCertificate) {
      isUgCertificateDone = false;
      ugCertificateFile = null;
    } else if (type == Type.pgCertificate) {
      isPgCertificateDone = false;
      pgCertificateFile = null;
    } else if (type == Type.bankCheque) {
      isBankChequeDone = false;
      bankChequeFile = null;
    } else if (type == Type.resume) {
      isResumeDone = false;
      resumeFile = null;
    } else {
      isProfileDone = false;
      profileFile = null;
    }
    startStopLoading(false);
  }

  Future uploadDocument() async {
    startStopLoading(true);
  }

  // Future uploadDocument() async {
  //   startStopLoading(true);
  //   if (type != null) {
  //     String stringType = '';
  //     switch (type) {
  //       case Type.aadhar:
  //         stringType = 'AadharCardFront';
  //         break;
  //       case Type.aadharBack:
  //         stringType = 'AadharCardBack';
  //         break;
  //       case Type.pan:
  //         stringType = 'PanCard';
  //         break;
  //       case Type.profile:
  //         stringType = 'ProfilePicture';
  //         break;
  //       case Type.bankStatement:
  //         stringType = 'BankStatement';
  //         break;
  //       case Type.ugCertificate:
  //         stringType = 'UgCertificate';
  //         break;
  //       case Type.pgCertificate:
  //         stringType = 'PgCertificate';
  //         break;
  //       case Type.bankCheque:
  //         stringType = 'BankCheque';
  //         break;
  //       case Type.resume:
  //         stringType = 'Resume';
  //         break;
  //       default:
  //         return;
  //     }
  //     var result = await apiRepo.uploadProof(filePath, stringType, phoneNumberCont.text);

  //     if (result) {
  //       if (type == Type.aadharBack) {
  //         isAadharBackDone = true;
  //       } else if (type == Type.aadhar) {
  //         isAadharDone = true;
  //       } else if (type == Type.pan) {
  //         isPanDone = true;
  //       } else if (type == Type.bankStatement) {
  //         isBankStatementDone = true;
  //       } else if (type == Type.ugCertificate) {
  //         isUgCertificateDone = true;
  //       } else if (type == Type.pgCertificate) {
  //         isPgCertificateDone = true;
  //       } else if (type == Type.bankCheque) {
  //         isBankChequeDone = true;
  //       } else if (type == Type.resume) {
  //         isResumeDone = true;
  //       } else {
  //         isProfileDone = true;
  //       }

  //       file = null;
  //       filePath = '';
  //       fileName = '';

  //       startStopLoading(false);

  //     } else {
  //       toast('Unable to upload');
  //       startStopLoading(false);
  //     }

  //     return;
  //   }
  //   startStopLoading(false);
  //   return;
  // }

  void startStopLoading(bool isLoading) {
    if (type == Type.aadharBack) {
      isAadharBackLoading = isLoading;
    } else if (type == Type.aadhar) {
      isAadharLoading = isLoading;
    } else if (type == Type.pan) {
      isPanLoading = isLoading;
    } else if (type == Type.bankStatement) {
      isBankStatementLoading = isLoading;
    } else if (type == Type.ugCertificate) {
      isUgCertificateLoading = isLoading;
    } else if (type == Type.pgCertificate) {
      isPgCertificateLoading = isLoading;
    } else if (type == Type.bankCheque) {
      isBankChequeLoading = isLoading;
    } else if (type == Type.resume) {
      isResumeLoading = isLoading;
    } else {
      isProfileLoading = isLoading;
    }
  }

  // Future<bool> registerUser() async {
  //   isLoading = true;
  //   Map req = {
  //   "gender": selectedGender,
  //   "userName": phoneNumberCont.text,
  //   "fullName": fullNameCont.text,
  //   "address": addressCont.text,
  //   "mobileNumber": phoneNumberCont.text,
  //   "emailId": emailCont.text,
  //   "dob": dobCont.text,
  //   "maritalStatus": selectedMaritalStatus,
  //   "bloodGroup": selectedBloodGroup,
  //   "relationName": relationCont.text,
  //   "designation": designationCont.text,
  //   "workLocation": workLocationCont.text,
  //   "workEmail": workEmailIdCont.text,
  //   "workMobileNumber": workMobileNumberCont.text,
  //   "dateOfJoining": joiningDateCont.text,
  //   "salary": salaryCont.text,
  //   "pfNumber": uanNumberCont.text,
  //   "bankName": bankNameCont.text,
  //   "accountNumber": accountNumberCont.text,
  //   "ifscCode": ifscCodeCont.text,
  //   "branchName": branchNameCont.text,
  //   "bankMobileNumber": bankMobileNumberCont.text,
  //   "emergencyContactName": emergenryContactNameCont.text,
  //   "emergencyContactNumber": emergenryContactMobileNumberCont.text,
  //   "emergencyContactRelation": emergenryContactRelationCont.text,
  //   "emergencyContactAddress": emergenryContactAddressCont.text
  //   };

  //   var result = await apiRepo.registerUser(req);

  //   isLoading = false;
  //   return result;
  // }
}

class PhoneNumberError = PhoneNumberErrorState with _$PhoneNumberError;

abstract class PhoneNumberErrorState with Store {
  @observable
  String? phoneNumber;

  @computed
  bool get hasErrors => phoneNumber != null;
}

enum Type {
  aadhar,
  aadharBack,
  pan,
  profile,
  bankStatement,
  ugCertificate,
  pgCertificate,
  bankCheque,
  resume
}
