table 50201 "Member Application"
{
    DataClassification = ToBeClassified;
    Caption = 'Member Application';

    fields
    {
        // ==========================================
        // 1. General Information (IDs 1 - 9)
        // ==========================================
        field(1; "Application No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Application No.';

            trigger OnValidate()
            var
                SaccoSetup: Record "SACCO Setup";
                NoSeries: Codeunit "No. Series";
            begin
                if "Application No." <> xRec."Application No." then begin
                    SaccoSetup.Get();
                    NoSeries.TestManual(SaccoSetup."Member Application Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "No. Series"; Code[20]) { TableRelation = "No. Series"; Editable = false; }

        // ==========================================
        // 2. Personal Information (IDs 10 - 29)
        // ==========================================
        field(9; "Title"; Enum "Title") { DataClassification = ToBeClassified; } // Added Title field
        field(10; "First Name"; Text[50]) { DataClassification = ToBeClassified; }
        field(11; "Middle Name"; Text[50]) { DataClassification = ToBeClassified; }
        field(12; "Last Name"; Text[50]) { DataClassification = ToBeClassified; }
        field(13; "Gender"; Enum "Gender") { DataClassification = ToBeClassified; } // Updated to Enum
        field(14; "Date of Birth"; Date) { DataClassification = ToBeClassified; }
        field(15; "Marital Status"; Enum "Marital Status") { DataClassification = ToBeClassified; } // Updated to Enum
        field(16; "Nationality"; Text[50]) { DataClassification = ToBeClassified; }

        // ==========================================
        // 3. Identification (IDs 30 - 39)
        // ==========================================
        field(29; "Identification Type"; Enum "Identification Type") { DataClassification = ToBeClassified; } // Added Ident. Type field
        field(30; "ID/Passport No."; Code[20]) { DataClassification = ToBeClassified; }
        field(31; "KRA PIN"; Code[20]) { DataClassification = ToBeClassified; }
        field(32; "ID Issue Date"; Date) { DataClassification = ToBeClassified; }
        field(33; "Passport Expiry Date"; Date) { DataClassification = ToBeClassified; }

        // ==========================================
        // 4. Contact Information (IDs 40 - 59)
        // ==========================================
        field(40; "Phone No."; Code[20]) { DataClassification = ToBeClassified; }
        field(41; "Email"; Text[80])
        {
            DataClassification = ToBeClassified;
            Caption = 'Email';

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                if Rec.Email <> '' then begin
                    MailManagement.CheckValidEmailAddress(Rec.Email);
                end;
            end;
        }
        field(42; "Address"; Text[100]) { DataClassification = ToBeClassified; }
        field(43; "City"; Text[50]) { DataClassification = ToBeClassified; }
        field(44; "County"; Text[50]) { DataClassification = ToBeClassified; }
        field(45; "Postal Code"; Code[20]) { DataClassification = ToBeClassified; TableRelation = "Post Code"; }

        // ==========================================
        // 5. Employment Information (IDs 60 - 79)
        // ==========================================
        field(60; "Employment Status"; Enum "Employment Status") // Updated to Enum
        {
            DataClassification = ToBeClassified;
            Caption = 'Employment Status';
        }
        field(61; "Employer Name"; Text[100]) { DataClassification = ToBeClassified; }
        field(62; "Job Title"; Text[50]) { DataClassification = ToBeClassified; }
        field(63; "Department"; Text[50]) { DataClassification = ToBeClassified; }
        field(64; "Payroll No."; Code[20]) { DataClassification = ToBeClassified; }
        field(65; "Monthly Gross Income"; Decimal) { DataClassification = ToBeClassified; MinValue = 0; }

        // ==========================================
        // 6. Membership Information (IDs 80 - 99)
        // ==========================================
        field(80; "Membership Date"; Date) { DataClassification = ToBeClassified; }
        field(81; "Branch Code"; Code[20]) { DataClassification = ToBeClassified; }
        field(82; "Member Category"; Enum "Membership Type") { DataClassification = ToBeClassified; } // Updated to Enum
        field(83; "Introduced By"; Code[20]) { DataClassification = ToBeClassified; }

        // ==========================================
        // 7. Financial Information (IDs 100 - 119)
        // ==========================================
        field(100; "Monthly Contribution Target"; Decimal) { DataClassification = ToBeClassified; MinValue = 0; }
        field(101; "Opening Shares"; Decimal) { DataClassification = ToBeClassified; MinValue = 0; }
        field(102; "Initial Deposit"; Decimal) { DataClassification = ToBeClassified; MinValue = 0; }
        field(103; "Dividend Payout Method"; Enum "Dividend Payout Method") { DataClassification = ToBeClassified; } // Updated to Enum
        field(104; "Risk Assessment Rating"; Enum "Risk Assessment Rating") { DataClassification = ToBeClassified; } // Updated to Enum

        // ==========================================
        // 8. Beneficiary Information (IDs 120 - 129)
        // ==========================================
        field(120; "Beneficiary Name"; Text[100]) { DataClassification = ToBeClassified; }
        field(121; "Beneficiary Relationship"; Text[30]) { DataClassification = ToBeClassified; }
        field(122; "Allocation %"; Decimal) { MaxValue = 100; MinValue = 0; }

        // ==========================================
        // 9. Emergency Contact (IDs 130 - 139)
        // ==========================================
        field(130; "Emergency Contact Name"; Text[100]) { DataClassification = ToBeClassified; }
        field(131; "Emergency Contact Phone"; Code[20]) { DataClassification = ToBeClassified; }
        field(132; "Emergency Contact Relationship"; Text[30]) { DataClassification = ToBeClassified; }

        // ==========================================
        // 10. Approval & Audit (IDs 140 - 159)
        // ==========================================
        field(140; "Application Status"; Enum "Application Status") // Updated to Enum
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(141; "Submitted By"; Code[50]) { Editable = false; }
        field(142; "Submitted Date"; Date) { Editable = false; }
        field(143; "Approved By"; Code[50]) { Editable = false; }
        field(144; "Approval Date"; Date) { Editable = false; }
        field(145; "Rejection Reason"; Text[150]) { DataClassification = ToBeClassified; }
        field(146; "Date Created"; Date) { Editable = false; }
        field(147; "Created By"; Code[50]) { Editable = false; }
        field(148; "Last Modified By"; Code[50]) { Editable = false; }
        field(149; "Last Modified Date"; Date) { Editable = false; }
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