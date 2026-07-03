page 50131 "Member Application Card"
{
    PageType = Card;
    Caption = 'Member Application';
    SourceTable = "Member Application";
    UsageCategory = Documents;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(GeneralInformation)
            {
                Caption = 'General Information';

                field("Application ID"; Rec."Application ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique ID of the member application.';
                    Editable = true;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date the application was submitted.';
                    Editable = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current status of the application.';
                    Editable = true;

                }
            }

            group(PersonalInformation)
            {
                Caption = 'Personal Information';

                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the first name of the applicant.';
                    Editable = true;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of birth of the applicant.';
                    Editable = true;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last name of the applicant.';
                    Editable = true;
                }
                field("ID/Passport Number"; Rec."ID/Passport Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID or passport number of the applicant.';
                    Editable = true;
                }
            }

            group(ContactInformation)
            {
                Caption = 'Contact Information';

                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the phone number of the applicant.';
                    Editable = true;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the city of residence.';
                    Editable = true;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the email address of the applicant.';
                    Editable = true;
                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the postal code.';
                    Editable = true;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the physical address of the applicant.';
                    Editable = true;
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the country of the applicant.';
                    Editable = true;
                }
            }

            group(EmploymentInformation)
            {
                Caption = 'Employment Information';

                field("Occupation Code"; Rec."Occupation Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the occupation of the applicant.';
                    Editable = true;
                }
                field("Member Category"; Rec."Member Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the membership category.';
                    Editable = true;
                }
                field("Annual Income"; Rec."Annual Income")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the annual income of the applicant.';
                    Editable = true;
                }
            }

            group(ApprovalInformation)
            {
                Caption = 'Approval Information';

                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date the application was approved or rejected.';
                    Editable = true;
                }
                field("Rejection Reason"; Rec."Rejection Reason")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reason for rejection if applicable.';
                    Editable = false;
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
                ToolTip = 'Approve this member application.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = CanApprove;

                trigger OnAction()
                begin
                    ApproveApplication();
                    UpdatePageControls();
                    CurrPage.Update(false);
                end;
            }

            action(Reject)
            {
                Caption = 'Reject';
                ApplicationArea = All;
                Image = Reject;
                ToolTip = 'Reject this member application.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = CanReject;

                trigger OnAction()
                begin
                    RejectApplication();
                    UpdatePageControls();
                    CurrPage.Update(false);
                end;
            }
            action(TransferToMember)
            {
                Caption = 'Transfer to Member';
                ApplicationArea = All;
                Image = TransferToGeneralJournal;
                ToolTip = 'Transfer this approved application to the Member register.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = CanTransfer;

                trigger OnAction()
                var
                    MemberTransferCU: Codeunit "Member Application Transfer";
                begin
                    MemberTransferCU.TransferToMember(Rec);
                    UpdatePageControls();
                    CurrPage.Update(false);
                end;
            }

        }
    }

    var
        IsEditable: Boolean;
        CanApprove: Boolean;
        CanReject: Boolean;
        CanTransfer: Boolean;
        StatusStyleExpr: Text;

    local procedure ApproveApplication()
    var
        MemberEmailCU: Codeunit "Member Application Email";
    begin
        Rec.Status := Rec.Status::Approved;
        Rec."Approval Date" := Today();
        Rec.Modify(true);

        // Call your email codeunit after saving
        MemberEmailCU.SendApprovalEmail(Rec);
    end;

    local procedure RejectApplication()
    var
        MemberEmailCU: Codeunit "Member Application Email";
    begin
        Rec.Status := Rec.Status::Rejected;
        Rec."Approval Date" := Today();
        Rec.Modify(true);

        // Call your email codeunit after saving
        MemberEmailCU.SendRejectionEmail(Rec);
    end;
    // start
    trigger OnAfterGetRecord()
    begin
        UpdatePageControls();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UpdatePageControls();
    end;

    local procedure UpdatePageControls()
    begin
        IsEditable := Rec.Status = Rec.Status::Pending;
        CanApprove := Rec.Status = Rec.Status::Pending;
        CanReject := Rec.Status = Rec.Status::Pending;

        // Transfer only active when Approved AND not yet transferred
        CanTransfer := (Rec.Status = Rec.Status::Approved) and
                       (not Rec."Transferred to Member");

        case Rec.Status of
            Rec.Status::Pending:
                StatusStyleExpr := 'Ambiguous';
            Rec.Status::Approved:
                StatusStyleExpr := 'Favorable';
            Rec.Status::Rejected:
                StatusStyleExpr := 'Unfavorable';
        end;
    end;
}