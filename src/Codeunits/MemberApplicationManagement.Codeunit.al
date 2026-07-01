codeunit 50201 "Member Application Management"
{
    procedure InitNewApplication(var MemberApp: Record "Member Application")
    var
        SaccoSetup: Record "SACCO Setup";
        NoSeries: Codeunit "No. Series";
    begin
        if MemberApp."Application No." = '' then begin
            SaccoSetup.Get();
            SaccoSetup.TestField("Member Application Nos.");

            // Assign the number series configured in your SACCO Setup
            MemberApp."No. Series" := SaccoSetup."Member Application Nos.";

            // Automatically grab the next sequential tracking number
            MemberApp."Application No." := NoSeries.GetNextNo(MemberApp."No. Series");

            // Stamp operational creation data
            MemberApp."Date Created" := Today;
            MemberApp."Created By" := UserId;
        end;
    end;

    // Custom SACCO Rule: Ensures compliance and allocation details are valid before approval
    procedure ValidateApplicationForApproval(var MemberApp: Record "Member Application")
    begin
        MemberApp.TestField("First Name");
        MemberApp.TestField("Last Name");
        MemberApp.TestField("ID/Passport No.");
        MemberApp.TestField("Phone No.");
        MemberApp.TestField("Email");
        MemberApp.TestField("Monthly Contribution Target");

        if MemberApp."Employment Status" = "Employment Status"::Employed then begin
            MemberApp.TestField("Employer Name");
            MemberApp.TestField("Monthly Gross Income");
        end;

        if MemberApp."Allocation %" <> 100 then
            Error('Total Benefit Allocation Percentage for the Next of Kin must equal exactly 100%.');
    end;

    // 🌟 RECTIFIED & ADDED: This function seamlessly bridges your Application to the Member Master Table
    procedure CreatePermanentMember(var MemberApp: Record "Member Application")
    var
        SaccoSetup: Record "SACCO Setup";
        MemberRecord: Record "Member";
        NoSeries: Codeunit "No. Series";
    begin
        SaccoSetup.Get();
        SaccoSetup.TestField("Member Nos."); // Ensures the admin has configured the Member Number Series

        // 1. Initialize the new Member record structure
        MemberRecord.Init();

        // 2. Generate and assign the permanent sequential Member Number
        MemberRecord."No. Series" := SaccoSetup."Member Nos.";
        MemberRecord."No." := NoSeries.GetNextNo(MemberRecord."No. Series");

        // 3. Map across all corresponding master data fields cleanly
        MemberRecord."Title" := MemberApp."Title";
        MemberRecord."First Name" := MemberApp."First Name";
        MemberRecord."Middle Name" := MemberApp."Middle Name";
        MemberRecord."Last Name" := MemberApp."Last Name";
        MemberRecord."Gender" := MemberApp."Gender";
        MemberRecord."Date of Birth" := MemberApp."Date of Birth";
        MemberRecord."Marital Status" := MemberApp."Marital Status";
        MemberRecord."Nationality" := MemberApp."Nationality";

        MemberRecord."Identification Type" := MemberApp."Identification Type";
        MemberRecord."ID/Passport No." := MemberApp."ID/Passport No."; // Typo fixed here!
        MemberRecord."KRA PIN" := MemberApp."KRA PIN";

        MemberRecord."Phone No." := MemberApp."Phone No.";
        MemberRecord."Email" := MemberApp."Email";
        MemberRecord."Address" := MemberApp."Address";
        MemberRecord."City" := MemberApp."City";

        MemberRecord."Monthly Contribution Target" := MemberApp."Monthly Contribution Target";
        MemberRecord."Dividend Payout Method" := MemberApp."Dividend Payout Method";

        // Pull over opening balances from application records
        MemberRecord."Current Shares" := MemberApp."Opening Shares";
        MemberRecord."Total Deposits" := MemberApp."Initial Deposit";

        // 4. Set the initial membership state to Active
        MemberRecord."Status" := MemberRecord."Status"::Active;
        MemberRecord."Membership Date" := Today;

        // 5. Commit record insert directly into SQL Database
        MemberRecord.Insert(true);

        // Pop up confirmation showing the newly generated identification tracking number
        Message('Permanent profile created successfully! Assigned Member Number: %1', MemberRecord."No.");
    end;
}