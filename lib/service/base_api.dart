class BaseAPI{
  Map<String,String> headers = {"Accept" : "application/json"};
  static String base = "https://www.dinarkoom.com/api";
  var loginPath = base + "/login?";
  var registrationPath = base + "/registration?";
  var logoutPath = base + "/logout?";
  var adsPath = base + "/allImages";
  var digitalPhotoPath = base + "/dataSelling";
  var winnersPath = base + "/winners";
  var aboutPath = base + "/getAbout?";
  var paymentPath = base + '/knet?';
  var paymentCheckPath = base + '/checkUserPay?';
  var updateUserPath = base + '/updateProfile?';
  var addRelativePath = base + '/AddRelUser?';
  var getRelativesPath = base + '/getRelUser?';
  var updateRelativePath = base + '/updateRelative?';
  var resetPassword = base + '/sendMail?';
  var getUserById = base + '/getUserById?';
  var purchase = base + '/purchase?';
  var contact = base + '/contact';
}