pageextension 50146 "Extend Member List" extends "Member Approval App. List"
{
    actions
    {
        addlast(Processing)
        {
            group("XML Operations CodeUnit")
            {
                Caption = 'XML Operations (CodeUnit)';
                //Image = XML;
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
                        // Xmlport.Run(50100, true, false);
                    end;
                }
            }
            group("XML Operations (XML Port)")
            {
                Caption = 'XML Operations (XML Port)';

                action(ImportXMLPort)
                {
                    Caption = 'Import XML (Port)';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        MemberXmlPort: XmlPort "XMLDocument";
                    begin
                        MemberXmlPort.Import();
                    end;
                }
                action(ExportXMLPort)
                {
                    Caption = 'Export XML (Port)';
                    Image = Export;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        MemberXmlPort: XmlPort "XMLDocument";
                    begin
                        MemberXmlPort.Export();
                    end;
                }
            }
        }
    }
}