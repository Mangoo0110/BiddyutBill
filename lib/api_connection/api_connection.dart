class API {
  static const hostConnection = "http://localhost/biddyutBill";
  static const hostConnectUser = "$hostConnection/user";
  static const hostConnectAdmin = "$hostConnection/admin";

  static const adminAuth = "admin_auth_sql";
  static const userSql = "user_sql";
  static const montlyRecordSql = "montly_record_sql";
  static const houseSql = "house_sql";
  static const unitCostSql = "unit_cost_sql";
  static const demandChargeVatSql = "demand_charge_vat_sql";
  static const userAuth = "user_auth_sql";

  static const adminLogIn = "$hostConnectAdmin/$adminAuth/admin_login.php";
  static const sendAdminEmailVerificationOTP= "$hostConnectAdmin/$adminAuth/admin_send_email_verification_otp.php";
  static const adminVerifyEmailOTP = "$hostConnectAdmin/$adminAuth/admin_verify_email_otp.php";
  static const verifyAdminOTP = "$hostConnectUser/$adminAuth/admin_verify_OTP.php";
  static const sendAdminOTP = "$hostConnectAdmin/$adminAuth/admin_send_otp.php";

  static const addOrUpdateHouse = "$hostConnectAdmin/$houseSql/add_or_update_house.php";
  static const deleteHouse = "$hostConnectAdmin/$houseSql/delete_a_house.php";
  static const fetchAllHouses =
      "$hostConnectAdmin/$houseSql/fetch_all_houses.php";
  static const fetchHouse =
      "$hostConnectAdmin/$houseSql/fetch_house.php";
      
  static const addOrUpdateUser = "$hostConnectAdmin/$userSql/add_or_update_user.php";
  static const deleteUser = "$hostConnectAdmin/$userSql/delete_a_user.php";
  static const fetchAllUsers = "$hostConnectAdmin/$userSql/fetch_all_user.php";
  static const fetchOneUser = "$hostConnectAdmin/$userSql/fetch_user.php";
  static const newMonthRecord = "$hostConnectAdmin/montly_record_sql/new_month_record.php";
  static const fetchMonthRecord = "$hostConnectAdmin/montly_record_sql/fetch_month_record.php";
  static const fetchMonthAllRecord = "$hostConnectAdmin/montly_record_sql/fetch_month_all_record.php";
  static const fetcUserMonthlyRecord = "$hostConnectAdmin/montly_record_sql/fetch_month_record_as_user.php";

  static const onlineEmailjsApi = "https://api.emailjs.com/api/v1.0/email/send";

  static const fetchAllUnitCost = "$hostConnectAdmin/$unitCostSql/fetch_unit_cost.php";
  static const fetchDemandChargeVatPercentage= "$hostConnectAdmin/$demandChargeVatSql/fetch_demand_charge_vat.php";
  static const updateAllUnitCost =
      "$hostConnectAdmin/$unitCostSql/update_unit_range_cost.php";
  static const updateDemandChargeVatPercentage =
      "$hostConnectAdmin/$demandChargeVatSql/update_demand_charge_vat_percentage.php";
  static const addNewUnitRangeWithCost = "$hostConnectAdmin/$unitCostSql/add_new_unit_range_cost.php";
  static const deleteUnitRangeWithCost = "$hostConnectAdmin/$unitCostSql/delete_unit_range_cost.php";

  static const appUserLogIn = "$hostConnectUser/$userAuth/user_login.php";
  static const verifyUserEmail = "$hostConnectUser/$userAuth/user_verify_email.php";
  static const sendUserEmailVerificationOTP = "$hostConnectUser/$userAuth/user_send_email_verification_otp.php";
  static const verifyUserOTP = "$hostConnectUser/$userAuth/user_verify_OTP.php";
  static const sendUserOTP = "$hostConnectUser/$userAuth/user_send_otp.php";
}
// verify_email_verification_code