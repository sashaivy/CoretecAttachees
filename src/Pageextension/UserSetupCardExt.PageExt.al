pageextension 50201 "SACCO User Setup Page Ext" extends "User Setup"
{
    layout
    {
        // This forces your new checkbox right next to the standard User ID field automatically!
        addafter("User ID")
        {
            field("Is SACCO Admin"; Rec."Is SACCO Admin")
            {
                ApplicationArea = All;
                Caption = 'Is SACCO Administrator';
                ToolTip = 'Specifies if this user has administrative rights to process sensitive operations like member withdrawals.';
            }
        }
    }
}
