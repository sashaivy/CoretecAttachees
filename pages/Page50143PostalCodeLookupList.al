page 50143 "Postal Code Lookup List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Post Code";
    Caption = 'Postal Code Lookup';

    layout
    {
        //To autofill phone number prefix based on country entered
        area(Content)
        {
            repeater(Group)
            {
                field("Country/Regioncode"; rec."Country/Region code")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                //field("Phone Prefix"; Rec."Phone Prefix")
                //{
                // ApplicationArea = All;
                // }
            }
        }
    }
}
