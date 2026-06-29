table 50350 "Member application table"
{
    Caption = 'Member application table';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Application no."; Integer)
        {
            Caption = 'Application no.';
        }
        field(2; "First Name"; Text[20])
        {
            Caption = 'First Name';
        }
        field(3; "Middle Name"; Text[20])
        {
            Caption = 'Middle Name';
        }
        field(4; "Last Name"; Text[20])
        {
            Caption = 'Last Name';
        }
        field(5; "National Id"; Integer)
        {
            Caption = 'National Id';
        }
        field(6; "Phone no."; Code[20])
        {
            Caption = 'Phone no.';
        }
        field(7; Email; Text[30])
        {
            Caption = 'Email';
        }
        field(8; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
        }
        field(9; Gender; Option)
        {
            OptionMembers = Male,Female;
        }
        field(10; Occupation; Text[20])
        {
            Caption = 'Occupation';
        }
        field(11; "Monthly Income"; Decimal)
        {
            Caption = 'Monthly Income';
        }
        field(12; "Application Date"; Date)
        {
            Caption = 'Application Date';
        }
        field(13; Status; Option)
        {
            OptionMembers =Open, Pending, Approved, Rejected;
            Caption = 'Status';
        }
    }
    keys
    {
        key(PK; "Application no.")
        {
            Clustered = true;
        }
    }
}
