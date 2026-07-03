codeunit 50100 "Member Application Transfer"
{
    trigger OnRun()
    begin
    end;

    procedure TransferToMember(var MemberApplication: Record "Member Application")
    var
        Member: Record "Member";
    begin
        // CHECK 1: Must be Approved status
        if MemberApplication.Status <> MemberApplication.Status::Approved then
            Error(
                'Cannot transfer this application.\Status must be Approved.\Current Status: %1',
                MemberApplication.Status);

        // CHECK 2: Must not already be transferred
        if MemberApplication."Transferred to Member" then
            Error(
                'Application %1 was already transferred to Member No. %2',
                MemberApplication."Application ID",
                MemberApplication."Member No.");

        // CHECK 3: Validate required fields are filled
        CheckRequiredFields(MemberApplication);

        // CHECK 4: Ask user to confirm
        if not Confirm(
            'Transfer Application %1 to the Member Register?\This cannot be undone. Continue?',
            false,
            MemberApplication."Application ID") then
            exit;

        // BUILD the member record
        BuildAndInsertMember(MemberApplication, Member);

        // STAMP the application as transferred
        MemberApplication."Transferred to Member" := true;
        MemberApplication."Member No." := Member."Member No.";
        MemberApplication.Modify(true);

        // OPEN the new Member Card
        if Confirm(
            'Transfer complete!\Member No. %1 created.\Open the Member record now?',
            true,
            Member."Member No.") then
            Page.Run(Page::"Member Card", Member);
    end;

    local procedure CheckRequiredFields(MemberApplication: Record "Member Application")
    begin
        if MemberApplication."First Name" = '' then
            Error('First Name must be filled before transfer.');
        if MemberApplication."last Name" = '' then
            Error('Last Name must be filled before transfer.');
        if MemberApplication."ID/Passport Number" = '' then
            Error('ID/Passport Number must be filled before transfer.');
        if MemberApplication."Date of Birth" = 0D then
            Error('Date of Birth must be filled before transfer.');
        if MemberApplication."Phone Number" = '' then
            Error('Phone Number must be filled before transfer.');
        if MemberApplication.Email = '' then
            Error('Email must be filled before transfer.');
    end;

    local procedure BuildAndInsertMember(
        MemberApplication: Record "Member Application";
        var Member: Record "Member")
    var
        ExistingMember: Record "Member";
    begin
        // Safety: check no duplicate exists
        ExistingMember.Reset();
        ExistingMember.SetRange("Application ID", MemberApplication."Application ID");
        if not ExistingMember.IsEmpty() then
            Error('A Member already exists for Application %1.',
                MemberApplication."Application ID");

        Member.Init();

        // General
        Member."Application ID" := MemberApplication."Application ID";
        Member."Member Since" := Today();

        // Personal
        Member."First Name" := MemberApplication."First Name";
        Member."Last Name" := MemberApplication."last Name";
        Member."Date of Birth" := MemberApplication."Date of Birth";
        Member."ID/Passport Number" := MemberApplication."ID/Passport Number";

        // Contact
        Member."Phone Number" := MemberApplication."Phone Number";
        Member.City := MemberApplication.city;
        Member.Email := MemberApplication.Email;
        Member."Postal Code" := MemberApplication."Postal Code";
        Member.Address := MemberApplication.Address;
        Member.Country := MemberApplication.Country;

        // Employment
        Member."Occupation Code" := MemberApplication."Occupation Code";
        Member."Member Category" := MemberApplication."Member Category";
        Member."Annual Income" := MemberApplication."Annual Income";

        // Approval
        Member."Approval Date" := MemberApplication."Approval Date";
        Member."Approved By" := UserId();

        // This triggers OnInsert which auto-sets Member No.
        Member.Insert(true);
    end;
}