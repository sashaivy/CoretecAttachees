table 50313 "Member Application"
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
        field(4; DOB; Text[100])
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
        field(11; "Country"; Text[100])
        {
            Caption = 'Country';
        }
        //employmanet information
        field(12; "Occupation Code"; code[40])
        {
            Caption = 'Occupation Code';
        }
        field(13; "Annual Income"; code[100])
        {
            Caption = 'Annual Income';
        }
        field(14; "Member Category"; Text[40])
        {
            caption = 'Member Category';
        }
        //status
        field(15; "status"; Option)
        {
            Caption = 'status';
            OptionMembers = Pending,Approved,Rejected;
            OptionCaption = 'Pending,Approved,Rejected';
        }
        field(16; "Application Date"; Date)
        {
            Caption = 'Application Date';
        }
        field(17; "Decision Date"; Date)
        {
            Caption = 'Decision Date';
        }
        field(18; "Decision By"; Text[100])
        {
            Caption = 'Decision By';
        }


    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
        key(StatusKey; Status) { }
    }

    trigger OnInsert()
    begin
        if "No." = '' then
            "No." := GenerateNo();
        "Application Date" := Today();
        Status := Status::Pending;
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
}
