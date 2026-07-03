table 50108 "Member Application"
{
    Caption = 'Member Application';
    DataClassification = CustomerContent;

    fields
    {
        //General Information
        field(1; "Application ID"; Code[20])
        {
            Caption = 'Application ID';
            DataClassification = CustomerContent;
            Editable = false;

        }
        field(2; "Application Date"; Date)
        {
            Caption = 'Application Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; Status; Enum "Member Application Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Editable = false;
        }

        //Personal Information
        field(4; "First Name"; Text[100])
        {
            Caption = 'First Name';
            DataClassification = CustomerContent;
        }
        field(5; "last Name"; text[100])
        {
            Caption = 'Last Name';
            DataClassification = CustomerContent;
        }
        field(6; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = ToBeClassified;

        }
        field(7; "ID/Passport Number"; Text[50])
        {
            Caption = 'ID/Passport Number';
            DataClassification = CustomerContent;
        }

        //Contact Information
        field(8; "Phone Number"; Text[30])
        {
            Caption = 'Phone Number';
            DataClassification = CustomerContent;
        }
        field(9; city; Text[100])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
        }
        field(10; Email; Text[250])
        {
            Caption = 'Email';
            DataClassification = CustomerContent;
        }
        field(11; "Postal Code"; Code[20])
        {
            Caption = 'Postal Code';
            DataClassification = CustomerContent;
        }
        field(12; "Address"; Text[250])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(13; Country; Code[10])
        {
            Caption = 'Country';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region".Code;
        }

        //Employmant Information
        field(14; "Occupation Code"; Enum "Occupation Code")
        {
            Caption = 'Occupation Code';
            DataClassification = CustomerContent;
        }
        field(15; "Member Category"; Enum "Member Category")
        {
            Caption = 'Member Category';
            DataClassification = CustomerContent;
        }
        field(16; "Annual Income"; Decimal)
        {
            Caption = 'Annual Income';
            DataClassification = CustomerContent;
            MinValue = 0;
            DecimalPlaces = 2 : 2;
        }

        //Approval information
        field(17; "Approval Date"; Date)
        {
            Caption = 'Approval Date';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(18; "Rejection Reason"; Text[250])
        {
            Caption = 'Rejection Reason';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(19; "Transferred to Member"; Boolean)
        {
            Caption = 'Transferred to Member';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(20; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = CustomerContent;
            Editable = false;
        }

    }
    keys
    {
        key(PK; "Application ID")
        {
            Clustered = true;
        }
        key(Key2; "last Name", "First Name")
        {

        }
        key(Key3; Status)
        { }
    }
    trigger OnInsert()
    var
        LastEntry: Record "Member Application";
        NewID: Code[20];
    begin
        if "Application ID" = '' then begin
            LastEntry.Reset();
            if LastEntry.FindLast() then
                NewID := IncStr(LastEntry."Application ID")
            else
                NewID := 'APP-0001';
            "Application ID" := NewID;
        end;

        if "Application Date" = 0D then
            "Application Date" := Today();

        Status := Status::Pending;
    end;

}