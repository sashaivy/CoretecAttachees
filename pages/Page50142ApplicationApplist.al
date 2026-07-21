page 50142 "Member Approval App. List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Member Application";
    CardPageId = "Member Application Card";
    Caption = 'Member Application';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                //Caption = 'General Information';
                field("Number"; Rec.Number) { }
                field("Application ID"; Rec."Application ID") { Editable = false; }
                field(Status; Rec.Status) { Editable = false; }
                field("Application Date"; Rec."Application Date") { Editable = false; }

                //Caption = 'Personal Information';
                field("First Name"; Rec."First Name") { }
                field("Last Name"; Rec."Last Name") { }
                field("Date of Birth"; Rec."Date of Birth") { }
                field("Identificationtype"; Rec."Identificationtype") { }
                field("National ID/Passport Number"; Rec."National ID/Passport Number") { }

                // Caption = 'Contact Information';
                field(Country; Rec.Country) { }
                field("Phone Number"; Rec."Phone Number") { }
                field(City; Rec.City) { }
                field("Postal Code"; Rec."Postal Code") { }
                field(Email; Rec.Email) { }
                field(Address; Rec.Address) { }

                // Caption = 'Employment Information';
                field("Occupation Code"; Rec."Occupation Code") { }
                field("Annual Income"; Rec."Annual Income") { }
                field("Member Category"; Rec."Member Category") { }

                //Caption = 'Approval Information';
                field("Approval Date"; Rec."Approval Date") { Editable = true; }
                field("Rejection Reason"; Rec."Rejection Reason") { Editable = true; }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(Approve)
            {
                Caption = 'Approve';
                Image = Approve;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approval Management";
                begin
                    ApprovalMgt.ApproveApplication(Rec);
                    CurrPage.Update(false);
                end;
            }

            action(Reject)
            {
                Caption = 'Reject';
                Image = Cancel;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approval Management";
                begin
                    ApprovalMgt.RejectApplication(Rec);
                    CurrPage.Update(false);
                end;
            }
        }
    }
}