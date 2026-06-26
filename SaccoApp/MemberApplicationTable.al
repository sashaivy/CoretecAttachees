table 50107 "Member Application"
{
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Application No."; Code[20])
        {
            DataClassification = SystemMetadata;
        }

        field(2; "Full Name"; Text[100])
        {
        }

        field(3; "National ID No."; Code[20])
        {
        }

        field(4; "Phone No."; Text[20])
        {
        }

        field(5; "Email Address"; Text[100])
        {
        }

        field(6; "Date of Birth"; Date)
        {
        }

        field(7; Gender; Option)
        {
            OptionMembers = Male,Female,Other;
        }

        field(8; Address; Text[150])
        {
        }

        field(9; Occupation; Text[100])
        {
        }

        field(10; Employer; Text[100])
        {
        }

        field(11; "Next of Kin Name"; Text[100])
        {
        }

        field(12; "Next of Kin Phone"; Text[20])
        {
        }

        field(13; "Application Date"; Date)
        {
        }

        field(14; Status; Option)
        {
            OptionMembers = Open,Submitted,Approved,Rejected;
        }

        field(15; "Submitted By"; Code[50])
        {
        }
    }

    keys
    {
        key(PK; "Application No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "Application Date" = 0D then
            "Application Date" := Today;

        Status := Status::Open;
    end;
}
