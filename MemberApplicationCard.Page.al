page 50331 "Member Application Card"
{
    Caption = 'Member Application';
    PageType = Card;
    SourceTable = "Member Application";
    UsageCategory = Documents;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Application Details';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
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
            }
            group(Generalinformation)
            {
                Caption = 'Contact Information';
                field("Phone No."; Rec.PhoneNo)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Country"; Rec."Country")
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
                field("Email"; Rec."Email")
                {
                    ApplicationArea = All;
                }
            }

            group(employmentinformation)
            {
                Caption = 'Employment Information';
                field("KRA PIN"; Rec."KRA PIN")
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

                    trigger OnValidate()
                    begin
                        UpdateFieldVisibility();
                    end;
                }
            }

            group(StaffDetails)
            {
                Caption = 'Staff Details';
                Visible = IsStaff;

                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
            }

            group(DiasporaDetails)
            {
                Caption = 'Diaspora Details';
                Visible = IsDiaspora;

                field("Country of Residence"; Rec."Country of Residence")
                {
                    ApplicationArea = All;
                }
                field("Company/BusinessName"; Rec."Company/BusinessName")
                {
                    ApplicationArea = All;
                }
                field("Proof of Residence File Name"; Rec."Proof of Residence File Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(CorporateDetails)
            {
                Caption = 'Corporate Details';
                Visible = IsCorporate;

                field("Company/BusinessName2"; Rec."Company/BusinessName")
                {
                    ApplicationArea = All;
                    Caption = 'Company/Business Name';
                }
                field("Employment No"; Rec."Employment No")
                {
                    ApplicationArea = All;
                }
            }

            group(SelfEmployedDetails)
            {
                Caption = 'Self Employed Details';
                Visible = IsSelfEmployed;

                field("Company/BusinessName3"; Rec."Company/BusinessName")
                {
                    ApplicationArea = All;
                    Caption = 'Company/Business Name';
                }
                field("Business Certificate File Name"; Rec."Business Certificate File Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(RetiredDetails)
            {
                Caption = 'Retired Details';
                Visible = IsRetired;

                field("Pension No"; Rec."Pension No")
                {
                    ApplicationArea = All;
                }
            }

            group(StatusGroup)
            {
                Caption = 'Status';

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StatusStyle;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Decision Date"; Rec."Decision Date")
                {
                    ApplicationArea = All;
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
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = Rec.Status = Rec.Status::Pending;

                trigger OnAction()
                var
                    MemberAppMgt: Codeunit "Member Application Mgt";
                begin
                    Rec.ValidateBeforeSubmit();
                    if not Confirm('Approve application for %1?\n\nAn approval email will be sent to: %2', true, Rec."Full Name", Rec.Email) then
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
                    if not Confirm('Reject application for %1?\n\nA rejection email will be sent to: %2', true, Rec."Full Name", Rec.Email) then
                        exit;
                    MemberAppMgt.RejectMember(Rec);
                    CurrPage.Update();
                end;
            }
            action(UploadProofOfResidence)
            {
                Caption = 'Upload Proof of Residence';
                ApplicationArea = All;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                Visible = IsDiaspora;

                trigger OnAction()
                var
                    InStream: InStream;
                    OutStream: OutStream;
                    FileName: Text;
                begin
                    if not UploadIntoStream('Select Proof of Residence', '', '', FileName, InStream) then
                        exit;

                    Rec."Proof of Residence".CreateOutStream(OutStream);
                    CopyStream(OutStream, InStream);
                    Rec."Proof of Residence File Name" := CopyStr(FileName, 1, MaxStrLen(Rec."Proof of Residence File Name"));
                    Rec.Modify(true);
                    CurrPage.Update(false);
                end;
            }
            action(DownloadProofOfResidence)
            {
                Caption = 'Download Proof of Residence';
                ApplicationArea = All;
                Image = Download;
                Visible = IsDiaspora;

                trigger OnAction()
                var
                    InStream: InStream;
                begin
                    Rec.CalcFields("Proof of Residence");
                    if not Rec."Proof of Residence".HasValue then
                        Error('No file attached.');
                    Rec."Proof of Residence".CreateInStream(InStream);
                    DownloadFromStream(InStream, '', '', '', Rec."Proof of Residence File Name");
                end;
            }
            action(UploadBusinessCertificate)
            {
                Caption = 'Upload Business Certificate';
                ApplicationArea = All;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                Visible = IsSelfEmployed;

                trigger OnAction()
                var
                    InStream: InStream;
                    OutStream: OutStream;
                    FileName: Text;
                begin
                    if not UploadIntoStream('Select Business Certificate', '', '', FileName, InStream) then
                        exit;

                    Rec."Business Certificate".CreateOutStream(OutStream);
                    CopyStream(OutStream, InStream);
                    Rec."Business Certificate File Name" := CopyStr(FileName, 1, MaxStrLen(Rec."Business Certificate File Name"));
                    Rec.Modify(true);
                    CurrPage.Update(false);
                end;
            }
            action(DownloadBusinessCertificate)
            {
                Caption = 'Download Business Certificate';
                ApplicationArea = All;
                Image = Download;
                Visible = IsSelfEmployed;

                trigger OnAction()
                var
                    InStream: InStream;
                begin
                    Rec.CalcFields("Business Certificate");
                    if not Rec."Business Certificate".HasValue then
                        Error('No file attached.');
                    Rec."Business Certificate".CreateInStream(InStream);
                    DownloadFromStream(InStream, '', '', '', Rec."Business Certificate File Name");
                end;
            }
        }
        area(Navigation)
        {
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

        UpdateFieldVisibility();
    end;

    local procedure UpdateFieldVisibility()
    begin
        IsStaff := Rec."Member Category" = Rec."Member Category"::Staff;
        IsDiaspora := Rec."Member Category" = Rec."Member Category"::Diaspora;
        IsCorporate := Rec."Member Category" = Rec."Member Category"::Corporate;
        IsSelfEmployed := Rec."Member Category" = Rec."Member Category"::SelfEmployed;
        IsRetired := Rec."Member Category" = Rec."Member Category"::Retired;
    end;

    var
        StatusStyle: Text;
        IsStaff, IsDiaspora, IsCorporate, IsSelfEmployed, IsRetired : Boolean;
}