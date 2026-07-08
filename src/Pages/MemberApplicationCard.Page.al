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
                field("No. Series"; Rec."No. Series") { ApplicationArea = All; }
            }

            group(Personal)
            {
                Caption = 'Personal Information';
                field("Title"; Rec."Title") { ApplicationArea = All; }
                field("First Name"; Rec."First Name") { ApplicationArea = All; }
                field("Middle Name"; Rec."Middle Name") { ApplicationArea = All; }
                field("Last Name"; Rec."Last Name") { ApplicationArea = All; }
                field("Gender"; Rec."Gender") { ApplicationArea = All; }
                field("Date of Birth"; Rec."Date of Birth") { ApplicationArea = All; }
                field("Marital Status"; Rec."Marital Status") { ApplicationArea = All; }
                field("Nationality"; Rec."Nationality") { ApplicationArea = All; }
            }

            group(Identification)
            {
                Caption = 'Identification';
                field("Identification Type"; Rec."Identification Type") { ApplicationArea = All; }
                field("ID/Passport No."; Rec."ID/Passport No.") { ApplicationArea = All; }
                field("KRA PIN"; Rec."KRA PIN") { ApplicationArea = All; }
                field("ID Issue Date"; Rec."ID Issue Date") { ApplicationArea = All; }
                field("Passport Expiry Date"; Rec."Passport Expiry Date") { ApplicationArea = All; }
            }

            group(Contact)
            {
                Caption = 'Contact Information';
                field("Phone No."; Rec."Phone No.") { ApplicationArea = All; }
                field("Email"; Rec."Email") { ApplicationArea = All; }
                field("Address"; Rec."Address") { ApplicationArea = All; }
                field("City"; Rec."City") { ApplicationArea = All; }
                field("County"; Rec."County") { ApplicationArea = All; }
                field("Postal Code"; Rec."Postal Code") { ApplicationArea = All; }
            }

            group(Employment)
            {
                Caption = 'Employment Information';
                field("Employment Status"; Rec."Employment Status") { ApplicationArea = All; }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = All;
                    // Dynamically locks based on your new Custom Enum value assignment
                    Editable = (Rec."Employment Status" = Rec."Employment Status"::Employed);
                }
                field("Job Title"; Rec."Job Title") { ApplicationArea = All; }
                field("Department"; Rec."Department") { ApplicationArea = All; }
                field("Payroll No."; Rec."Payroll No.") { ApplicationArea = All; }
                field("Monthly Gross Income"; Rec."Monthly Gross Income") { ApplicationArea = All; }
            }

            group(Membership)
            {
                Caption = 'Membership Information';
                field("Membership Date"; Rec."Membership Date") { ApplicationArea = All; }
                field("Branch Code"; Rec."Branch Code") { ApplicationArea = All; }
                field("Member Category"; Rec."Member Category") { ApplicationArea = All; }
                field("Introduced By"; Rec."Introduced By") { ApplicationArea = All; }
            }

            group(Financials)
            {
                Caption = 'SACCO Membership Profile';
                field("Monthly Contribution Target"; Rec."Monthly Contribution Target") { ApplicationArea = All; }
                field("Opening Shares"; Rec."Opening Shares") { ApplicationArea = All; }
                field("Initial Deposit"; Rec."Initial Deposit") { ApplicationArea = All; }
                field("Dividend Payout Method"; Rec."Dividend Payout Method") { ApplicationArea = All; }
                field("Risk Assessment Rating"; Rec."Risk Assessment Rating") { ApplicationArea = All; }
            }

            group(Beneficiaries)
            {
                Caption = 'Next of Kin / Beneficiary Details';
                field("Beneficiary Name"; Rec."Beneficiary Name") { ApplicationArea = All; }
                field("Beneficiary Relationship"; Rec."Beneficiary Relationship") { ApplicationArea = All; }
                field("Allocation %"; Rec."Allocation %") { ApplicationArea = All; }
            }

            group(Emergency)
            {
                Caption = 'Emergency Contact';
                field("Emergency Contact Name"; Rec."Emergency Contact Name") { ApplicationArea = All; }
                field("Emergency Contact Phone"; Rec."Emergency Contact Phone") { ApplicationArea = All; }
                field("Emergency Contact Relationship"; Rec."Emergency Contact Relationship") { ApplicationArea = All; }
            }

            group(Approvals)
            {
                Caption = 'Approval & Audit Trail';
                field("Application Status"; Rec."Application Status") { ApplicationArea = All; }
                field("Submitted By"; Rec."Submitted By") { ApplicationArea = All; }
                field("Submitted Date"; Rec."Submitted Date") { ApplicationArea = All; }
                field("Created By"; Rec."Created By") { ApplicationArea = All; }
                field("Date Created"; Rec."Date Created") { ApplicationArea = All; }
                field("Approved By"; Rec."Approved By") { ApplicationArea = All; }
                field("Approval Date"; Rec."Approval Date") { ApplicationArea = All; }
                field("Last Modified By"; Rec."Last Modified By") { ApplicationArea = All; }
                field("Last Modified Date"; Rec."Last Modified Date") { ApplicationArea = All; }
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
                    ToolTip = 'Approve this member application and generate a permanent member card.';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Enabled = (Rec."Application Status" = Rec."Application Status"::Open) or (Rec."Application Status" = Rec."Application Status"::Pending);

                    trigger OnAction()
                    var
                        MemberAppMgt: Codeunit "Member Application Management";
                    begin
                        // Execute field level validation constraints before prompting for approval confirmation
                        MemberAppMgt.ValidateApplicationForApproval(Rec);

                        if Confirm('Are you sure you want to approve this application?', false) then begin
                            Rec."Application Status" := Rec."Application Status"::Approved;
                            Rec."Approved By" := UserId;
                            Rec."Approval Date" := Today;
                            Rec.Modify(true);

                            // This codeunit function now handles creating the member AND sending the welcome email!
                            MemberAppMgt.CreatePermanentMember(Rec);

                            Message('Application approved successfully.');
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
                    begin
                        if Confirm('Are you sure you want to reject this application?', false) then begin
                            Rec."Application Status" := Rec."Application Status"::Rejected;
                            Rec.Modify(true);

                            Message('Application has been rejected.');
                        end;
                    end;
                }
            }
        }
    }
}

