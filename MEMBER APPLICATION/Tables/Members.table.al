table 50101 "Members"
{
    Caption = 'Members';
    DataClassification = CustomerContent;


    fields
    { //Auto-generated fields insertion point - do not remove
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            trigger OnValidate()
            var
                MemberSetup: Record "Member Setup";
                NoSeriesMgt: Codeunit NoSeriesManagement;
            begin
                if "No." <> xRec."No." then begin
                    MemberSetup.Get();
                    MemberSetup.TestField("Member No.");
                    NoSeriesMgt.TestManual(MemberSetup."Member No.");
                    "No. Series" := '';
                end;
            end;

        }
        //Autogenerate Numbers
        field(2; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            Editable = false;
        }
        // Identification details
        field(3; "First Name"; Text[15])
        {
            Caption = 'First Name';
        }
        field(4; "Last Name"; Text[15])
        {
            Caption = 'Last Name';
        }
        field(5; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
        }
        field(6; "Sex"; Option)
        {
            Caption = 'Sex';
            OptionMembers = Male,Female,Other,RatherNotSay;
        }

        field(9; "Nationality"; Text[20])
        {
            Caption = 'Nationality';
        }
        field(10; "National ID No."; Code[20])
        {
            Caption = 'National ID No.';
        }
        field(11; "City/Town of Residence"; Text[100])
        {
            Caption = 'City/Town of Residence';
        }
        field(12; "County"; Text[50])
        {
            Caption = 'County';
        }
        field(13; "Estate"; Text[50])
        {
            Caption = 'Estate';

        }
        field(14; "Application Date"; Date)
        {
            Caption = 'Application Date';
            Editable = false;
        }
        field(15; "Employment Status"; Option)
        {
            Caption = 'Employment Status';
            OptionMembers = Employed,SelfEmployed,PartTime,Student,StillSearching;
            Editable = false;
        }
        field(16; "Place of Work"; Text[20]
        )
        {
            Caption = 'Place of Work';
        }
        field(17; "Job Description"; Text[100])
        {
            Caption = 'Job Description';
        }
        field(18; "Application Type"; Option)
        {
            Caption = 'Application type';
            OptionMembers = New,Renewal,Replacement,Amendment;
            Editable = false;
        }
        field(19; "Marital Status"; Option)
        {
            Caption = 'Marital Status';
            OptionMembers = Single,Married,Divorced,Widowed,Other;

        }
        //Contacts Information
        field(20; "Contact No."; Code[30])
        {
            Caption = 'Contact No.';
        }
        field(21; "Email Address"; Text[50])
        {
            Caption = 'Email Address';

        }
        field(22; "Postal Address"; Text[100])
        {
            Caption = 'Postal Address';
        }
        field(23; "KRA Pin"; Code[20])
        {
            Caption = 'KRA Pin';
        }
        field(24; "Register"; Boolean)
        {
            Caption = 'Register?';
            Editable = false;

        }
        field(25; "Next of kin"; Text[15])
        {
            Caption = 'Next of kin';
        }
        field(26; "Relationship"; Option)
        {
            Caption = 'Relationship';
            OptionMembers = Parent,Child,Sibling,Relative;
        }
        field(27; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = New,Active,Renewal,Existing;
        }
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
    }

    trigger OnInsert()
    var
        MemberSetup: Record "Member Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if "No." = '' then begin
            MemberSetup.Get();
            MemberSetup.TestField("Member No.");
            NoSeriesMgt.InitSeries(MemberSetup."Member No.", xRec."No. Series", "Application Date", "No.", "No. Series");
        end;
        "Application Date" := Today();
    end;



}

