codeunit 50142 XMLimpexp
{
    procedure Import()

    var
        FromFile: Text; //Choose the file to import
        InStream: InStream; //Stream to read the file
        XMLDoc: XmlDocument; //XML document data type
        Tab: XMLelement; //root element of the XML document
        nodelist: XmlNodeList; //list of nodes in the XML document
        nodee: XmlNode; //individual node in the XML document
        nodee1: XmlNode;
        //nodee2: XmlNode;
        //nodelistsec: XmlNodeList;
        //FileManagement: Codeunit "File Management";
        //rec: Record "Member Application";
        i: Integer;
        //TempNode: XmlNode;
        ImportedCount: Integer;
        ImportErrors: Integer;
    begin
        if not UploadIntoStream('upload XML file', '', 'xml', FromFile, InStream) then
            exit;
        XmlDocument.ReadFrom(InStream, xmlDoc);
        xmlDoc.GetRoot(Tab);
        Tab.SelectNodes('//MemberApplication', nodelist);
        for i := 0 to nodelist.Count() - 1 do begin
            NodeList.Get(i, nodee);
            if Nodee.SelectSingleNode('MemberApplicationDetails', Nodee1) then begin

                if TryImportOneMember(Nodee1) then
                    ImportedCount += 1
                else
                    ImportErrors += 1;
                // Store or display GetLastErrorText()
            end;
        end;
        Message('Import complete.\Imported: %1\Failed: %2', ImportedCount, ImportErrors);
    end;

    [TryFunction]
    local procedure TryImportOneMember(Nodee1: XmlNode)
    var
        Rec: Record "Member Application";
        Nodee2: XmlNode;
    begin
        Rec.Init();

        if Nodee1.SelectSingleNode('FirstName', Nodee2) then
            Rec.Validate("First Name", Nodee2.AsXmlElement().InnerText());

        if Nodee1.SelectSingleNode('LastName', Nodee2) then
            Rec.Validate("Last Name", Nodee2.AsXmlElement().InnerText());

        if Nodee1.SelectSingleNode('DateOfBirth', Nodee2) then
            Rec.Validate("Date of Birth", Nodee2.AsXmlElement().InnerText());

        if Nodee1.SelectSingleNode('IdentificationType', Nodee2) then
            case UpperCase(Nodee2.AsXmlElement().InnerText()) of
                'PASSPORT':
                    Rec.Validate(
                        "Identificationtype",
                        Rec."Identificationtype"::"Passport Number");

                'NATIONALID',
                'NATIONAL_ID':
                    Rec.Validate(
                        "Identificationtype",
                        Rec."Identificationtype"::"National ID");
            end;

        if Nodee1.SelectSingleNode('NationalIDPassportNumber', Nodee2) then
            Rec.Validate("National ID/Passport Number", Nodee2.AsXmlElement().InnerText());

        if Nodee1.SelectSingleNode('Email', Nodee2) then
            Rec.Validate(Email, Nodee2.AsXmlElement().InnerText());

        if Nodee1.SelectSingleNode('PhoneNumber', Nodee2) then
            Rec."Phone Number" := Nodee2.AsXmlElement().InnerText();

        if Nodee1.SelectSingleNode('Address', Nodee2) then
            Rec.Address := Nodee2.AsXmlElement().InnerText();

        if Nodee1.SelectSingleNode('City', Nodee2) then
            Rec.City := Nodee2.AsXmlElement().InnerText();

        if Nodee1.SelectSingleNode('PostCode', Nodee2) then
            Rec."Postal Code" := Nodee2.AsXmlElement().InnerText();

        if Nodee1.SelectSingleNode('Country', Nodee2) then
            Rec.Country := Nodee2.AsXmlElement().InnerText();

        if Nodee1.SelectSingleNode('OccupationCode', Nodee2) then
            case UpperCase(Nodee2.AsXmlElement().InnerText()) of
                'EMPLOYED':
                    Rec."Occupation Code" := Rec."Occupation Code"::Employed;

                'SELF-EMPLOYED':
                    Rec."Occupation Code" := Rec."Occupation Code"::"Self-Employed";

                'STUDENT':
                    Rec."Occupation Code" := Rec."Occupation Code"::Student;

                'UNEMPLOYED':
                    Rec."Occupation Code" := Rec."Occupation Code"::Unemployed;

                'RETIRED':
                    Rec."Occupation Code" := Rec."Occupation Code"::Retired;
            end;

        if Nodee1.SelectSingleNode('AnnualIncome', Nodee2) then
            Evaluate(
                Rec."Annual Income",
                Nodee2.AsXmlElement().InnerText());

        if Nodee1.SelectSingleNode('MemberCategory', Nodee2) then
            case UpperCase(Nodee2.AsXmlElement().InnerText()) of
                'STANDARD':
                    Rec."Member Category" := Rec."Member Category"::Standard;

                'PREMIUM':
                    Rec."Member Category" := Rec."Member Category"::Premium;

                'GOLD':
                    Rec."Member Category" := Rec."Member Category"::Gold;

                'PLATINUM':
                    Rec."Member Category" := Rec."Member Category"::Platinum;
            end;

        Rec.Insert(true);
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

                Node1.Add(XmlElement.Create('NationalIDPassportNumber', Rec."National ID/Passport Number"));

                Node1.Add(XmlElement.Create('Email', Rec.Email));

                Node1.Add(XmlElement.Create('PhoneNumber', Rec."Phone Number"));

                Node1.Add(XmlElement.Create('Address', Rec.Address));

                Node1.Add(XmlElement.Create('City', Rec.City));

                Node1.Add(XmlElement.Create('PostCode', Rec."Postal Code"));

                Node1.Add(XmlElement.Create('Country', Rec.Country));

                Node1.Add(XmlElement.Create('OccupationCode', Format(Rec."Occupation Code")));

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