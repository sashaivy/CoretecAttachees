namespace CoretecAttachees.CoretecAttachees;
page 50140 "Member Application Card"
{
    PageType = Card;
    Caption = 'Member Application Card';
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Member Application";

    layout
    {
        area(Content)
        {
            group("General Information")
            {
                Caption = 'General Information';
                field("Number"; Rec.Number) { Editable = false; }
                field("Application ID"; Rec."Application ID") { Editable = false; }
                field(Status; Rec.Status) { Editable = false; }
                field("Application Date"; Rec."Application Date") { Editable = false; }
            }
            group("Personal Information")
            {
                Caption = 'Personal Information';
                field("First Name"; Rec."First Name") { Tooltip = 'Enter the first name of the applicant.'; }
                field("Last Name"; Rec."Last Name") { Tooltip = 'Enter the last name of the applicant.'; }
                field("Date of Birth"; Rec."Date of Birth") { Tooltip = 'Enter the date of birth of the applicant in DDMMYYYY numeric format 01012006(DAYMONTHYEAR).'; }
                field("Identificationtype"; Rec."Identificationtype") { Tooltip = 'Select the identification type of the applicant.'; }
                field("National ID/Passport Number"; Rec."National ID/Passport Number") { Tooltip = 'Enter the ID or passport number without omissions.'; }
            }
            group("Contact Information")
            {
                Caption = 'Contact Information';
                field(Country; Rec.Country) { Tooltip = 'Select the country of the applicant from the list.'; }
                field("Phone Number"; Rec."Phone Number") { Tooltip = 'Enter the phone number of the applicant.'; }
                field(City; Rec.City) { Tooltip = 'Enter the city of the applicant.'; }
                field("Postal Code"; Rec."Postal Code") { Tooltip = 'Enter the postal code of the applicant.'; }
                field(Email; Rec.Email) { Tooltip = 'Enter the email address of the applicant.'; }
                field(Address; Rec.Address) { Tooltip = 'Enter the address of the applicant.'; }
            }
            group("Employment Information")
            {
                Caption = 'Employment Information';
                field("Occupation Code"; Rec."Occupation Code") { Tooltip = 'Enter the occupation code of the applicant.'; }
                field("Annual Income"; Rec."Annual Income") { Tooltip = 'Enter the annual income of the applicant.'; }
                field("Member Category"; Rec."Member Category") { Tooltip = 'Select the member category of the applicant from the list.'; }
            }
            group("Approval Information")
            {
                Caption = 'Approval Information';
                field("Approval Date"; Rec."Approval Date") { Editable = false; }
                field("Rejection Reason"; Rec."Rejection Reason") { Editable = false; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Approve)
            {
                Caption = 'Approve';
                Image = Approve;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approval Management";
                    MemberAppSetup: Record "Member Application Setup";
                begin
                    if MemberAppSetup.Get('DEFAULT') then
                        if MemberAppSetup."Approval Required" then
                            exit;

                    ApprovalMgt.ApproveApplication(Rec);
                    CurrPage.Update(false);
                end;
            }

            action(Reject)
            {
                Caption = 'Reject';
                Image = Cancel;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approval Management";
                    MemberAppSetup: Record "Member Application Setup";
                begin
                    if MemberAppSetup.Get('DEFAULT') then
                        if MemberAppSetup."Approval Required" then
                            exit;

                    ApprovalMgt.RejectApplication(Rec);
                    CurrPage.Update(false);
                end;
            }
        }
    }
}
