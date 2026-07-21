page 50141 "Member Application Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Member Application Setup";
    Caption = 'Member Application Setup';

    layout
    {
        area(Content)
        {
            group(General)
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
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get('DEFAULT') then begin
            Rec.Init();
            Rec."Primary Key" := 'DEFAULT';
            Rec."Minimum Age" := 18;
            Rec."Approval Required" := true;
            Rec.Insert();
        end;
    end;
}
