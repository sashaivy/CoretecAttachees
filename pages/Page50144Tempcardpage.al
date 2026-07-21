page 50144 "Rejection Reason Dialog"
{
    PageType = StandardDialog;
    SourceTable = "Rejection Reason Buffer";
    Caption = 'Reject Application';

    layout
    {
        area(Content)
        {
            repeater(groupname)
            {
                field("Reason"; Rec."Reason")
                {
                    ApplicationArea = All;
                }
            }

        }
    }
}