table 50142 "Member Application Setup"
{
    Caption = 'Member Application Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
        }
        field(2; "Minimum Age"; Integer)
        {
            Caption = 'Minimum Age';
            MinValue = 0;
        }
        field(3; "Approval Required"; Boolean)
        {
            Caption = 'Approval Required';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
