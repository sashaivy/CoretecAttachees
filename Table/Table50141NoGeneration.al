table 50141 "Daily Counter"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Date; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Last No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Date)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}