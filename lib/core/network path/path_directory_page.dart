class PathDirectoryUrls {
  static const String _baseURL = 'https://task.teamrabbil.com/api/v1';

  static const String registrationUrl = "$_baseURL/registration";
  static const String loginUrl = "$_baseURL/login";
  static const String createTaskUrl = "$_baseURL/createTask";
  static const String profileUpdateUrl = "$_baseURL/profileUpdate";
  static const String recoverResetPasswordUrl = "$_baseURL/RecoverResetPass";
  static const String taskStatusCountUrl = "$_baseURL/taskStatusCount";

  static  String updateTaskStatusUrl(String id,String status) => "$_baseURL/updateTaskStatus/$id/$status";

  static  String deleteTaskUrl(String id) => "$_baseURL/deleteTask/$id";

  static String listTaskByStatusUrl(String status) => "$_baseURL/listTaskByStatus/$status";

  static  String recoverVerifyEmailUrl(String emailStatus) => "$_baseURL/RecoverVerifyEmail/$emailStatus";
  static  String recoverEmailOTPUrl(String emailStatus,String otp ) => "$_baseURL/RecoverVerifyOTP/$emailStatus/$otp";
}
