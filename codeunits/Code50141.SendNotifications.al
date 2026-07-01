codeunit 50141 SendNotifications
{
    procedure Registered(EmailAddress: Text; MemberNumber: Code[12])
    // This sends users an email once their account is verified/approved
    begin
        EmailMessage.Create(EmailAddress, 'Successful Membership Application!',StrSubstNo('Welcome to the Coretec Membership club!<br>Your account registration has been approved.<br>Membership number is %1', MemberNumber),true);
        Email.Send(EmailMessage);
    end;

    procedure RejectedApplicationEmail(EmailAddress: Text; Reason: Text)
    var
        varReason : Text[150];
    begin
        if Reason <> '' then begin
            varReason := StrSubstNo('<br>Reason: <i>%1</i><br>', Reason);
        end else begin
            varReason := '';
        end;
        EmailMessage.Create(EmailAddress, 'Unsuccessful Application',StrSubstNo('We regret to inform you that your application to join the Coretec Membership Club was rejected.%1<br>We invite you to submit another application at any of your branches. <br>Thank you!', varReason),true);
        Email.Send(EmailMessage);
    end;

    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
}