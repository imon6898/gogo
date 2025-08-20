import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {

  //final String apiKey
  //BASE URL
  //final String baseUrl = dotenv.get('BASE_URL', fallback: ''); //https://api.mealdealfinder.com/api/v1
  static String baseUrl = dotenv.get('BASE_URL', fallback: ''); //https://api.mealdealfinder.com/api/v1
  static const String getAllRestrurentUri = "/restaurants/get-all";
  static const String loginUri = "/auth/login";
  static const String registrationUri = "/auth/register";



  //common data api end point
  static const String allBranches = "branches";
  static String getInstructors(String branchId, String type) => "instructors/$branchId?type=$type";
  static String postClassSlots(String type) => "class-slots?type=$type";
  static const String postBookClass = "class-booking";

  //END POINT
  static const String studentAllCourses = "courses";
  static const String studentAllStudentInstructors = "student/get-instructor";
  static const String studentLogin = "student-login";
  static const String firstStepApplicationUrl = "first-step-application-submission";
  static const String secondStepApplicationUrl = "second-step-application-submission";
  static const String thirdStepApplicationUrl = "third-step-application-submission";
  static const String studentLogout = "student/logout";
  static const String sendOtp = "password-reset-otp-send";
  static const String verifyOtpurl = "check-otp-verify";
  static const String newPassurl = "password-reset?mobile&otp&password";

  ///DashBoard
  static const String studentDashboard = "student/student-dashboard";
  static const String getstudentPayment = "student/payments";
  static const String studentCourses = "student/courses";
  static const String studentLicences = "student/licence";

  ///Profile
  static const String getUserProfileUrl = "profile";
  static String getUserPersonalInformation (String id)=> "student/profile-update/$id";
  static String getFirstStepApplicationData (String id)=> "first-step-application-data/$id";
  static String getSecondStepApplicationData (String id)=> "second-step-application-data/$id";
  static const String postUserProfileOtherInformation = "student/profile/other-info";
  static const String postUserProfileEmergencyContact = "student/profile/emergency-contact";
  static const String postUserProfilePresentAddress = "student/profile/present-address";
  static const String postUserProfilePermanentAddress = "student/profile/permanent-address";
  static const String postSecondStepApplicationSubmission = "second-step-application-submission";


  ///Menu
  static const String getLicenceUrl = "student/licence";
  static const String postInstructorFeedbackUrl = "student/instructor-feedback";
  static const String getNoticesBoard = "notices/published";


}
