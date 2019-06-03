library my_prj.globals;

const meridiumBlue = 0xFF09384E;
const meridiumRed = 0xFFDC3E2A;

bool showSuportView = false;

int backToHomeScreenTimer = 4;

int timeToShowReception = 60;

String url = "https://169fddfd.ngrok.io";

String visitorOption1 = "Leverans";

String visitorOption2 = "Besökare";

String visitorOption3 = "Affärspartner";

String visitorOption4 = "Anställd";

String welcomeText = "Välkommen!";

String whoAreYou = "Vem är du?";

String whoAreYouLookingFor = "Vem söker du ?";

String unknown = "Jag vet inte vem jag söker";

String lastMessage = "Ring växel 0724340454";

String cancelText = "Avbryt";

String somethingWentWrong = "Något gick fel!";

String tryAgain = "Försök igen";

const String emptyString = "";

const String defaultImage =
    "https://media.licdn.com/dms/image/C4D0BAQEFDQEvVnNIFQ/company-logo_200_200/0?e=2159024400&v=beta&t=rbi_4pyBeBBlPqqQaWMHUWOE9Q0vwIZV2iN_RS5fOWA";

const String defaultMessage = "någon på Meridium";

buildMessage(String name) {
  return "Vi kontaktar $name";
}
