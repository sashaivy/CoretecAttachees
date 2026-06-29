page 50350 "Member Application Card"
{
    ApplicationArea = All;
    Caption = 'Member Application Card';
    PageType = Card;
    SourceTable = "Member application table";
    UsageCategory = administration;

    layout
    {
        area(Content)
        {
            group(GeneralInformation)
            {
                field("Application no."; Rec."Application no.")
                {
                }
                field("Application Date"; Rec."Application Date")
                {
                }
                field("Application Status"; Rec."Status")
                {
                }
            }
            group(PersonalInformation)
            {
                field("First Name"; Rec."First Name")
                {
                }
                field("Middle Name"; Rec."Middle Name")
                {
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                }
                field("National Id"; Rec."National Id")
                {
                }
            }
            group(ContactInformation)
            {
                field("Phone no."; Rec."Phone no.")
                {
                }
                field(Email; Rec.Email)
                {
                }


            }
            group(EmploymentInformation)
            {
                field(Occupation; Rec.Occupation)
                {
                }
                field("Monthly Income"; Rec."Monthly Income")
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Approval)
            {
                image = Approve;

                trigger OnAction()
                begin
                    Rec."Status" := Rec."Status"::Approved;
                end;
            }
            action(Reject)
            {
                image = Reject;

                trigger OnAction()
                begin
                    Rec."Status" := Rec."Status"::Rejected;
                end;
            }
        }
        area(Promoted)
        {
            actionref(Approve; Approval)
            {
            }
            actionref(Rejected; Reject)
            {
            }
        }
    }

}