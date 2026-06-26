page 50201 "Member Application Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Member Application";
    Caption = 'New Member Application';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General Information';
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                }
                field("First Name"; Rec."First Name") { ApplicationArea = All; }
                field("Last Name"; Rec."Last Name") { ApplicationArea = All; }
                field("ID/Passport No."; Rec."ID/Passport No.") { ApplicationArea = All; }
                field("Email"; Rec."Email") { ApplicationArea = All; }
            }

            group(Employment)
            {
                Caption = 'Employment Information';
                field("Employment Status"; Rec."Employment Status") { ApplicationArea = All; }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = All;
                    Editable = (Rec."Employment Status" = Rec."Employment Status"::Employed);
                }
                field("Job Title"; Rec."Job Title") { ApplicationArea = All; }
                field("Monthly Gross Income"; Rec."Monthly Gross Income") { ApplicationArea = All; }
            }

            group(Financials)
            {
                Caption = 'SACCO Membership Profile';
                field("Monthly Contribution Target"; Rec."Monthly Contribution Target") { ApplicationArea = All; }
                field("Dividend Payout Method"; Rec."Dividend Payout Method") { ApplicationArea = All; }
            }

            group(Beneficiaries)
            {
                Caption = 'Next of Kin / Beneficiary Details';
                field("Beneficiary Name"; Rec."Beneficiary Name") { ApplicationArea = All; }
                field("Beneficiary Relationship"; Rec."Beneficiary Relationship") { ApplicationArea = All; }
                field("Allocation %"; Rec."Allocation %") { ApplicationArea = All; }
            }

            group(Approvals)
            {
                Caption = 'Approval & Audit Trail';
                field("Application Status"; Rec."Application Status") { ApplicationArea = All; }
                field("Created By"; Rec."Created By") { ApplicationArea = All; }
                field("Date Created"; Rec."Date Created") { ApplicationArea = All; }
                field("Approved By"; Rec."Approved By") { ApplicationArea = All; }
                field("Approval Date"; Rec."Approval Date") { ApplicationArea = All; }
                field("Rejection Reason"; Rec."Rejection Reason")
                {
                    ApplicationArea = All;
                    Editable = (Rec."Application Status" = Rec."Application Status"::Rejected);
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("Approval Actions")
            {
                Caption = 'Approval';
                Image = Approval;

                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    ToolTip = 'Approve this member application and send an email notification.';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Enabled = (Rec."Application Status" = Rec."Application Status"::Open) or (Rec."Application Status" = Rec."Application Status"::Pending);

                    trigger OnAction()
                    var
                        EmailMessage: Codeunit "Email Message";
                        Email: Codeunit "Email";
                        TypeHelper: Codeunit "Type Helper"; // Fixes formatting
                        Subject: Text;
                        Body: Text;
                        NewLine: Text;
                    begin
                        if Confirm('Are you sure you want to approve this application?', false) then begin
                            // Updates your proper tracking fields
                            Rec."Application Status" := Rec."Application Status"::Approved;
                            Rec."Approved By" := UserId;
                            Rec."Approval Date" := Today;
                            Rec.Modify(true);

                            if Rec.Email <> '' then begin
                                NewLine := TypeHelper.NewLine();
                                Subject := StrSubstNo('SACCO Application %1 - APPROVED', Rec."Application No.");

                                // Refined email string concatenation using system line breaks
                                Body := StrSubstNo('Dear %1 %2,', Rec."First Name", Rec."Last Name") + NewLine + NewLine +
                                        StrSubstNo('We are pleased to inform you that your SACCO application %1 has been successfully approved!', Rec."Application No.") + NewLine + NewLine +
                                        'Regards,' + NewLine +
                                        'Management Team';

                                EmailMessage.Create(Rec.Email, Subject, Body, true);
                                Email.Send(EmailMessage);
                            end;

                            Message('Application approved and notification sent successfully.');
                        end;
                    end;
                }

                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    ToolTip = 'Reject this member application.';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Enabled = (Rec."Application Status" = Rec."Application Status"::Open) or (Rec."Application Status" = Rec."Application Status"::Pending);

                    trigger OnAction()
                    var
                        EmailMessage: Codeunit "Email Message";
                        Email: Codeunit "Email";
                        TypeHelper: Codeunit "Type Helper"; // Fixes formatting
                        Subject: Text;
                        Body: Text;
                        NewLine: Text;
                    begin
                        if Confirm('Are you sure you want to reject this application?', false) then begin
                            Rec."Application Status" := Rec."Application Status"::Rejected;
                            Rec.Modify(true);

                            if Rec.Email <> '' then begin
                                NewLine := TypeHelper.NewLine();
                                Subject := StrSubstNo('SACCO Application %1 - REJECTED', Rec."Application No.");

                                // Refined email string concatenation using system line breaks
                                Body := StrSubstNo('Dear %1 %2,', Rec."First Name", Rec."Last Name") + NewLine + NewLine +
                                        StrSubstNo('We regret to inform you that your SACCO application %1 has been rejected.', Rec."Application No.") + NewLine + NewLine +
                                        'Regards,' + NewLine +
                                        'Management Team';

                                EmailMessage.Create(Rec.Email, Subject, Body, true);
                                Email.Send(EmailMessage);
                            end;

                            Message('Application has been rejected.');
                        end;
                    end;
                }
            }
        }
    }
}

