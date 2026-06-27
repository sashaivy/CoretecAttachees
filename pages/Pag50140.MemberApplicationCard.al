namespace CoretecAttachees.CoretecAttachees;

page 50140 "Member Application Card"
{
    ApplicationArea = All;
    Caption = 'Member Application';
    PageType = Card;
    SourceTable = "Member Application Table";
    
    layout
    {
        area(Content)
        {
            group("General Information")
            {
                Caption = 'General Information';
                
                field("Application ID"; Rec."Application ID")
                {
                    ToolTip = 'Specifies the value of the Application ID field.', Comment = '%';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                    Editable = false;
                    // trigger OnValidate()
                    // begin
                    //     Rec.Status := varStatus;
                    // end;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ToolTip = 'Specifies the value of the Application Date field.', Comment = '%';
                    Editable = false;
                }
            }
            group("Personal Information")
            {
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field.', Comment = '%';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.', Comment = '%';
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ToolTip = 'Specifies the value of the Date of Birth field.', Comment = '%';
                }
                field("ID/Passport Number"; Rec."ID/Passport Number")
                {
                    ToolTip = 'Specifies the value of the ID/Passport Number field.', Comment = '%';
                }
            }
            group("Contact Information")
            {
                field("Phone Number"; Rec."Phone Number")
                {
                    ToolTip = 'Specifies the value of the Phone Number field.', Comment = '%';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.', Comment = '%';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field.', Comment = '%';
                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ToolTip = 'Specifies the value of the Postal Code field.', Comment = '%';
                }
                field(Country; Rec.Country)
                {
                    ToolTip = 'Specifies the value of the Country field.', Comment = '%';
                }
            }
            group("Employment Information")
            {
                field("Occupation Code"; Rec."Occupation Code")
                {
                    ToolTip = 'Specifies the value of the Occupation Code field.', Comment = '%';
                }
                field("Annual Income"; Rec."Annual Income")
                {
                    ToolTip = 'Specifies the value of the Annual Income field.', Comment = '%';
                }
                field("Member Category"; Rec."Member Category")
                {
                    ToolTip = 'Specifies the value of the Member Category field.', Comment = '%';
                }
            }
            group("Approval Information")
            {
                field("Approval Date"; Rec."Approval Date")
                {
                    ToolTip = 'Specifies the value of the Approval Date field.', Comment = '%';
                    Editable = false;
                }
                field("Rejection Reason"; Rec."Rejection Reason")
                {
                    ToolTip = 'Specifies the value of the Rejection Reason field.', Comment = '%';
                    Editable = Rec.Status = Rec.Status::Rejected;
                }
            }
        }
    }

    actions
    {
        area(Promoted){
            actionref("Approves"; Approve){}
            actionref("Rejects"; Reject){}
            actionref("Finish"; "Finish Application"){}
        }
        
        area(Processing)
        {
            action(Approve){
                Image = Approval;
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Approved;
                    if Rec.Status = Rec.Status::Approved then begin
                        Rec."Approval Date" := CurrentDateTime.Date;
                    // end;
                end;
            }
            action(Reject){
                Image = Reject;
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Rejected;
                    // if Rec.Status = Rec.Status::Rejected then begin
                        // Rec."Approval Date" := 0D;
                        Clear(Rec."Approval Date");
                    // end;
                end;
            }

            action("Finish Application")
            {
                Image = Completed;
                trigger OnAction()
                var
                    memberApplicationHelper: Codeunit "Member Application Helper";
                begin
                    memberApplicationHelper.Run();
                end;
            }
        }
    }
}
