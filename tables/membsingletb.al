table 50120 "Member"
{
    Caption = 'Member Single';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(2; "Application ID"; Code[20])
        {
            Caption = 'Application ID';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(3; "Member Since"; Date)
        {
            Caption = 'Member Since';
            DataClassification = CustomerContent;
            Editable = false;
        }


        // Personal Information
        field(5; "First Name"; Text[100])
        {
            Caption = 'First Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Last Name"; Text[100])
        {
            Caption = 'Last Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "ID/Passport Number"; Text[50])
        {
            Caption = 'ID/Passport Number';
            DataClassification = CustomerContent;
            Editable = false;
        }

        // Contact Information
        field(9; "Phone Number"; Text[30])
        {
            Caption = 'Phone Number';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; City; Text[100])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; Email; Text[250])
        {
            Caption = 'Email';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; "Postal Code"; Code[20])
        {
            Caption = 'Postal Code';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(13; Address; Text[250])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(14; Country; Code[10])
        {
            Caption = 'Country';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Country/Region".Code;
        }

        // Employment Information
        field(15; "Occupation Code"; Enum "Occupation Code")
        {
            Caption = 'Occupation Code';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; "Member Category"; Enum "Member Category")
        {
            Caption = 'Member Category';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(17; "Annual Income"; Decimal)
        {
            Caption = 'Annual Income';
            DataClassification = CustomerContent;
            Editable = false;
            DecimalPlaces = 2 : 2;
        }

        // Approval Information
        field(18; "Approval Date"; Date)
        {
            Caption = 'Approval Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(19; "Approved By"; Text[100])
        {
            Caption = 'Approved By';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Member No.")
        {
            Clustered = true;
        }
        key(Key2; "Application ID") { }
        key(Key3; "Last Name", "First Name") { }
    }

    trigger OnInsert()
    var
        LastEntry: Record "Member";
        NewNo: Code[20];
    begin
        if "Member No." = '' then begin
            LastEntry.Reset();
            if LastEntry.FindLast() then
                NewNo := IncStr(LastEntry."Member No.")
            else
                NewNo := 'MEM-0001';
            "Member No." := NewNo;
        end;
    end;
}