class API {
  static const authentication = "authentication";
  static const userSql = "user_sql";
  static const montlyRecordSql = "montly_record_sql";
  static const houseSql = "house_sql";
  static const unitCostSql = "unit_cost_sql";
  static const demandChargeVatSql = "demand_charge_vat_sql";

  static const hostConnection = "http://localhost/biddyutBill";
  static const hostConnectUser = "$hostConnection/user";
  static const hostConnectAdmin = "$hostConnection/admin";
  static const adminLogIn = "$hostConnectAdmin/$authentication/admin_login.php";
  static const addOrUpdateHouse = "$hostConnectAdmin/$houseSql/add_or_update_house.php";
  static const deleteHouse = "$hostConnectAdmin/$houseSql/delete_a_house.php";
  static const fetchAllHouses =
      "$hostConnectAdmin/$houseSql/fetch_all_houses.php";
  static const addOrUpdateUser = "$hostConnectAdmin/$userSql/add_or_update_user.php";
  static const deleteUser = "$hostConnectAdmin/$userSql/delete_a_user.php";
  static const fetchAllUsers = "$hostConnectAdmin/$userSql/fetch_all_user.php";
  static const fetchOneUser = "$hostConnectAdmin/$userSql/fetch_user.php";
  static const newMonthRecord = "$hostConnectAdmin/montly_record_sql/new_month_record.php";
  static const fetchMonthRecord = "$hostConnectAdmin/montly_record_sql/fetch_month_record.php";
  static const fetchAllUnitCost = "$hostConnectAdmin/$unitCostSql/fetch_unit_cost.php";
  static const fetchDemandChargeVatPercentage= "$hostConnectAdmin/$demandChargeVatSql/fetch_demand_charge_vat.php";
  static const onlineEmailjsApi = "https://api.emailjs.com/api/v1.0/email/send";

  static const updateAllUnitCost =
      "$hostConnectAdmin/$unitCostSql/updateUnitCost.php";
  static const updateDemandChargeVatPercentage =
      "$hostConnectAdmin/$demandChargeVatSql/updateDemandChargeVatPercentage.php";
  
}
