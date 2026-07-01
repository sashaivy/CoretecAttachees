tableextension 50200 "SACCO User Setup Ext" extends "User Setup"
{
    fields
    {
        field(50200; "Is SACCO Admin"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Is SACCO Administrator';
            ToolTip = 'Specifies if this user has administrative rights to process sensitive operations like member withdrawals.';
        }
    }
}