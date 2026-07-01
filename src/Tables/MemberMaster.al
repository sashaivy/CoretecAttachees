table 50202 "Member"
{
    DataClassification = ToBeClassified;
    Caption = 'Member Master';

    fields
    {
        // ==========================================
        // 1. General & Personal Information
        // ==========================================
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Member No.';
        }
        field(2; "No. Series"; Code[20]) { TableRelation = "No. Series"; Editable = false; }
        field(3; "Title"; Enum "Title") { DataClassification = ToBeClassified; }
        field(4; "First Name"; Text[50]) { DataClassification = ToBeClassified; }
        field(5; "Middle Name"; Text[50]) { DataClassification = ToBeClassified; }
        field(6; "Last Name"; Text[50]) { DataClassification = ToBeClassified; }
        field(7; "Gender"; Enum "Gender") { DataClassification = ToBeClassified; }
        field(8; "Date of Birth"; Date) { DataClassification = ToBeClassified; }
        field(9; "Marital Status"; Enum "Marital Status") { DataClassification = ToBeClassified; }
        field(10; "Nationality"; Text[50]) { DataClassification = ToBeClassified; }

        // ==========================================
        // 2. Identification Details
        // ==========================================
        field(15; "Identification Type"; Enum "Identification Type") { DataClassification = ToBeClassified; }
        field(16; "ID/Passport No."; Code[20]) { DataClassification = ToBeClassified; }
        field(17; "KRA PIN"; Code[20]) { DataClassification = ToBeClassified; }

        // ==========================================
        // 3. Contact Details
        // ==========================================
        field(20; "Phone No."; Code[20]) { DataClassification = ToBeClassified; }
        field(21; "Email"; Text[80]) { DataClassification = ToBeClassified; }
        field(22; "Address"; Text[100]) { DataClassification = ToBeClassified; }
        field(23; "City"; Text[50]) { DataClassification = ToBeClassified; }
        field(24; "County"; Text[50]) { DataClassification = ToBeClassified; }
        field(25; "Postal Code"; Code[20]) { DataClassification = ToBeClassified; TableRelation = "Post Code"; }

        // ==========================================
        // 4. Employment Profile
        // ==========================================
        field(30; "Employment Status"; Enum "Employment Status") { DataClassification = ToBeClassified; }
        field(31; "Employer Name"; Text[100]) { DataClassification = ToBeClassified; }
        field(32; "Job Title"; Text[50]) { DataClassification = ToBeClassified; }
        field(33; "Department"; Text[50]) { DataClassification = ToBeClassified; }
        field(34; "Payroll No."; Code[20]) { DataClassification = ToBeClassified; }

        // ==========================================
        // 5. Membership Management
        // ==========================================
        field(40; "Status"; Option)
        {
            OptionMembers = Active,Awaiting,Dormant,Withdrawn,Deceased;
            OptionCaption = 'Active,Awaiting,Dormant,Withdrawn,Deceased';
        }
        field(41; "Membership Date"; Date) { DataClassification = ToBeClassified; }
        field(42; "Branch Code"; Code[20]) { DataClassification = ToBeClassified; }
        field(43; "Member Category"; Enum "Membership Type") { DataClassification = ToBeClassified; }

        // ==========================================
        // 6. Account Metrics (FlowFields for calculations)
        // ==========================================
        field(50; "Monthly Contribution Target"; Decimal) { DataClassification = ToBeClassified; MinValue = 0; }
        field(51; "Dividend Payout Method"; Enum "Dividend Payout Method") { DataClassification = ToBeClassified; }

        // These fields are placeholders where you can build FlowFields later to total ledger entries
        field(52; "Current Shares"; Decimal) { Editable = false; }
        field(53; "Total Deposits"; Decimal) { Editable = false; }
        field(54; "Outstanding Loans"; Decimal) { Editable = false; }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}