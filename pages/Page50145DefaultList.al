page 50145 "Default"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Member Application Setup";
    CardPageId = "Member Application setup";
    Caption = 'Default';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Primary Key"; Rec."Primary Key")
                {
                    Editable = true;
                }
                //age approval
                field("Minimum Age"; Rec."Minimum Age")
                {
                    ToolTip = 'Set the minimum age allowed for a new member application.';
                }
                //Enable and disable approvals for regular page
                field("Approval Required"; Rec."Approval Required")
                {
                    ToolTip = 'Enable or disable manual approval workflow for member applications.';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}