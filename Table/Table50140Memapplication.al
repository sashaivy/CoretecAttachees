table 50140 "Member Application"
{
    Caption = 'Member Application Table';
    DataClassification = OrganizationIdentifiableInformation;

    fields
    {
        field(1; "Application ID"; Code[12])
        {
            Caption = 'Application ID';
        }
        field(10; Status; Enum "Application Status")
        {
            Caption = 'Status';
        }
        field(20; "Application Date"; Date)
        {
            Caption = 'Application Date';
        }
        field(30; "First Name"; Text[20])
        {
            Caption = 'First Name';
        }
        field(40; "Last Name"; Text[20])
        {
            Caption = 'Last Name';
        }
        field(50; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';

            trigger OnValidate()
            var
                MemberApplicationSetup: Record "Member Application Setup";
            begin
                if "Date of Birth" = 0D then
                    exit;

                if not MemberApplicationSetup.Get('DEFAULT') then begin
                    MemberApplicationSetup.Init();
                    MemberApplicationSetup."Primary Key" := 'DEFAULT';
                    MemberApplicationSetup."Minimum Age" := 18;
                    MemberApplicationSetup.Insert();
                end;

                if "Date of Birth" > CalcDate(StrSubstNo('<-%1Y>', MemberApplicationSetup."Minimum Age"), Today) then
                    Error('Applicant must be at least %1 years old.', MemberApplicationSetup."Minimum Age");
            end;
        }
        //  field(51; "Identificationtype"; options)
        // {
        // OptionMembers = "National ID", "Passport Number"
        // caption = 'Identification type'
        // DataClassification = ToBeClassified;
        //}
        // field(52; "National ID/Passport Number"; Code[20])
        //{
        // DataClassification = ToBeClassified;
        // }
        field(60; "ID/Passport Number"; Code[10])
        {
            Caption = 'ID/Passport Number';
        }
        field(70; "Phone Number"; Text[13])
        {
            Caption = 'Phone Number';
            ExtendedDatatype = PhoneNo;
        }
        field(80; Email; Text[50])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;
        }
        field(90; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(100; City; Text[20])
        {
            Caption = 'City';
        }
        field(110; "Postal Code"; Code[10])
        {
            Caption = 'Postal Code';
        }
        field(120; Country; Code[10])
        {
            Caption = 'Country';
            TableRelation = "Country/Region";
        }
        field(130; "Occupation Code"; Code[10])
        {
            Caption = 'Occupation Code';
        }
        field(140; "Annual Income"; Decimal)
        {
            Caption = 'Annual Income';
        }
        field(150; "Member Category"; Option)
        {
            Caption = 'Member Category';
            OptionMembers = "Standard","Premium";
        }
        field(160; "Approval Date"; Date)
        {
            Caption = 'Approval Date';
        }
        field(170; "Rejection Reason"; Text[100])
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

    trigger OnInsert()
    var
        AppNoMgt: Codeunit "Application ID No. Mgt.";
    begin
        Status := Status::Pending;
        "Application Date" := Today;
        if "Application ID" = '' then
            "Application ID" := AppNoMgt.GetNextNo();
    end;
}
