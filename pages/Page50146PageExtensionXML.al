pageextension 50146 "Extend Member List" extends "Member Approval App. List"
{
    actions
    {
        addlast(Processing)
        {
            action(ImportXML)
            {
                caption = 'Import XML';
                Image = Import;
                promoted = true;
                promotedCategory = Process;
                applicationArea = All;
                trigger OnAction()
                var
                    xmlImpexp: Codeunit "XMLimpexp";
                begin
                    xmlImpexp.Import();
                end;
            }
            action(ExportXML)
            {
                caption = 'Export XML';
                Image = Export;
                promoted = true;
                promotedCategory = Process;
                applicationArea = All;
                trigger OnAction()
                var
                    xmlImpexp: Codeunit "XMLimpexp";
                begin
                    xmlImpexp.Export();
                end;
            }
        }
    }
}