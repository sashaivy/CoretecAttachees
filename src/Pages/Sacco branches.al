page 50206 "Branch List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sacco Branch";
    Caption = 'Sacco Branch List';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the branch.';
                }
                field("Name"; Rec."Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the full description name of the branch.';

                }


            }
        }
    }
}