codeunit 50316 "Member Application Mgt"
{
    procedure ApproveMember(var MemberApp: Record "Member Application")
    begin
        if MemberApp.Status = MemberApp.Status::Approved then
            Error('Application for %1 has already been approved.', MemberApp."Full Name");
        if MemberApp.Status = MemberApp.Status::Rejected then
            Error('Application for %1 has already been rejected.', MemberApp."Full Name");

        MemberApp.Status := MemberApp.Status::Approved;
        MemberApp."Decision Date" := Today();
        MemberApp."Decision By" := CopyStr(UserId(), 1, 50);
        MemberApp.Modify(true);

        SendEmail(MemberApp, 0);
    end;

    procedure RejectMember(var MemberApp: Record "Member Application")
    begin
        if MemberApp.Status = MemberApp.Status::Rejected then
            Error('Application for %1 has already been rejected.', MemberApp."Full Name");
        if MemberApp.Status = MemberApp.Status::Approved then
            Error('Application for %1 has already been approved.', MemberApp."Full Name");

        MemberApp.Status := MemberApp.Status::Rejected;
        MemberApp."Decision Date" := Today();
        MemberApp."Decision By" := CopyStr(UserId(), 1, 50);
        MemberApp.Modify(true);

        SendEmail(MemberApp, 1);
    end;

    local procedure SendEmail(MemberApp: Record "Member Application"; TemplateType: Integer)
    var
        EmailTemplate: Record "Member Message Template";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Body: Text;
        Subject: Text;
    begin
        if not EmailTemplate.Get(TemplateType) then
            Error('Email template not found. Please set it up under Member Message Templates.');

        Subject := EmailTemplate."Email Subject";
        Body := EmailTemplate."Email Body";

        Body := Body.Replace('{Name}', MemberApp."Full Name");
        Subject := Subject.Replace('{Name}', MemberApp."Full Name");

        EmailMessage.Create(MemberApp.Email, Subject, Body, false);

        if not Email.Send(EmailMessage) then
            Message('Status updated but email could not be sent to %1. Check Email Accounts setup.', MemberApp.Email)
        else
            Message('Email sent to %1.', MemberApp.Email);
    end;

    procedure EnsureTemplatesExist()
    var
        EmailTemplate: Record "Member Message Template";
    begin
        if not EmailTemplate.Get(0) then
            CreateDefaultApprovalTemplate();
        if not EmailTemplate.Get(1) then
            CreateDefaultRejectionTemplate();
    end;

    procedure InitDefaultTemplates()
    begin
        CreateDefaultApprovalTemplate();
        CreateDefaultRejectionTemplate();
    end;

    procedure ResetTemplate(TemplateType: Option)
    begin
        case TemplateType of
            0:
                CreateDefaultApprovalTemplate();
            1:
                CreateDefaultRejectionTemplate();
        end;
    end;

    local procedure CreateDefaultApprovalTemplate()
    var
        EmailTemplate: Record "Member Message Template";
        CompanyInfo: Record "Company Information";
        CompanyName: Text;
    begin
        if CompanyInfo.Get() then
            CompanyName := CompanyInfo.Name
        else
            CompanyName := 'Our Organization';

        if not EmailTemplate.Get(0) then begin
            EmailTemplate.Init();
            EmailTemplate."Template Type" := EmailTemplate."Template Type"::Approval;
            EmailTemplate.Insert();
        end;

        EmailTemplate."Email Subject" := 'Your Membership Application Has Been Approved';
        EmailTemplate."Email Body" := CopyStr(
            'Dear {Name},' + NewLine() +
            'We are pleased to inform you that your membership application has been approved.' + NewLine() +
            'Welcome to ' + CompanyName + '!' + NewLine() +
            'Warm regards,' + NewLine() +
            CompanyName + ' Membership Team',
            1, 2048
        );
        EmailTemplate.Modify();
    end;

    local procedure CreateDefaultRejectionTemplate()
    var
        EmailTemplate: Record "Member Message Template";
        CompanyInfo: Record "Company Information";
        CompanyName: Text;
    begin
        if CompanyInfo.Get() then
            CompanyName := CompanyInfo.Name
        else
            CompanyName := 'Our Organization';

        if not EmailTemplate.Get(1) then begin
            EmailTemplate.Init();
            EmailTemplate."Template Type" := EmailTemplate."Template Type"::Rejection;
            EmailTemplate.Insert();
        end;

        EmailTemplate."Email Subject" := 'Update on Your Membership Application';
        EmailTemplate."Email Body" := CopyStr(
            'Dear {Name},' + NewLine() +
            'Thank you for your interest in joining ' + CompanyName + '.' + NewLine() +
            'After careful review, we regret to inform you that we are unable to approve your membership at this time.' + NewLine() +
            'We encourage you to reapply in the future and wish you all the best.' + NewLine() +
            'Kind regards,' + NewLine() +
            CompanyName + ' Membership Team',
            1, 2048
        );
        EmailTemplate.Modify();
    end;

    local procedure NewLine(): Text
    var
        LF: Char;
    begin
        LF := 10;
        exit(Format(LF));
    end;
}
