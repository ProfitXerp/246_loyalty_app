// class UserDataService {
//   Future<Map<String, String>> loadUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     return {
//       'userName': prefs.getString('user_name') ?? 'User',
//       'userAddress': prefs.getString('user_address') ?? 'Address',
//       'userPoints': prefs.getString('user_total_points') ?? 'error user points',
//       'userPhone': prefs.getString('user_phone') ?? 'error user phone number',
//     };
//   }
// }
