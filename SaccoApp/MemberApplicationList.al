page 50108 "Member Application List"
{
    PageType = List;
    SourceTable = "Member Application";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Member Applications';
    CardPageId = "Member Application Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Application No."; Rec."Application No.") { }
                field("Full Name"; Rec."Full Name") { }
                field("National ID No."; Rec."National ID No.") { }
                field("Phone No."; Rec."Phone No.") { }
                field("Application Date"; Rec."Application Date") { }
                field(Status; Rec.Status) { }
            }
        }
    }
}
