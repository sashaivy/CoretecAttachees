table 50140 "Member Application Table"
{
    Caption = 'Member Application Table';
    DataClassification = OrganizationIdentifiableInformation;
    
    fields
    {
        field(1; "Application ID"; Integer)
        {
            Caption = 'Application ID';
            AutoIncrement = true;
            MinValue = 1001;
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
        field(7; "ID/Passport Number"; Code[10])
        {
            // datatype cannot be Int since it will drop leading zeros and fails to represent alphanumerics
            Caption = 'ID/Passport Number';
        }
        field(8; "Phone Number"; Text[13])
        {
            Caption = 'Phone Number';
            ExtendedDatatype = PhoneNo;
        }
        field(9; Email; Text[50])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;
        }
        field(10; Address; Text[50])
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
        field(13; Country; Code[10])
        {
            Caption = 'Country';
            TableRelation = "Country/Region"; // using the "Country/Region" supp tbl
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
            OptionMembers = "Standard","Premium";
        }
        field(17; "Approval Date"; Date)
        {
            Caption = 'Approval Date';
        }
        field(18; "Rejection Reason"; Text[100])
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
