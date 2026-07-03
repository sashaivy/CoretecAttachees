codeunit 50128 "Member Application Email"
{
    trigger OnRun()
    begin

    end;
    //Called when application is approved to send email to the member
    procedure SendApprovalEmail(MemberApplication: Record "Member Application")
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit "Email";
        Subject: Text;
        Body: Text;
    begin
        //validate application has an email
        if MemberApplication.Email = '' then
            Error('Member application does not have an email address to send approval email.');

        //validate status is actually approved
        if MemberApplication.Status <> MemberApplication.Status::Approved then
            Error('Member application is not approved. Cannot send approval email.');

        //build the subject line
        Subject := BuildApprovalSubject(MemberApplication);

        //Build the email body
        Body := BuildApprovalBody(MemberApplication);

        // STEP 5: Create the email message object
        EmailMessage.Create(
            MemberApplication.Email,  // To
            Subject,                  // Subject
            Body,                     // Body
            true                      // true = Body is HTML formatted
        );

        // STEP 6: Send and handle failure gracefully
        // If Send returns FALSE it means email failed
        // We warn the admin but do NOT crash the approval itself
        if Email.Send(EmailMessage) then
            Message('Approval email successfully sent to %1', MemberApplication.Email)
        else
            Message(
                'Application approved successfully.\' +
                'However the email could not be sent to %1.\' +
                'Please check your Email Setup in Business Central.',
                MemberApplication.Email
            );
    end;

    local procedure BuildApprovalSubject(MemberApplication: Record "Member Application"): Text
    begin
        // StrSubstNo inserts the Application ID into the subject
        // %1 is a placeholder that gets replaced by the second parameter
        exit(StrSubstNo('Membership Application %1 - Approved', MemberApplication."Application ID"));
    end;

    local procedure BuildApprovalBody(MemberApplication: Record "Member Application"): Text
    var
        Body: TextBuilder;
    // TextBuilder is a special AL tool for building long strings
    // piece by piece using .Append()
    // Much better than joining strings with + signs
    begin
        // ── HTML OPENING ──
        Body.Append('<!DOCTYPE html>');
        Body.Append('<html>');
        Body.Append('<body style="font-family: Arial, sans-serif; color: #333333; margin: 0; padding: 0;">');

        // ── TOP BANNER (Green for approval) ──
        Body.Append('<div style="background-color: #1E7145; padding: 25px;">');
        Body.Append('<h1 style="color: #ffffff; margin: 0; font-size: 24px;">');
        Body.Append('Membership Application Approved');
        Body.Append('</h1>');
        Body.Append('</div>');

        // ── MAIN BODY AREA ──
        Body.Append('<div style="padding: 30px;">');

        // Greeting — uses the applicant's actual name from the record
        Body.Append('<p style="font-size: 16px;">Dear ');
        Body.Append(MemberApplication."First Name");
        Body.Append(' ');
        Body.Append(MemberApplication."last Name");
        Body.Append(',</p>');

        // Opening paragraph
        Body.Append('<p>We are pleased to inform you that your membership ');
        Body.Append('application has been ');
        Body.Append('<strong style="color: #1E7145;">APPROVED</strong>.');
        Body.Append('</p>');

        // ── DETAILS BOX ──
        Body.Append('<div style="background-color: #f0fff4; border-left: 5px solid #1E7145; ');
        Body.Append('padding: 20px; margin: 25px 0; border-radius: 4px;">');
        Body.Append('<h3 style="margin-top: 0; color: #1E7145;">Application Details</h3>');

        // Details table
        Body.Append('<table style="width: 100%; border-collapse: collapse;">');

        // Row 1: Application ID
        Body.Append('<tr>');
        Body.Append('<td style="padding: 10px; font-weight: bold; width: 40%; ');
        Body.Append('border-bottom: 1px solid #c3e6cb;">Application ID:</td>');
        Body.Append('<td style="padding: 10px; border-bottom: 1px solid #c3e6cb;">');
        Body.Append(MemberApplication."Application ID");
        Body.Append('</td></tr>');

        // Row 2: Full Name
        Body.Append('<tr style="background-color: #e8f5e9;">');
        Body.Append('<td style="padding: 10px; font-weight: bold; ');
        Body.Append('border-bottom: 1px solid #c3e6cb;">Full Name:</td>');
        Body.Append('<td style="padding: 10px; border-bottom: 1px solid #c3e6cb;">');
        Body.Append(MemberApplication."First Name");
        Body.Append(' ');
        Body.Append(MemberApplication."last Name");
        Body.Append('</td></tr>');

        // Row 3: Member Category
        // Format() converts the Enum value to readable text
        Body.Append('<tr>');
        Body.Append('<td style="padding: 10px; font-weight: bold; ');
        Body.Append('border-bottom: 1px solid #c3e6cb;">Member Category:</td>');
        Body.Append('<td style="padding: 10px; border-bottom: 1px solid #c3e6cb;">');
        Body.Append(Format(MemberApplication."Member Category"));
        Body.Append('</td></tr>');

        // Row 4: Approval Date
        // Format() converts the Date value to readable text
        Body.Append('<tr style="background-color: #e8f5e9;">');
        Body.Append('<td style="padding: 10px; font-weight: bold;">Approval Date:</td>');
        Body.Append('<td style="padding: 10px;">');
        Body.Append(Format(MemberApplication."Approval Date"));
        Body.Append('</td></tr>');

        Body.Append('</table>');
        Body.Append('</div>');

        // ── NEXT STEPS ──
        Body.Append('<p><strong>What happens next?</strong></p>');
        Body.Append('<ul style="line-height: 2;">');
        Body.Append('<li>Your membership record has been created in our system.</li>');
        Body.Append('<li>Your membership details will be shared with you shortly.</li>');
        Body.Append('<li>Feel free to contact us if you have any questions.</li>');
        Body.Append('</ul>');

        // ── CLOSING ──
        Body.Append('<p>Welcome aboard!</p>');
        Body.Append('<p>Kind regards,<br/>');
        Body.Append('<strong>The Membership Team</strong></p>');
        Body.Append('</div>');

        // ── FOOTER ──
        Body.Append('<div style="background-color: #f5f5f5; padding: 15px; ');
        Body.Append('font-size: 12px; color: #888888; text-align: center;">');
        Body.Append('<p style="margin: 0;">This is an automated message. ');
        Body.Append('Please do not reply directly to this email.</p>');
        Body.Append('</div>');

        Body.Append('</body>');
        Body.Append('</html>');

        // ToText() converts the TextBuilder into a plain Text value
        exit(Body.ToText());
    end;

    //Called when application is rejected
    procedure SendRejectionEmail(MemberApplication: Record "Member Application")
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit "Email";
        Subject: Text;
        Body: Text;
    begin
        //validate the email exists
        if MemberApplication.Email = '' then
            Error('Member application does not have an email address to send rejection email.');

        //validate status is actually rejected
        if MemberApplication.Status <> MemberApplication.Status::Rejected then
            Error('Member application is not rejected. Cannot send rejection email.');

        //build the subject line
        Subject := BuildRejectionSubject(MemberApplication);

        //Build the email body
        Body := BuildRejectionBody(MemberApplication);

        // STEP 5: Create the email message object
        EmailMessage.Create(
            MemberApplication.Email,  // To
            Subject,                  // Subject
            Body,                     // Body
            true                      // true = Body is HTML formatted
        );

        // STEP 6: Send and handle failure gracefully
        if Email.Send(EmailMessage) then
            Message('Rejection email successfully sent to %1', MemberApplication.Email)
        else
            Message(
                'Application rejected successfully.\' +
                'However the email could not be sent to %1.\' +
                'Please check your Email Setup in Business Central.',
                MemberApplication.Email
            );
    end;

    local procedure BuildRejectionSubject(MemberApplication: Record "Member Application"): Text
    begin
        // StrSubstNo inserts the Application ID into the subject
        // %1 is a placeholder that gets replaced by the second parameter
        exit(StrSubstNo('Membership Application %1 - Rejected', MemberApplication."Application ID"));
    end;

    local procedure BuildRejectionBody(MemberApplication: Record "Member Application"): Text
    var
        Body: TextBuilder;
    begin
        // ── HTML OPENING ──
        Body.Append('<!DOCTYPE html>');
        Body.Append('<html>');
        Body.Append('<body style="font-family: Arial, sans-serif; color: #333333; margin: 0; padding: 0;">');

        // ── TOP BANNER (Red for rejection) ──
        Body.Append('<div style="background-color: #C0392B; padding: 25px;">');
        Body.Append('<h1 style="color: #ffffff; margin: 0; font-size: 24px;">');
        Body.Append('Membership Application Status Update');
        Body.Append('</h1>');
        Body.Append('</div>');

        // ── MAIN BODY AREA ──
        Body.Append('<div style="padding: 30px;">');

        // Greeting
        Body.Append('<p style="font-size: 16px;">Dear ');
        Body.Append(MemberApplication."First Name");
        Body.Append(' ');
        Body.Append(MemberApplication."last Name");
        Body.Append(',</p>');

        // Opening paragraph
        Body.Append('<p>Thank you for your interest in our membership programme. ');
        Body.Append('After careful review, we regret to inform you that your ');
        Body.Append('application has been ');
        Body.Append('<strong style="color: #C0392B;">UNSUCCESSFUL</strong> ');
        Body.Append('at this time.</p>');

        // ── DETAILS BOX ──
        Body.Append('<div style="background-color: #fff5f5; border-left: 5px solid #C0392B; ');
        Body.Append('padding: 20px; margin: 25px 0; border-radius: 4px;">');
        Body.Append('<h3 style="margin-top: 0; color: #C0392B;">Application Details</h3>');

        Body.Append('<table style="width: 100%; border-collapse: collapse;">');

        // Row 1: Application ID
        Body.Append('<tr>');
        Body.Append('<td style="padding: 10px; font-weight: bold; width: 40%; ');
        Body.Append('border-bottom: 1px solid #f5c6cb;">Application ID:</td>');
        Body.Append('<td style="padding: 10px; border-bottom: 1px solid #f5c6cb;">');
        Body.Append(MemberApplication."Application ID");
        Body.Append('</td></tr>');

        // Row 2: Full Name
        Body.Append('<tr style="background-color: #fce8e8;">');
        Body.Append('<td style="padding: 10px; font-weight: bold; ');
        Body.Append('border-bottom: 1px solid #f5c6cb;">Full Name:</td>');
        Body.Append('<td style="padding: 10px; border-bottom: 1px solid #f5c6cb;">');
        Body.Append(MemberApplication."First Name");
        Body.Append(' ');
        Body.Append(MemberApplication."last Name");
        Body.Append('</td></tr>');

        // Row 3: Rejection Reason
        // Only shows if the admin actually filled in a reason
        if MemberApplication."Rejection Reason" <> '' then begin
            Body.Append('<tr>');
            Body.Append('<td style="padding: 10px; font-weight: bold;">Reason:</td>');
            Body.Append('<td style="padding: 10px;">');
            Body.Append(MemberApplication."Rejection Reason");
            Body.Append('</td></tr>');
        end;

        Body.Append('</table>');
        Body.Append('</div>');

        // ── ENCOURAGEMENT ──
        Body.Append('<p>You are welcome to reapply in the future once ');
        Body.Append('you have addressed the above.</p>');
        Body.Append('<p>If you require further clarification, ');
        Body.Append('please do not hesitate to contact us.</p>');

        // ── CLOSING ──
        Body.Append('<p>Kind regards,<br/>');
        Body.Append('<strong>The Membership Team</strong></p>');
        Body.Append('</div>');

        // ── FOOTER ──
        Body.Append('<div style="background-color: #f5f5f5; padding: 15px; ');
        Body.Append('font-size: 12px; color: #888888; text-align: center;">');
        Body.Append('<p style="margin: 0;">This is an automated message. ');
        Body.Append('Please do not reply directly to this email.</p>');
        Body.Append('</div>');

        Body.Append('</body>');
        Body.Append('</html>');

        exit(Body.ToText());
    end;

}