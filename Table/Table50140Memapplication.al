table 50140 "Member Application"
{
    Caption = 'Member Application Table';
    DataClassification = OrganizationIdentifiableInformation;

    fields
    {
        field(1; "Number"; Integer)
        {
            MinValue = 1;
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(5; "Application ID"; Code[12])
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
        field(50; "Date of Birth"; Text[10])
        {
            Caption = 'Date of Birth';
            trigger OnValidate()
            begin
                ValidateDateOfBirth("Date of Birth");
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
        }
        //field(60; "ID/Passport Number"; Code[10])
        // {
        // trigger OnValidate()
        //var
        // ValidateID: Codeunit "Validate ID";
        //begin
        //ValidateID.ValidateIdentification(Rec);
        //end;
        //}
        //}
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
            TableRelation = "Post code".City;

        }
        field(110; "Postal Code"; Code[10])
        {
            Caption = 'Postal Code';
            TableRelation = "Post Code";

        }
        field(120; Country; Code[10])
        {
            Caption = 'Country';
            TableRelation = "Country/Region";
            InitValue = 'KE';

        }
        field(130; "Occupation Code"; Option)
        {
            Caption = 'Occupation Code';
            OptionMembers = "Unemployed","Employed","Self-Employed","Student","Retired","Other";
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
        key(PK; Number)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        Status := Status::Pending;
        "Application Date" := Today;
        if Country = '' then
            Country := 'KE';
        // SetPhonePrefix();
    end;

    local procedure ValidateDateOfBirth(DateOfBirthTxt: Text[10])
    var
        Setup: Record "Member Application Setup";
        BirthYear: Integer;
        BirthMonth: Integer;
        BirthDay: Integer;
        Age: Integer;
    begin
        if DateOfBirthTxt = '' then
            exit;

        if StrLen(DateOfBirthTxt) <> 10 then
            Error('Date of Birth must be in YYYY/MM/DD format.');

        if not Evaluate(BirthYear, CopyStr(DateOfBirthTxt, 1, 4)) then
            Error('Invalid year.');

        if CopyStr(DateOfBirthTxt, 5, 1) <> '/' then
            Error('The 5th character must be a "/".');

        if not Evaluate(BirthMonth, CopyStr(DateOfBirthTxt, 6, 2)) then
            Error('Invalid month.');

        if CopyStr(DateOfBirthTxt, 8, 1) <> '/' then
            Error('The 5th character must be a "/".');

        if not Evaluate(BirthDay, CopyStr(DateOfBirthTxt, 9, 2)) then
            Error('Invalid day.');

        if (BirthMonth < 1) or (BirthMonth > 12) then
            Error('Invalid month.');

        if (BirthDay < 1) or (BirthDay > 31) then
            Error('Invalid day.');

        if not Setup.Get('DEFAULT') then
            Error('Member Application Setup is missing.');

        Age := Date2DMY(Today, 3) - BirthYear;

        if (BirthMonth > Date2DMY(Today, 2)) or
           ((BirthMonth = Date2DMY(Today, 2)) and (BirthDay > Date2DMY(Today, 1))) then
            Age -= 1;

        if Age < Setup."Minimum Age" then
            Error(
                'Applicant must be at least %1 years old.',
                Setup."Minimum Age");
    end;


    local procedure ValidatePersonName(Name: Text[20]; FieldName: Text[20])
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

            if not (Character in ['A' .. 'Z', 'a' .. 'z', ' ', '-', '''']) then
                Error('%1 can contain only letters, spaces, hyphens, and apostrophes.', FieldName);

            if (Character = ' ') and (PreviousCharacter = ' ') then
                Error('%1 cannot contain consecutive spaces.', FieldName);

            if (Character = '-') and (PreviousCharacter = '-') then
                Error('%1 cannot contain consecutive hyphens.', FieldName);

            if (Character = '''') and (PreviousCharacter = '''') then
                Error('%1 cannot contain consecutive apostrophes.', FieldName);

            PreviousCharacter := Character;
        end;

        if (Name[1] in ['-', '''']) then
            Error('%1 cannot start with a hyphen or apostrophe.', FieldName);

        if (Name[StrLen(Name)] in ['-', '''']) then
            Error('%1 cannot end with a hyphen or apostrophe.', FieldName);
    end;

    local procedure ValidateIdentification(IdentificationNumber: Text[20]; FieldName: Text[20])
    var
        i: Integer;
    begin
        case Identificationtype of
            "IdentificationType"::"National ID":
                begin
                    //Length check
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
