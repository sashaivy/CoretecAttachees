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
                field("Application ID"; rec."Application ID")
                {
                    Editable = false;
                }
                field(Status; rec.Status)
                {
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    Editable = false;
                }
            }
            group("Personal Information")
            {
                Caption = 'Personal Information';
                field("First Name"; rec."First Name")
                {
                    Tooltip = 'Enter the first name of the applicant.';
                }
                field("Last Name"; rec."Last Name")
                {
                    Tooltip = 'Enter the last name of the applicant.';
                }
                field("Date of Birth"; rec."Date of Birth")
                {
                    Tooltip = 'Enter the date of birth of the applicant.';
                }
                field("ID/Passport Number"; rec."ID/Passport Number")
                {
                    Tooltip = 'Enter the ID or passport number without omissions.';
                }
            }
            group("Contact Information")
            {
                Caption = 'Contact Information';
                field("Phone Number"; rec."Phone Number")
                {
                    Tooltip = 'Enter the phone number of the applicant.';
                }
                field(Email; rec.Email)
                {
                    Tooltip = 'Enter the email address of the applicant.';
                }
                field(Address; rec.Address)
                {
                    Tooltip = 'Enter the address of the applicant.';
                }
                field(City; rec.City)
                {
                    Tooltip = 'Enter the city of the applicant.';
                }
                field("Postal Code"; rec."Postal Code")
                {
                    Tooltip = 'Enter the postal code of the applicant.';
                }
                field(Country; rec.Country)
                {
                    Tooltip = 'Select the country of the applicant from the list.';
                }
            }
            group("Employment Information")
            {
                Caption = 'Employment Information';
                field("Occupation Code"; rec."Occupation Code")
                {
                    Tooltip = 'Enter the occupation code of the applicant.';
                }
                field("Annual Income"; rec."Annual Income")
                {
                    Tooltip = 'Enter the annual income of the applicant.';
                }
                field("Member Category"; rec."Member Category")
                {
                    Tooltip = 'Select the member category of the applicant from the list.';
                }
            }
            group("Approval Information")
            {
                Caption = 'Approval Information';
                field("Approval Date"; rec."Approval Date")
                {
                    Editable = false;
                }
                field("Rejection Reason"; rec."Rejection Reason")
                {
                    Editable = true;
                }
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
                begin
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
                begin
                    ApprovalMgt.RejectApplication(Rec, Rec."Rejection Reason");
                    CurrPage.Update(false);
                end;
            }
        }
    }
}