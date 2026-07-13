table 50325 "Member Application"
{
    Caption = 'Member Application';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        // application details
        field(2; "Full Name"; Text[100])
        {
            Caption = 'Full Name';
            NotBlank = true;
        }
        field(3; "Last Name"; Text[20])
        {
            Caption = 'Last Name';
        }
        field(4; DOB; Date)
        {
            Caption = 'DOB';
        }
        field(5; IDNO; Text[100])
        {
            Caption = 'ID NO';
        }
        // contact information
        field(6; PhoneNo; Text[100])
        {
            Caption = 'Phone No';
        }
        field(7; City; Text[100])
        {
            Caption = 'City';
        }
        field(8; "Email"; Text[100])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;
        }
        field(9; "Postal Code"; Text[20])
        {
            Caption = 'Postal Code';
        }
        field(10; "Address"; Text[100])
        {
            Caption = 'Address';
        }
        field(11; "Country"; Option)
        {
            Caption = 'Country';
            OptionMembers = Kenya,America,Australia,India,Rwanda,Uganda,Ethiopia,Japan,China;
            OptionCaption = 'Kenya,America,Australia,India,Rwanda,Uganda,Ethiopia,Japan,China';
        }
        // employment information
        field(12; "KRA PIN"; Code[40])
        {
            Caption = 'KRA PIN';
        }
        field(13; "Annual Income"; Code[100])
        {
            Caption = 'Annual Income';
        }
        field(14; "Member Category"; Option)
        {
            Caption = 'Member Category';
            OptionMembers = Staff,Diaspora,Corporate,SelfEmployed,Retired;
            OptionCaption = 'Staff,Diaspora,Corporate,Self Employed,Retired';
        }
        field(15; "Staff No."; Code[20])
        {
            Caption = 'Staff No.';
            DataClassification = CustomerContent;
        }
        field(16; "Department"; Code[20])
        {
            Caption = 'Department';
            DataClassification = CustomerContent;
        }
        field(17; "Company/BusinessName"; Code[100])
        {
            Caption = 'Company Name/Business Name';
            DataClassification = CustomerContent;
        }
        field(18; "Employment No"; Code[20])
        {
            Caption = 'Employment No';
            DataClassification = CustomerContent;
        }
        field(19; "Pension No"; Code[20])
        {
            Caption = 'Pension No';
            DataClassification = CustomerContent;
        }
        field(20; "Country of Residence"; Code[20])
        {
            Caption = 'Country of Residence';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(21; "Proof of Residence"; Blob)
        {
            Caption = 'Proof of Residence';
            DataClassification = CustomerContent;
            subtype = Bitmap;
        }
        field(22; "Proof of Residence File Name"; Text[100])
        {
            Caption = 'Proof of Residence File Name';
            DataClassification = CustomerContent;
        }
#pragma warning disable AA0139
        field(23; "Proof of Residence Base64"; Text[100])
        {
            Caption = 'Proof of Residence Base64';
            DataClassification = CustomerContent;
        }
#pragma warning restore AA0139
        field(24; "Business Certificate"; Blob)
        {
            Caption = 'Business Certificate';
            DataClassification = CustomerContent;
        }
        field(25; "Business Certificate File Name"; Text[100])
        {
            Caption = 'Business Certificate File Name';
            DataClassification = CustomerContent;
        }
#pragma warning disable AA0139
        field(26; "Business Certificate Base64"; Text[100])
        {
            Caption = 'Business Certificate Base64';
            DataClassification = CustomerContent;
        }
#pragma warning restore AA0139
        // status
        field(27; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Pending,Approved,Rejected;
            OptionCaption = 'Pending,Approved,Rejected';
        }
        field(28; "Application Date"; Date)
        {
            Caption = 'Application Date';
        }
        field(29; "Decision Date"; Date)
        {
            Caption = 'Decision Date';
        }
        field(30; "Decision By"; Text[100])
        {
            Caption = 'Decision By';
        }
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
        key(StatusKey; Status) { }
    }

    var
        ProofOfResidenceErr: Label 'Proof of residence must be attached for Diaspora members (utility bill not older than 3 months, driver''s license, resident/alien card, or valid employment contract).';
        BusinessCertificateErr: Label 'Business certificate must be attached for Self Employed members.';

    trigger OnInsert()
    begin
        if "No." = '' then
            "No." := GenerateNo();
        "Application Date" := Today();
        Status := Status::Pending;
        ProcessAttachments();
    end;

    trigger OnModify()
    begin
        ProcessAttachments();
    end;

    local procedure GenerateNo(): Code[20]
    var
        MemberApp: Record "Member Application";
        NewNo: Integer;
    begin
        MemberApp.SetFilter("No.", 'APP-*');
        if MemberApp.FindLast() then
            Evaluate(NewNo, CopyStr(MemberApp."No.", 5))
        else
            NewNo := 0;
        exit(StrSubstNo('APP-%1', Format(NewNo + 1, 5, '<Integer><Filler Character,0>')));
    end;

    procedure ValidateBeforeSubmit()
    begin
        ValidateCategoryRequirements();
    end;

    local procedure ValidateCategoryRequirements()
    begin
        case "Member Category" of
            "Member Category"::Staff:
                begin
                    TestField("Staff No.");
                    TestField(Department);
                end;
            "Member Category"::Diaspora:
                begin
                    TestField("Country of Residence");
                    TestField("Company/BusinessName");
                    if not "Proof of Residence".HasValue then
                        Error(ProofOfResidenceErr);
                end;
            "Member Category"::Corporate:
                begin
                    TestField("Company/BusinessName");
                    TestField("Employment No");
                end;
            "Member Category"::SelfEmployed:
                begin
                    TestField("Company/BusinessName");
                    if not "Business Certificate".HasValue then
                        Error(BusinessCertificateErr);
                end;
            "Member Category"::Retired:
                TestField("Pension No");
        end;
    end;

    local procedure ProcessAttachments()
    begin
        if "Proof of Residence Base64" <> '' then begin
            SetProofOfResidenceFromBase64("Proof of Residence Base64");
            "Proof of Residence Base64" := '';
        end;
        if "Business Certificate Base64" <> '' then begin
            SetBusinessCertificateFromBase64("Business Certificate Base64");
            "Business Certificate Base64" := '';
        end;
    end;

    local procedure SetProofOfResidenceFromBase64(Base64Content: Text)
    var
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        InStream: InStream;
        OutStream: OutStream;
    begin
        TempBlob.CreateOutStream(OutStream);
        Base64Convert.FromBase64(Base64Content, OutStream);
        TempBlob.CreateInStream(InStream);

        "Proof of Residence".CreateOutStream(OutStream);
        CopyStream(OutStream, InStream);
    end;

    local procedure SetBusinessCertificateFromBase64(Base64Content: Text)
    var
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        InStream: InStream;
        OutStream: OutStream;
    begin
        TempBlob.CreateOutStream(OutStream);
        Base64Convert.FromBase64(Base64Content, OutStream);
        TempBlob.CreateInStream(InStream);

        "Business Certificate".CreateOutStream(OutStream);
        CopyStream(OutStream, InStream);
    end;
}