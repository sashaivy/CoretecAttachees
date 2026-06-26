table 50140 "Member Application Table"
{
    Caption = 'Member Application Table';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Application ID"; Integer)
        {
            Caption = 'Application ID';
        }
        field(2; "Application Date"; Date)
        {
            Caption = 'Application Date';
        }
        field(3; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Pending, Approved, Rejected;
        }
        field(4; "First Name"; Text[20])
        {
            Caption = 'First Name';
        }
        field(5; "Last Name"; Text[20])
        {
            Caption = 'Last Name';
        }
        field(6; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
        }
        field(7; "ID/Passport Number"; Integer)
        {
            Caption = 'ID/Passport Number';
        }
        field(8; "Phone Number"; Code[13])
        {
            Caption = 'Phone Number';
        }
        field(9; Email; Code[50])
        {
            Caption = 'Email';
        }
        field(10; Address; Code[50])
        {
            Caption = 'Address';
        }
        field(11; City; Text[20])
        {
            Caption = 'City';
        }
        field(12; "Postal Code"; Code[10])
        {
            Caption = 'Postal Code';
        }
        field(13; Country; Text[50])
        {
            Caption = 'Country';
            TableRelation = "Country/Region".Name;
        }
        field(14; "Occupation Code"; Code[10])
        {
            Caption = 'Occupation Code';
        }
        field(15; "Annual Income"; Decimal)
        {
            Caption = 'Annual Income';
        }
        field(16; "Member Category"; Option)
        {
            Caption = 'Member Category';
            OptionMembers = "","1", "2", "3";
        }
        field(17; "Approval Date"; Date)
        {
            Caption = 'Approval Date';
        }
        field(18; "Rejection Reason"; Code[100])
        {
            Caption = 'Rejection Reason';
        }
    }
    keys
    {
        key(PK; "Application ID")
        {
            Clustered = true;
        }
    }
}
