table 50143 "Postal Code Lookup"
{
    Caption = 'Postal Code Lookup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Postal Code';
        }
        field(2; City; Text[20])
        {
            Caption = 'City';
        }
        field(3; Country; Code[10])
        {
            Caption = 'Country';
            TableRelation = "Country/Region";
            trigger OnValidate()
            begin
                NormalizeCountry();
            end;
        }
        field(4; "Phone Prefix"; Text[10])
        {
            Caption = 'Phone Prefix';
        }
    }

    keys
    {
        key(PK; Country, City)
        {
            Clustered = true;
        }
        key(PostalCode; "Code")
        {
        }
    }
    //consistency and validity of country entered
    trigger OnInsert()
    begin
        NormalizeCountry();
    end;

    trigger OnModify()
    begin
        NormalizeCountry();
    end;

    local procedure NormalizeCountry()
    var
        CountryRec: Record "Country/Region";
    begin
        if Country = '' then
            exit;
        if CountryRec.Get(Country) then
            exit;
        CountryRec.SetRange(Name, Country);
        if CountryRec.FindFirst() then
            Country := CountryRec.Code;
    end;
}
