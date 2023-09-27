class API {
  static const hostConnection = "http://localhost/biddyutBill";
  static const hostConnectUser = "$hostConnection/user";
  static const hostConnectAdmin = "$hostConnection/admin";

  static const authentication = "authentication";
  static const userSql = "user_sql";
  static const montlyRecordSql = "montly_record_sql";
  static const houseSql = "house_sql";
  static const unitCostSql = "unit_cost_sql";
  static const demandChargeVatSql = "demand_charge_vat_sql";

  static const userAuthenticationSql = "authentication_sql";

  static const adminLogIn = "$hostConnectAdmin/$authentication/admin_login.php";
  static const adminAskRecoveryCode= "$hostConnectAdmin/$authentication/admin_send_recovery_code.php";
  static const adminValidateRecoveryCode = "$hostConnectAdmin/$authentication/admin_validate_recovery_code.php";
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
  static const fetchAllUnitCost = "$hostConnectAdmin/$unitCostSql/fetch_unit_cost.php";
  static const fetchDemandChargeVatPercentage= "$hostConnectAdmin/$demandChargeVatSql/fetch_demand_charge_vat.php";
  static const onlineEmailjsApi = "https://api.emailjs.com/api/v1.0/email/send";

  static const updateAllUnitCost =
      "$hostConnectAdmin/$unitCostSql/update_unit_range_cost.php";
  static const updateDemandChargeVatPercentage =
      "$hostConnectAdmin/$demandChargeVatSql/update_demand_charge_vat_percentage.php";

  static const appUserLogIn = "$hostConnectUser/$userAuthenticationSql/user_login.php";    
  static const verifyUserEmail = "$hostConnectUser/$userAuthenticationSql/user_verify_email.php";
  static const sendUserEmailVerificationOTP = "$hostConnectUser/$userAuthenticationSql/user_send_email_verification_otp.php";
  static const verifyUserOTP = "$hostConnectUser/$userAuthenticationSql/user_verify_OTP.php";
  static const sendUserOTP = "$hostConnectUser/$userAuthenticationSql/user_send_otp.php";
}
// verify_email_verification_code