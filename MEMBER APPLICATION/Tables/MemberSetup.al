table 50100 "Member Setup"

{

    Caption = 'Member Setup';
    DataClassification = CustomerContent;

    fields
    {

        field(10; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';

        }
        field(20; "Member No."; Code[20])
        {

            Caption = 'Member No.';
            TableRelation = "No. Series";

        }
        field(30; "Default Membership Fee"; Decimal)
        {

            Caption = 'Default Membership Fee';
            DecimalPlaces = 2 : 2;
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

