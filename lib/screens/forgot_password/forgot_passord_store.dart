import 'package:mobx/mobx.dart';

part 'forgot_passord_store.g.dart';

class ForgotPasswordStore = ForgotPasswordStoreBase with _$ForgotPasswordStore;

abstract class ForgotPasswordStoreBase with Store {
  @observable
  Status status = Status.verified;

  @observable
  bool isLoading = false;

  @observable
  String? errorMsg;

  @observable
  String? phoneNumber;

  @observable
  String? otp;

  // @action
  // Future sendOTPToPhone() async {
  //   isLoading = true;

  //   if (phoneNumber!.length > 9) {
  //     var result = await apiRepo.forgotPassword(phoneNumber!);

  //     if (!result) {
  //       status = Status.start;
  //       toast('Unable to send an OTP, try again later');
  //     } else {
  //       status = Status.otp;
  //     }
  //   }
  //   isLoading = false;
  // }

  // @action
  // Future verifyOTP() async {
  //   isLoading = true;

  //   if (otp.isEmptyOrNull) {
  //     toast('OTP is required');
  //   }

  //   if (otp!.length == 4) {
  //     var result = await apiRepo.verifyOTP(phoneNumber!, otp!);
  //     if (!result) {
  //       status = Status.otp;
  //       toast('Wrong OTP');
  //     } else {
  //       status = Status.verified;
  //     }
  //   }

  //   isLoading = false;
  // }

  // void setupValidators() {
  //   reaction((_) => phoneNumber, validatePhoneNumber);
  // }

  // Future validatePhoneNumber(String? value) async {
  //   if (isNull(value) || value == '') {
  //     errorMsg = 'Cannot be blank';
  //     return;
  //   }

  //   if (value!.length > 9) {
  //     try {
  //       var phoneNumberCheck =
  //           ObservableFuture(apiRepo.checkValidPhoneNumber(value));
  //       final isValid = await phoneNumberCheck;
  //       if (!isValid) {
  //         errorMsg = 'Phone number not exists';
  //         return;
  //       }
  //       errorMsg = null;
  //     } on Object catch (_) {
  //       errorMsg = null;
  //       return;
  //     }
  //   }

  //   errorMsg = null;
  //   return;
  // }
}

enum Status { start, otp, verified }
