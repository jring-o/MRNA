/**
 * MIRA Travel Logistics Email Sender
 *
 * Setup:
 * 1. Import "MIRA Flight Budgets.csv" into Google Sheets
 * 2. Open Extensions > Apps Script
 * 3. Paste this script and click Run > sendEmails
 * 4. Authorize when prompted
 *
 * The script reads from the active sheet and expects columns:
 * A: Name, B: Last Name, C: Location, D: Low, E: High, F: email, G: body (HTML)
 */

function sendEmails() {
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
  var data = sheet.getDataRange().getValues();
  var subject = "MIRA Travel Logistics \u2014 June 7th, Dublin";
  var cc = "ellie@scios.tech,matt.akamatsu@gmail.com";

  var sentCount = 0;
  var errorCount = 0;

  // Start from row 2 (skip header)
  for (var i = 1; i < data.length; i++) {
    var name = data[i][0];
    var email = data[i][5];
    var htmlBody = data[i][6];

    // Skip empty rows
    if (!name || !email || !htmlBody) continue;

    try {
      GmailApp.sendEmail(email, subject, "", {
        htmlBody: htmlBody,
        cc: cc
      });
      Logger.log("Sent to: " + name + " (" + email + ")");
      sentCount++;
    } catch (e) {
      Logger.log("ERROR sending to " + name + " (" + email + "): " + e.message);
      errorCount++;
    }
  }

  Logger.log("\n--- Summary ---");
  Logger.log("Sent: " + sentCount);
  Logger.log("Errors: " + errorCount);

  SpreadsheetApp.getUi().alert(
    "Email Summary\n\nSent: " + sentCount + "\nErrors: " + errorCount
  );
}

/**
 * Optional: Send a test email to yourself first
 */
function sendTestEmail() {
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
  var data = sheet.getDataRange().getValues();
  var subject = "[TEST] MIRA Travel Logistics \u2014 June 7th, Dublin";
  var myEmail = Session.getActiveUser().getEmail();

  // Send first participant's email to yourself as a test
  var htmlBody = data[1][6];

  GmailApp.sendEmail(myEmail, subject, "", {
    htmlBody: htmlBody
  });

  SpreadsheetApp.getUi().alert("Test email sent to " + myEmail);
}
