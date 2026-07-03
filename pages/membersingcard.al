page 50132 "Member Card"
{
    PageType = Card;
    Caption = 'Member';
    SourceTable = "Member";
    UsageCategory = Documents;
    ApplicationArea = All;
    Editable = false;  // ENTIRE PAGE IS READ ONLY

    layout
    {
        area(Content)
        {
            group(GeneralInformation)
            {
                Caption = 'General Information';

                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the member number.';
                }
                field("Application ID"; Rec."Application ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the originating application ID.';
                }
                field("Member Since"; Rec."Member Since")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date the member was registered.';
                }

            }

            group(PersonalInformation)
            {
                Caption = 'Personal Information';

                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the first name.';
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of birth.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last name.';
                }
                field("ID/Passport Number"; Rec."ID/Passport Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID or passport number.';
                }
            }

            group(ContactInformation)
            {
                Caption = 'Contact Information';

                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the phone number.';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the city.';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the email address.';
                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the postal code.';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the address.';
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the country.';
                }
            }

            group(EmploymentInformation)
            {
                Caption = 'Employment Information';

                field("Occupation Code"; Rec."Occupation Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the occupation.';
                }
                field("Member Category"; Rec."Member Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the member category.';
                }
                field("Annual Income"; Rec."Annual Income")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the annual income.';
                }
            }

            group(ApprovalInformation)
            {
                Caption = 'Approval Information';

                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the approval date.';
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who approved the application.';
                }
            }
        }
    }

    var
        StatusStyle: Text;

}