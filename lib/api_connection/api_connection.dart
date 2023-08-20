class API {
  static const authentication = "authentication";
  static const userSql = "user_sql";
  static const montlyRecordSql = "montly_record_sql";
  static const houseSql = "house_sql";
  static const unitCostSql = "unitCost_sql";
  static const demandChargeVatSql = "demandChargeVat_sql";
  
  static const hostConnection = "http://127.0.0.1/biddyutBill";
  static const hostConnectUser = "$hostConnection/user";
  static const hostConnectAdmin = "$hostConnection/admin";
  static const adminLogIn = "$hostConnectAdmin/$authentication/adminLogIn.php";
  static const addHouse = "$hostConnectAdmin/$houseSql/addHouse.php";
  static const fetchAllHouses = "$hostConnectAdmin/$houseSql/fetchAllHouses.php";
  static const addUser = "$hostConnectAdmin/$userSql/addUser.php";
  static const userList = "$hostConnectAdmin/$userSql/userList.php";
  static const fetchOneUser = "$hostConnectAdmin/$userSql/fetchUser.php";
  static const newMonthRecord = "$hostConnectAdmin/montly_record_sql/newMonthRecord.php";
  static const fetchMonthRecord = "$hostConnectAdmin/montly_record_sql/fetchMonthRecord.php";
  static const fetchAllUnitCostAndOther = "$hostConnectAdmin/$unitCostSql/fetchUnitCostAndOther.php";
  static const fetchDemandChargeVatPercentage= "$hostConnectAdmin/$demandChargeVatSql/fetchDemandCharge.php";
  static const onlineEmailjsApi = "https://api.emailjs.com/api/v1.0/email/send";
}
