codeunit 50144 "Form Email Management"
{
    procedure SendFormEmail(MemberApp: Record "Member Application"; EmailType: Enum "Application Status")
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Recipient: List of [Text];
        Subject: Text;
        Body: Text;
    begin
        if MemberApp.Email = '' then
            Error('No email address has been provided for this application.');

        Recipient.Add(MemberApp.Email);

        case EmailType of
            "Application Status"::Pending:
                begin
                    Subject := 'Your Application Has Been Submitted for Approval';
                    Body :=
                      'Dear ' + MemberApp."First Name" + ' ' + MemberApp."Last Name" + ',<br><br>' +
                      'Thank you for submitting your member application. Your application is now pending review and approval.<br><br>' +
                      '<strong>Application Details:</strong><br>' +
                      'Application ID: ' + MemberApp."Application ID" + '<br>' +
                      'Application Date: ' + Format(MemberApp."Application Date") + '<br><br>' +
                      'We will review your application and notify you of the outcome shortly.<br><br>' +
                      'Best regards,<br>' +
                      'Member Services Team';
                end;

            EmailType::Approved:
                begin
                    Subject := 'Your Application Has Been Approved';
                    Body :=
                      'Dear ' + MemberApp."First Name" + ' ' + MemberApp."Last Name" + ',<br><br>' +
                      'Congratulations! Your member application has been approved.<br><br>' +
                      '<strong>Application Details:</strong><br>' +
                      'Application ID: ' + MemberApp."Application ID" + '<br>' +
                      'Approval Date: ' + Format(MemberApp."Approval Date") + '<br><br>' +
                      'Your membership is now active. Thank you for joining us!<br><br>' +
                      'Best regards,<br>' +
                      'Member Services Team';
                end;

            EmailType::Rejected:
                begin
                    Subject := 'Your Application Has Been Rejected';
                    Body :=
                      'Dear ' + MemberApp."First Name" + ' ' + MemberApp."Last Name" + ',<br><br>' +
                      'Thank you for submitting your member application. Unfortunately, your application has been rejected.<br><br>' +
                      '<strong>Application Details:</strong><br>' +
                      'Application ID: ' + MemberApp."Application ID" + '<br>' +
                      'Rejection Reason: ' + MemberApp."Rejection Reason" + '<br><br>' +
                      'If you have any questions or would like to reapply, please contact us.<br><br>' +
                      'Best regards,<br>' +
                      'Member Services Team';
                end;
        end;

        EmailMessage.Create(
            Recipient,
            Subject,
            Body,
            true);

        Email.Send(EmailMessage);
    end;
}
