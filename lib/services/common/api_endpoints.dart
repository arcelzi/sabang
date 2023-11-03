const String baseAuthUrl = "http://192.168.102.182:3001";



//auth
String loginUrl() => "$baseAuthUrl/auth/login";
String getProfileUrl() => "$baseAuthUrl/auth/profile";
String changeProfileUrl() => "$baseAuthUrl/auth/profile";
String changeProfilePictureUrl() => "$baseAuthUrl/auth/profile";
String logoutUrl() => "$baseAuthUrl/auth/logout";

//users
String getTappers() => "$baseAuthUrl/users/penyadap";

//nira
String getPurchase() => "$baseAuthUrl/purchases";
String addNira() => "$baseAuthUrl/purchases";

//garden control
String getGardenControl() => "$baseAuthUrl/garden-controls";
String addGardenControl() => "$baseAuthUrl/garden-controls";

