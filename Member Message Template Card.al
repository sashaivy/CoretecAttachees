page 50321 "Member Message Template Card"
{
    Caption = 'Member Message Template';
    PageType = Card;
    SourceTable = "Member Message Template";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Template Info';

                field("Template Type"; Rec."Template Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Email Subject"; Rec."Email Subject")
                {
                    ApplicationArea = All;
                    ToolTip = 'Subject line of the email sent to the applicant.';
                }
                field("Last Modified By"; Rec."Last Modified By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(MessageGroup)
            {
                Caption = 'Email Message';

                field("Email Body"; Rec."Email Body")
                {
                    ApplicationArea = All;
                    Caption = 'Message Body';
                    MultiLine = true;
                    ToolTip = 'Write the full message. Use {Name} where the applicant name should appear.';
                }
            }
            group(HintGroup)
            {
                Caption = 'Placeholder Guide';

                field(HintText; HintLabel)
                {
                    ApplicationArea = All;
                    Caption = '';
                    Editable = false;
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ResetToDefault)
            {
                Caption = 'Reset to Default';
                ApplicationArea = All;
                Image = Restore;

                trigger OnAction()
                var
                    MemberAppMgt: Codeunit "Member Application Mgt";
                begin
                    if not Confirm('Reset this template to the default message? Your current message will be lost.', false) then
                        exit;
                    MemberAppMgt.ResetTemplate(Rec."Template Type");
                    CurrPage.Update();
                    Message('Template reset to default.');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        HintLabel := 'Available placeholder:' + NewLine +
                     '  {Name}  ->  Replaced with the applicant full name' + NewLine + NewLine +
                     'Example:' + NewLine +
                     '  Dear {Name}, your application has been approved...';
    end;

    var
        HintLabel: Text;
        NewLine: Text[1];

    trigger OnInit()
    begin
        NewLine[1] := 10;
    end;
}
