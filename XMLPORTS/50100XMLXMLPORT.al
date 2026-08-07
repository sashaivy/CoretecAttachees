xmlport 50100 XMLDocument
{
    caption = 'My XMLport for XML Documents';
    format = Xml;
    direction = both;
    UseDefaultNamespace = false;
    Userequestpage = true;
    schema
    {
        textelement(Applications)
        {
            tableelement(MemberApplication; "Member Application")
            {
                MinOccurs = Zero;
                textelement(MemberApplicationDetails)
                {
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

    [TryFunction]
    local procedure TryValidateMember(var MemberRec: Record "Member Application")
    begin
        MemberRec.Validate("First Name");
        MemberRec.Validate("Last Name");
        MemberRec.Validate("Date of Birth");
        MemberRec.Validate(Identificationtype);
        MemberRec.Validate("National ID/Passport Number");
        MemberRec.Validate(Email);
    end;
}
