xmlport 50101 CSVXMLPort
{
    caption = 'My XMLport for CSV Documents';
    format = VariableText;
    direction = both;
    FieldSeparator = ',';
    TextEncoding = UTF8;
    tableseparator = '\n';
    Userequestpage = true;
    schema
    {
        textelement(Applications)
        {
            tableelement(MemberApplication; "Member Application")
            {
                MinOccurs = Zero;

                fieldelement(FirstName; Memberapplication."First Name")
                {
                }
                fieldelement(LastName; Memberapplication."Last Name")
                {
                }
                fieldelement(DateOfBirth; Memberapplication."Date of Birth")
                {
                }
                fieldelement(IdentificationType; Memberapplication."Identificationtype")
                {
                }
                fieldelement(NationalIDPassportNumber; Memberapplication."National ID/Passport Number")
                {
                }
                fieldelement(Email; Memberapplication."Email")
                {
                }
                fieldelement(PhoneNumber; Memberapplication."Phone Number")
                {
                }
                fieldelement(Address; Memberapplication."Address")
                {
                }
                fieldelement(City; Memberapplication."City")
                {
                }
                fieldelement(PostCode; Memberapplication."Postal Code")
                {
                }
                fieldelement(Country; Memberapplication."Country")
                {
                }
                fieldelement(OccupationCode; Memberapplication."Occupation Code")
                {
                }
                fieldelement(AnnualIncome; Memberapplication."Annual Income")
                {
                }
                fieldelement(MemberCategory; Memberapplication."Member Category")
                {
                }


                trigger OnBeforeInsertRecord()
                begin


                    if not TryValidateMember(MemberApplication) then begin
                        ImportErrors += 1;

                        if SkipInvalidRows then begin
                            Message(
                              'Skipping %1 %2. Reason: %3',
                              MemberApplication."First Name",
                              MemberApplication."Last Name",
                              GetLastErrorText());

                            CurrXMLPort.Skip();
                        end else
                            Error(GetLastErrorText());
                    end;
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(SkipInvalidRowsCtrl; SkipInvalidRows)
                    {
                        ApplicationArea = All;
                        Caption = 'Skip rows that fail validation';
                        ToolTip = 'If enabled, invalid rows are skipped and counted instead of stopping the whole import.';
                    }
                }
            }
        }
    }

    trigger OnPostXmlPort()
    begin
        if (ImportedCount + ImportErrors) > 0 then
            Message('Import finished: %1 imported, %2 failed.', ImportedCount, ImportErrors);
    end;

    var
        SkipInvalidRows: Boolean;
        ImportedCount: Integer;
        ImportErrors: Integer;
        lineNo: Integer;

    var
        Year, Month, Day : Integer;
        DateParsingErr: Label 'Date of Birth ''%1'' is not in the expected DD/MM/YYYY format.', Comment = '%1 = the raw text value that failed to parse';

    local procedure ConvertDateOfBirth(Value: Text): Text
    begin
        if (StrLen(Value) <> 10) or (Value[3] <> '/') or (Value[6] <> '/') then
            Error(DateParsingErr, Value);

        if not Evaluate(Day, CopyStr(Value, 1, 2)) then
            Error(DateParsingErr, Value);

        if not Evaluate(Month, CopyStr(Value, 4, 2)) then
            Error(DateParsingErr, Value);

        if not Evaluate(Year, CopyStr(Value, 7, 4)) then
            Error(DateParsingErr, Value);

        exit(
            CopyStr(Value, 7, 4) + '/' +
            CopyStr(Value, 4, 2) + '/' +
            CopyStr(Value, 1, 2)
        );
    end;

    local procedure ValidateDateOfBirthOnBeforeInsertRecord(var MemberRec: Record "Member Application")
    begin
        MemberRec."Date of Birth" := ConvertDateOfBirth(MemberRec."Date of Birth");
    end;

    [TryFunction]
    local procedure TryValidateMember(var MemberRec: Record "Member Application")
    begin
        MemberRec.Validate("First Name");
        MemberRec.Validate("Last Name");
        MemberRec.Validate(Identificationtype);
        MemberRec.Validate("National ID/Passport Number");
        MemberRec.Validate(Email);
        MemberRec.Validate("Date of Birth");
    end;
}
