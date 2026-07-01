page 50315 "Member Application List"
{
    Caption = 'Member Applications';
    PageType = List;
    SourceTable = "Member Application";
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageId = "Member Application Card";
    Editable = false;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field(DOB; Rec.DOB)
                {
                    ApplicationArea = All;
                }
                field(IDNO; Rec.IDNO)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec.PhoneNo)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Email"; Rec."Email")
                {
                    ApplicationArea = All;
                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ApplicationArea = All;
                }
                field("Address"; Rec."Address")
                {
                    ApplicationArea = All;
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                }
                field("Occupation Code"; Rec."Occupation Code")
                {
                    ApplicationArea = All;
                }
                field("Annual Income"; Rec."Annual Income")
                {
                    ApplicationArea = All;
                }
                field("Member Category"; Rec."Member Category")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyle;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Decision Date"; Rec."Decision Date")
                {
                    ApplicationArea = All;
                }
                field("Decision By"; Rec."Decision By")
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
            action(Approve)
            {
                Caption = 'Approve';
                ApplicationArea = All;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = Rec.Status = Rec.Status::Pending;

                trigger OnAction()
                var
                    MemberAppMgt: Codeunit "Member Application Mgt";
                begin
                    if not Confirm('Approve application for %1?\n\nEmail will be sent to: %2', true, Rec."Full Name", Rec.Email) then
                        exit;
                    MemberAppMgt.ApproveMember(Rec);
                    CurrPage.Update();
                end;
            }
            action(Reject)
            {
                Caption = 'Reject';
                ApplicationArea = All;
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = Rec.Status = Rec.Status::Pending;

                trigger OnAction()
                var
                    MemberAppMgt: Codeunit "Member Application Mgt";
                begin
                    if not Confirm('Reject application for %1?\n\nEmail will be sent to: %2', true, Rec."Full Name", Rec.Email) then
                        exit;
                    MemberAppMgt.RejectMember(Rec);
                    CurrPage.Update();
                end;
            }
        }
        area(Navigation)
        {
            action(ShowPending)
            {
                Caption = 'Pending Only';
                ApplicationArea = All;
                Image = Filter;

                trigger OnAction()
                begin
                    Rec.SetRange(Status, Rec.Status::Pending);
                    CurrPage.Update();
                end;
            }
            action(ShowAll)
            {
                Caption = 'Show All';
                ApplicationArea = All;
                Image = ClearFilter;

                trigger OnAction()
                begin
                    Rec.SetRange(Status);
                    CurrPage.Update();
                end;
            }
            action(MessageTemplates)
            {
                Caption = 'Message Templates';
                ApplicationArea = All;
                Image = Email;
                RunObject = Page "Member Message Templates";
                ToolTip = 'Edit the approval and rejection email messages.';
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        case Rec.Status of
            Rec.Status::Pending:
                StatusStyle := 'Ambiguous';
            Rec.Status::Approved:
                StatusStyle := 'Favorable';
            Rec.Status::Rejected:
                StatusStyle := 'Unfavorable';
        end;
    end;

    var
        StatusStyle: Text;
}
