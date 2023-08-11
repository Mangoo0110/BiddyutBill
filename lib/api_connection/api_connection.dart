class API {
  static const hostConnection = "http://127.0.0.1/biddyutBill";
  static const hostConnectUser = "$hostConnection/user";
  static const hostConnectAdmin = "$hostConnection/admin";
  static const signUp = "$hostConnectUser/signUp.php";
  static const adminLogIn = "$hostConnectAdmin/adminLogIn.php";
  static const addHouse = "$hostConnectAdmin/addHouse.php";
  static const fetchAllHouses = "$hostConnectAdmin/fetchAllHouses.php";
  static const addUser = "$hostConnectAdmin/addUser.php";
  static const userList = "$hostConnectAdmin/userList.php";
}
