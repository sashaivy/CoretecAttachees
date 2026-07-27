codeunit 50141 "Approval Management"
{
    procedure ApproveApplication(var MemApplication: Record "Member Application")
    var
        Setup: Record "Member Application Setup";
        AppNoMgt: Codeunit "Application ID No. Mgt.";
        FormEmail: Codeunit "Form Email Management";
    begin
        Setup.Get('DEFAULT');
        if not Setup.Get('DEFAULT') then begin
            Setup.Init();
            Setup."Primary Key" := 'DEFAULT';
            Setup."Minimum Age" := 18;
            Setup."Approval Required" := true;
            Setup.Insert();
        end;

        if MemApplication.Status <> MemApplication.Status::Pending then
            Error('Only pending applications can be approved.');

        //If approval workflow is disabled,
        //approve immediately.
        if not Setup."Approval Required" then begin

            if MemApplication."Application ID" = '' then
                MemApplication."Application ID" := AppNoMgt.GetNextNo();

            MemApplication.Status := MemApplication.Status::Approved;
            MemApplication."Approval Date" := Today;
            MemApplication."Rejection Reason" := '';

            MemApplication.Modify(true);

            FormEmail.SendFormEmail(MemApplication, Enum::"Application Status"::Approved);

            Message('Application approved successfully.');
            exit;
        end;

        //Manual approval enabled

        if MemApplication."Application ID" = '' then
            MemApplication."Application ID" := AppNoMgt.GetNextNo();

        MemApplication.Status := MemApplication.Status::Approved;
        MemApplication."Approval Date" := Today;
        MemApplication."Rejection Reason" := '';

        MemApplication.Modify(true);

        FormEmail.SendFormEmail(MemApplication, Enum::"Application Status"::Approved);

        Message('Application approved successfully.');
    end;

    procedure RejectApplication(var MemApplication: Record "Member Application")
    var
        Setup: Record "Member Application Setup";
        ReasonBuffer: Record "Rejection Reason Buffer";
        FormEmail: Codeunit "Form Email Management";
    begin

        if not Setup.Get('DEFAULT') then begin
            Setup.Init();
            Setup."Primary Key" := 'DEFAULT';
            Setup."Minimum Age" := 18;
            Setup."Approval Required" := true;
            Setup.Insert();
        end;

        if not Setup."Approval Required" then
            Error('Manual approval is disabled. Applications cannot be rejected.');

        if MemApplication.Status <> MemApplication.Status::Pending then
            Error('Only pending applications can be rejected.');

        ReasonBuffer.Init();

        if Page.RunModal(Page::"Rejection Reason Dialog", ReasonBuffer) <> Action::OK then
            if ReasonBuffer."Reason" = '' then
                Error('You must enter a rejection reason.');

        MemApplication.Status := MemApplication.Status::Rejected;
        MemApplication."Approval Date" := 0D;
        MemApplication."Rejection Reason" := ReasonBuffer."Reason";

        MemApplication.Modify(true);
        FormEmail.SendFormEmail(MemApplication, Enum::"Application Status"::Rejected);


        Message('Application rejected.');
        exit;
    end;
}