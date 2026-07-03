page 50133 "Member List"
{
    PageType = List;
    Caption = 'Members list';
    SourceTable = "Member";
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageId = "Member Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the member number.';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the first name.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last name.';
                }
                field("Member Category"; Rec."Member Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the member category.';
                }

                field("Member Since"; Rec."Member Since")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the membership date.';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the email.';
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the phone number.';
                }
            }
        }
    }

    var
        StatusStyle: Text;
}
