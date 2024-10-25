class APIRoutes {
  //local
  // static const ip = 'http://192.168.0.105:44317/';

  static const ip = 'https://app.orbitcables.com:62/';

  //Dev
  static const baseURL = "${ip}api/v1/";

  static const rtcStatusUpdateURL = 'http://192.168.0.190:44313/Device';

  static const getPayslipURL = '${baseURL}payslip/getPayslip';

  static const profileURL = '${baseURL}UserProfiles/';

  static const loginURL = '${baseURL}login';

  static const forgotPasswordURL = '${baseURL}forgotPassword';

  static const verifyOTPURL = '${baseURL}verifyOTP';

  static const phoneNumberCheckURL = "${baseURL}checkPhoneNumber";

  static const userNameCheckURL = "${baseURL}checkUsername";

  static const getScheduleURL = '${baseURL}getSchedule';

  static const addMessagingTokenURL = '${baseURL}messagingToken';

  //Dashboard
  static const getDashboardData = '${baseURL}getDashboardData';

  //Sales
  static const getSalesEntriesUrl = '${baseURL}sales/getAll';
  static const createSalesEntry = '${baseURL}sales/create';

  //Leave
  static const getLeaveTypesURL = '${baseURL}getLeaveTypes';
  static const addLeaveRequest = '${baseURL}createLeaveRequest';
  static const uploadLeaveDocument = '${baseURL}uploadLeaveDocument';
  static const getLeaveRequests = '${baseURL}getLeaveRequests';
  static const deleteLeaveRequest = '${baseURL}deleteLeaveRequest';

  //Device
  static const checkDevice = '${baseURL}checkDevice';
  static const registerDevice = '${baseURL}registerDevice';
  static const updateDeviceStatus = '${baseURL}updateDeviceStatus';

  //Attendance
  static const checkInOut = '${baseURL}attendance/checkInOut';
  static const updateAttendanceStatus = '${baseURL}attendance/statusUpdate';
  static const checkAttendanceStatus = '${baseURL}attendance/checkStatus';
  static const getAttendanceHistory =
      '${baseURL}attendance/getAttendanceHistory';

  //Chat
  static const postChat = '${baseURL}chat/postChat';
  static const postImgChat = '${baseURL}chat/postImgChat';
  static const getChats = '${baseURL}chat/getChats';

  //Expense
  static const getExpenseTypes = '${baseURL}expense/getExpenseTypes';
  static const addExpenseRequest = '${baseURL}expense/createExpenseRequest';
  static const deleteExpenseRequest = '${baseURL}expense/deleteExpenseRequest';
  static const getExpenseRequest = '${baseURL}expense/getExpenseRequests';
  static const uploadExpenseDocument =
      '${baseURL}expense/uploadExpenseDocument';
  static const getDistanceTravelled = '${baseURL}expense/getDistanceTravelled';

  //Client
  static const getClients = '${baseURL}client/getAllClients';

  static const clientsSearch = '${baseURL}client/search';

  static const addClient = '${baseURL}client/create';

  //Distributors

  static const getDistributors = '${baseURL}distributor/getAll';

  static const distributorSearch = '${baseURL}distributor/search';

  static const addDistributor = '${baseURL}distributor/create';

  //SignBoard
  static const addSignBoardRequest = '${baseURL}signBoard/createRequest';

  //Register
  static const uploadDocument = '${baseURL}register/uploadDocument';
  static const registerUser = '${baseURL}register/registerUser';
  static const checkPhoneNumber = '${baseURL}register/checkPhoneNumber';

  //Visit
  static const createVisit = '${baseURL}visit/createVisit';
  static const getAllVisits = '${baseURL}visit/getHystory';
  static const getVisitReport = '${baseURL}visit/getReport';
}
