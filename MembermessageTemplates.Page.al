page 50319 "Member Message Templates"
{
    Caption = 'Member Message Templates';
    PageType = List;
    SourceTable = "Member Message Template";
    UsageCategory = Administration;
    ApplicationArea = All;
    CardPageId = "Member Message Template Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Template Type"; Rec."Template Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Approval or Rejection.';
                }
                field("Email Subject"; Rec."Email Subject")
                {
                    ApplicationArea = All;
                    ToolTip = 'Email subject line.';
                }
                field("Last Modified By"; Rec."Last Modified By")
                {
                    ApplicationArea = All;
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ResetAllDefaults)
            {
                Caption = 'Reset All to Default';
                ApplicationArea = All;
                Image = Restore;
                ToolTip = 'Reset both approval and rejection templates to built-in defaults.';

                trigger OnAction()
                var
                    MemberAppMgt: Codeunit "Member Application Mgt";
                begin
                    if not Confirm('Reset ALL templates to defaults? Your current messages will be lost.', false) then
                        exit;
                    MemberAppMgt.InitDefaultTemplates();
                    CurrPage.Update();
                    Message('✅ All templates reset to defaults.');
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        MemberAppMgt: Codeunit "Member Application Mgt";
    begin
        MemberAppMgt.EnsureTemplatesExist();
    end;
}
