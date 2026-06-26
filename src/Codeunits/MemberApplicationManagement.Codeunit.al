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
        MemberApp.TestField("ID/Passport No.");
        MemberApp.TestField("Monthly Contribution Target");

        if MemberApp."Employment Status" = MemberApp."Employment Status"::Employed then begin
            MemberApp.TestField("Employer Name");
            MemberApp.TestField("Monthly Gross Income");
        end;

        if MemberApp."Allocation %" <> 100 then
            Error('Total Benefit Allocation Percentage for the Next of Kin must equal exactly 100%.');
    end;
}