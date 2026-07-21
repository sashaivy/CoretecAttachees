
table 50144 "Rejection Reason Buffer"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Reason"; Text[100])
        {
        }
    }

    keys
    {
        key(PK; "Reason")
        {
            Clustered = true;
        }
    }
}
