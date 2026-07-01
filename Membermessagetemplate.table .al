table 50314 "Member Message Template"
{
    Caption = 'Member Message Template';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Template Type"; Option)
        {
            Caption = 'Template Type';
            OptionMembers = Approval,Rejection;
            OptionCaption = 'Approval,Rejection';
        }
        field(2; "Email Subject"; Text[250])
        {
            Caption = 'Email Subject';
            NotBlank = true;
        }
        field(3; "Email Body"; Text[2048])
        {
            Caption = 'Email Body';
        }
        field(4; "Last Modified By"; Code[50])
        {
            Caption = 'Last Modified By';
            Editable = false;
        }
        field(5; "Last Modified Date"; DateTime)
        {
            Caption = 'Last Modified Date';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Template Type") { Clustered = true; }
    }

    trigger OnModify()
    begin
        "Last Modified By" := CopyStr(UserId(), 1, 50);
        "Last Modified Date" := CurrentDateTime();
    end;
}
