page 50102 "Registered Member Information"
{
    Caption = 'Registered Member Information';
    PageType = Card;
    SourceTable = "Members";
    UsageCategory = Administration;
    ApplicationArea = All;
    Editable = false;
    DeleteAllowed = false;


    layout
    {

        area(Content)
        {
            group(General)
            {
                Caption = 'Member Details';
                field("Member No.No.series"; Rec."No.")
                {
                    Caption = 'Member No.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("First Name"; "First Name")
                {
                    Caption = 'First Name';
                    ApplicationArea = All;
                }
                field("Last Name"; "Last Name")
                {
                    Caption = 'Last Name';
                    ApplicationArea = All;
                }
                field("National"; "Nationality")
                {
                    Caption = 'Nationality';
                    ApplicationArea = All;
                }
                field("National ID/Passport"; "National ID No.")
                {
                    Caption = 'National ID/Passport';
                    ApplicationArea = All;
                }
                field("Employment Status"; "Employment Status")
                {
                    Caption = 'Employment Status';
                    ApplicationArea = All;
                }
                field("Place of Work"; "Place of Work")
                {
                    Caption = 'Place of Work/Company Name';
                    ApplicationArea = All;
                }
                field("KRA pin"; "KRA Pin")
                {
                    Caption = 'KRA Pin';
                    ApplicationArea = All;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    Caption = 'Date of Birth';
                    ApplicationArea = All;
                }
                field("Sex"; "Sex")
                {
                    Caption = 'Sex';
                    ApplicationArea = All;
                }
                field("Next of kin"; "Next of Kin")
                {
                    Caption = 'Next of kin';
                    ApplicationArea = All;
                }
                field("Relationship"; "Relationship")
                {
                    Caption = 'Relationship';
                    ApplicationArea = All;
                }
                field("City/Town of Residence"; "City/Town of Residence")
                {
                    Caption = 'City/Town of REsidence';
                    ApplicationArea = All;
                }
                field("County"; "County")
                {
                    Caption = 'County';
                    ApplicationArea = All;
                }
                field("Estate"; "Estate")
                {
                    Caption = 'Estate';
                    ApplicationArea = All;
                }
                field("Status"; "Status")
                {
                    Caption = 'Status';
                }
            }

            group(Contacts)
            {
                Caption = 'Contacts Information';

                field("Phone No."; "Contact No.")
                {
                    Caption = 'Phone No.';
                    ApplicationArea = All;
                }
                field("Email"; "Email Address")
                {
                    Caption = 'Email';
                    ApplicationArea = All;
                }
                field("Postal Address"; "Postal Address")
                {
                    Caption = 'Postal Address';
                    ApplicationArea = All;
                }
            }
        }
    }



}