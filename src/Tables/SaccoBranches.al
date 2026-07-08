table 50204 "Sacco Branch"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Branch List";
    DrillDownPageId = "Branch List";

    fields
    {
        field(1; "Branch Code"; Code[20])
        { DataClassification = ToBeClassified; }
        field(2; "Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Branch Code")
        {
            Clustered = true;
        }
    }

}