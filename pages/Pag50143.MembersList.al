namespace CoretecAttachees.CoretecAttachees;

page 50143 MembersList
{
    ApplicationArea = All;
    Caption = 'MembersList';
    PageType = List;
    SourceTable = "Member Table";
    UsageCategory = Lists;
    CardPageId = "Member Single";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(MemberNo; Rec.MemberNo)
                {
                    ToolTip = 'Specifies the value of the MemberNo field.', Comment = '%';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ToolTip = 'Specifies the value of the Application Date field.', Comment = '%';
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ToolTip = 'Specifies the value of the Approval Date field.', Comment = '%';
                }
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
        }
    }
}
