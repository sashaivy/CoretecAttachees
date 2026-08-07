pageextension 50146 "Extend Member List" extends "Member Approval App. List"
{
    actions
    {
        addlast(Processing)
        {
            group("XML Operations CodeUnit")
            {
                Caption = 'XML Operations (CodeUnit)';
                //Commented out due to the code unit running into a tenent error i cannot pinpoint
                // action(ImportXML)
                // {
                //     caption = 'Import XML';
                //     Image = Import;
                //     promoted = true;
                //     promotedCategory = Process;
                //     applicationArea = All;
                //     trigger OnAction()
                //     var
                //         xmlImpexp: Codeunit "XMLimpexp";
                //     begin
                //         xmlImpexp.Import();
                //     end;

                // }
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
                        MemberXmlPort.Run();
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
                        XmlPort.Run(XmlPort::"XMLDocument", false, false);
                    end;
                }
                group("CSV Operations (CSV Port)")
                {
                    Caption = 'CSV Operations (CSV Port)';
                    action(ImportCSVPort)
                    {
                        Caption = 'Import CSV (Port)';
                        Image = Import;
                        Promoted = true;
                        PromotedCategory = Process;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            MemberXmlPort: XmlPort "CSVXMLPort";
                        begin
                            MemberXmlPort.Run();
                        end;
                    }
                    action(ExportCSVPort)
                    {
                        Caption = 'Export CSV (Port)';
                        Image = Export;
                        Promoted = true;
                        PromotedCategory = Process;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            MemberXmlPort: XmlPort "CSVXMLPort";
                        begin
                            XmlPort.Run(XmlPort::"CSVXMLPort", false, false);
                        end;
                    }
                }
            }
        }
    }
}