page 50203 "Member Application List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Member Application";
    CardPageId = "Member Application Card";
    Caption = 'Member Applications';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Email"; Rec."Email")
                {
                    ApplicationArea = All;
                }
                field("Application Status"; Rec."Application Status")
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}