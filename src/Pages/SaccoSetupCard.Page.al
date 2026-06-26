page 50202 "SACCO Setup Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SACCO Setup";
    Caption = 'SACCO Setup';

    layout
    {
        area(Content)
        {
            group(Numbering)
            {
                Caption = 'Numbering Series';
                field("Member Application Nos."; Rec."Member Application Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series code used to assign numbers to new member applications.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}