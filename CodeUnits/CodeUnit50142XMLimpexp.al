codeunit 50142 XMLimpexp
{
    procedure Import()

    var
        FromFile: Text; //Choose the file to import
        InStream: InStream; //Stream to read the file
        XMLDoc: XmlDocument; //XML document data type
        Tab: XMLelement;
        nodelist: XmlNodeList;
        nodee: XmlNode;
        nodee1: XmlNode;
        nodee2: XmlNode;
        nodelistsec: XmlNodeList;
        //FileManagement: Codeunit "File Management";
        rec: Record "Member Application";
        i: Integer;
        TempNode: XmlNode;
    begin
        if not UploadIntoStream('upload XML file', '', 'xml', FromFile, InStream) then
            exit;
        XmlDocument.ReadFrom(InStream, xmlDoc);
        xmlDoc.GetRoot(Tab);
        Tab.SelectNodes('//MemberApplication', nodelist);
        for i := 0 to nodelist.Count() - 1 do begin
            NodeList.Get(i, nodee);
            if nodee.SelectSingleNode('MemberApplicationDetails', nodee1) then begin
                rec.Init();

                if nodee1.SelectSingleNode('FirstName', nodee2) then
                    rec."First Name" := nodee2.AsXmlElement().InnerText();

                if nodee1.SelectSingleNode('LastName', nodee2) then
                    rec."Last Name" := nodee2.AsXmlElement().InnerText();

                if nodee1.SelectSingleNode('DateOfBirth', nodee2) then
                    rec."Date of Birth" := nodee2.AsXmlElement().InnerText();

                if nodee1.SelectSingleNode('IdentificationType', nodee2) then
                    case UpperCase(nodee2.AsXmlElement().InnerText()) of
                        'PASSPORT':
                            rec."Identificationtype" := rec."Identificationtype"::"Passport Number";
                        'NATIONALID', 'NATIONAL_ID':
                            rec."Identificationtype" := rec."Identificationtype"::"National ID";
                    end;

                if nodee1.SelectSingleNode('NationalIDPassportNumber', nodee2) then
                    rec."National ID/Passport Number" := nodee2.AsXmlElement().InnerText();

                if nodee1.SelectSingleNode('Email', nodee2) then
                    rec.Email := nodee2.AsXmlElement().InnerText();

                if nodee1.SelectSingleNode('PhoneNumber', nodee2) then
                    rec."Phone Number" := nodee2.AsXmlElement().InnerText();

                if nodee1.SelectSingleNode('Address', nodee2) then
                    rec.Address := nodee2.AsXmlElement().InnerText();

                if nodee1.SelectSingleNode('City', nodee2) then
                    rec.City := nodee2.AsXmlElement().InnerText();

                if nodee1.SelectSingleNode('PostCode', nodee2) then
                    rec."Postal Code" := nodee2.AsXmlElement().InnerText();

                if nodee1.SelectSingleNode('Country', nodee2) then
                    rec.Country := nodee2.AsXmlElement().InnerText();

                if nodee1.SelectSingleNode('OccupationCode', nodee2) then
                    case UpperCase(nodee2.AsXmlElement().InnerText()) of
                        'EMPLOYED':
                            rec."Occupation Code" := rec."Occupation Code"::Employed;
                        'SELF-EMPLOYED':
                            rec."Occupation Code" := rec."Occupation Code"::"Self-Employed";
                        'STUDENT':
                            rec."Occupation Code" := rec."Occupation Code"::Student;
                        'UNEMPLOYED':
                            rec."Occupation Code" := rec."Occupation Code"::Unemployed;
                        'RETIRED':
                            rec."Occupation Code" := rec."Occupation Code"::Retired;
                    end;

                if nodee1.SelectSingleNode('AnnualIncome', nodee2) then
                    Evaluate(rec."Annual Income", nodee2.AsXmlElement().InnerText());

                if nodee1.SelectSingleNode('MemberCategory', nodee2) then
                    case UpperCase(nodee2.AsXmlElement().InnerText()) of
                        'Standard':
                            rec."Member Category" := rec."Member Category"::Standard;
                        'PREMIUM':
                            rec."Member Category" := rec."Member Category"::Premium;
                        'GOLD':
                            rec."Member Category" := rec."Member Category"::Gold;
                        'PLATINUM':
                            rec."Member Category" := rec."Member Category"::Platinum;
                    end;
                rec.Insert(true);
            end;
        end;
        Message('Import completed successfully.');
    end;

    procedure export()
    var
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream; //Stream to write the file
        InStr: InStream; //Stream to read the file
        XMLDoc: XmlDocument; //XML document data type
        Tab: XMLelement;
        Node: Xmlelement;
        Node1: Xmlelement;
        rec: Record "Member Application";
        TargetFileName: Text;
    begin
        TempBlob.CreateOutStream(OutStr);

        XmlDoc := XmlDocument.Create();

        Tab := XmlElement.Create('Applications');
        XmlDoc.Add(Tab);

        if Rec.FindSet() then
            repeat

                Node := XmlElement.Create('MemberApplication');

                Node1 := XmlElement.Create('MemberApplicationDetails');

                Node1.Add(XmlElement.Create('FirstName', Rec."First Name"));

                Node1.Add(XmlElement.Create('LastName', Rec."Last Name"));

                Node1.Add(XmlElement.Create('DateOfBirth', Format(Rec."Date of Birth")));

                Node1.Add(XmlElement.Create('IdentificationType', Format(Rec."Identificationtype")));

                Node.Add(XmlElement.Create('NationalIDPassportNumber', Rec."National ID/Passport Number"));

                Node.Add(XmlElement.Create('Email', Rec.Email));

                Node1.Add(XmlElement.Create('PhoneNumber', Rec."Phone Number"));

                Node1.Add(XmlElement.Create('Address', Rec.Address));

                Node1.Add(XmlElement.Create('City', Rec.City));

                Node1.Add(XmlElement.Create('PostCode', Rec."Postal Code"));

                Node.Add(XmlElement.Create('Country', Rec.Country));

                Node.Add(XmlElement.Create('OccupationCode', Format(Rec."Occupation Code")));

                Node1.Add(XmlElement.Create('AnnualIncome', Format(Rec."Annual Income")));

                Node1.Add(XmlElement.Create('MemberCategory', Format(Rec."Member Category")));

                Node.Add(Node1);

                Tab.Add(Node);

            until Rec.Next() = 0;

        XmlDoc.WriteTo(OutStr);

        TempBlob.CreateInStream(InStr);

        TargetFileName := 'MemberApplications.xml';
        DownloadFromStream(InStr, 'Export XML', '', 'XML Files (*.xml)|*.xml', TargetFileName);

        Message('Export completed successfully.');
    end;
}