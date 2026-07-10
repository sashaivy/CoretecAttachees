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
            trigger OnValidate()
            begin
                validatepersonname("First Name", 'First Name');
            end;

        }
        field(40; "Last Name"; Text[20])
        {
            Caption = 'Last Name';
            trigger OnValidate()
            begin
                validatepersonname("Last Name", 'Last Name');
            end;
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
        field(51; "Identificationtype"; option)
        {
            OptionMembers = "National ID","Passport Number";
            Caption = 'Identification type';
            DataClassification = ToBeClassified;
        }
        field(52; "National ID/Passport Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'ID/Passport Number';
            trigger OnValidate()
            begin
                validateIdentification("National ID/Passport Number", 'Identificationtype');
            end;
            // }
            //field(60; "ID/Passport Number"; Code[10])
            // {
            // trigger OnValidate()
            //var
            // ValidateID: Codeunit "Validate ID";
            //begin
            //ValidateID.ValidateIdentification(Rec);
            // end;
            //}
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
        field(130; "Occupation Code"; Option)
        {
            Caption = 'Occupation Code';
            OptionMembers = "Unemployed","Employed","Self-Employed","Student","Retired ","Other";
        }
        field(140; "Annual Income"; Decimal)
        {
            Caption = 'Annual Income';
            decimalPlaces = 2 : 2;
        }
        field(150; "Member Category"; Option)
        {
            Caption = 'Member Category';
            OptionMembers = "Standard","Premium","Gold","Platinum";
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

    local procedure validatepersonname(Name: Text[20]; FieldName: Text[20])
    var
        i: Integer;
        Character: Char;
        PreviousCharacter: Char;
    begin
        Name := DelChr(Name, '<>', '.');
        Name := DelChr(Name, '<>');
        if Name = '' then
            Error('%1 cannot be empty.', FieldName);
        PreviousCharacter := ' ';
        for i := 1 to StrLen(Name) do begin
            Character := Name[i];
            if not (Character in ['A' .. 'Z', 'a' .. 'z', ' ', '-']) then
                Error('%1 can contain only letters, spaces, and hyphens.', FieldName);
            if (Character = ' ') and (PreviousCharacter = ' ') then
                Error('%1 cannot contain consecutive spaces.', FieldName);
            PreviousCharacter := Character;
            continue;
        end;
        case Character of
            '-':
                begin
                    if (Character = '-') and (PreviousCharacter = '-') then
                        Error('%1 cannot contain consecutive hyphens.', FieldName);
                end;
            '''':
                begin
                    if (Character = '''') and (PreviousCharacter = '''') then
                        Error('%1 cannot contain consecutive apostrophes.', FieldName);
                end;
            else
                error('%1 contains an invalid character: %2.', FieldName, Character);
        end;
    end;

    local procedure ValidateIdentification(IdentificationNumber: Text[20]; FieldName: Text[20])
    var
        i: Integer;
    begin
        case Identificationtype of
            "IdentificationType"::"National ID":
                begin
                    ///Length check
                    if not (StrLen("IdentificationNumber") in [7, 8]) then
                        Error('A National ID must contain 7 or 8 digits.');

                    //Digits only
                    for i := 1 to StrLen("IdentificationNumber") do
                        if not ("IdentificationNumber"[i] in ['0' .. '9']) then
                            Error('A National ID can contain digits only.');
                end;

            "IdentificationType"::"Passport Number":
                begin
                    if StrLen("IdentificationNumber") < 6 then
                        Error('Enter a valid passport number.');
                    for i := 1 to StrLen("IdentificationNumber") do
                        if not ("IdentificationNumber"[i] in ['A' .. 'Z', 'a' .. 'z', '0' .. '9']) then
                            Error('A Passport Number can contain letters and digits only.');
                end;
        end;
    end;
}
