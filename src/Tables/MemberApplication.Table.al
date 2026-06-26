table 50201 "Member Application"
{
    DataClassification = ToBeClassified;
    Caption = 'Member Application';

    fields
    {
        // Primary Key & General Infrastructure
        field(1; "Application No."; Code[20])

        {
            DataClassification = ToBeClassified;
            Caption = 'Application No.';

            trigger OnValidate()
            var
                SaccoSetup: Record "SACCO Setup";
                NoSeries: Codeunit "No. Series"; // Modern codeunit
            begin
                if "Application No." <> xRec."Application No." then begin
                    SaccoSetup.Get();
                    NoSeries.TestManual(SaccoSetup."Member Application Nos."); // Modern method call
                    "No. Series" := '';
                end;
            end;
        }



        field(2; "First Name"; Text[50]) { DataClassification = ToBeClassified; }
        field(3; "Last Name"; Text[50]) { DataClassification = ToBeClassified; }
        field(4; "ID/Passport No."; Code[20]) { DataClassification = ToBeClassified; }
        field(5; "Email"; Text[80])
        {
            DataClassification = ToBeClassified;
            Caption = 'Email';

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                if Rec.Email <> '' then begin
                    // Uses BC's built-in public helper to validate standard email formats cleanly
                    MailManagement.CheckValidEmailAddress(Rec.Email);
                end;
            end;
        }

        // Employment Information Group
        field(6; "Employment Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Unemployed,Employed,SelfEmployed,Contractor;
            Caption = 'Employment Status';
        }
        field(7; "Employer Name"; Text[100]) { DataClassification = ToBeClassified; }
        field(8; "Job Title"; Text[50]) { DataClassification = ToBeClassified; }
        field(9; "Monthly Gross Income"; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;
        }

        // Financial & Niche SACCO Info
        field(10; "Monthly Contribution Target"; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(11; "Dividend Payout Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Capitalize to Shares","Bank Transfer","Mobile Money","Retain on Deposits";
        }
        field(12; "Risk Assessment Rating"; Option) { OptionMembers = Low,Medium,High; }

        // Beneficiary Info
        field(20; "Beneficiary Name"; Text[100]) { DataClassification = ToBeClassified; }
        field(21; "Beneficiary Relationship"; Text[30]) { DataClassification = ToBeClassified; }
        field(22; "Allocation %"; Decimal) { MaxValue = 100; MinValue = 0; }

        // Approval & Audit Information Group
        field(30; "Application Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Pending,Approved,Rejected;
            Editable = false;
        }
        field(31; "Date Created"; Date) { Editable = false; }
        field(32; "Created By"; Code[50]) { Editable = false; }
        field(33; "Approved By"; Code[50]) { Editable = false; }
        field(34; "Approval Date"; Date) { Editable = false; }
        field(35; "Rejection Reason"; Text[150]) { DataClassification = ToBeClassified; }

        // Behind the scenes tracking
        field(40; "No. Series"; Code[20]) { TableRelation = "No. Series"; Editable = false; }


    }

    keys
    {
        key(PK; "Application No.")
        {
            Clustered = true;
        }
    }



    trigger OnInsert()
    var
        ModelMgt: Codeunit "Member Application Management";
    begin
        ModelMgt.InitNewApplication(Rec);
    end;
}