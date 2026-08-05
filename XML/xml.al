xmlport 50100 XMLDocument
{
    caption = 'My XMLport';
    format = Xml;
    direction = both;
    UseDefaultNamespace = false;
    Userequestpage = true;
    schema
    {
        textelement(Member)
        {
            tableelement(MemberApplication; "Member Application")
            {
                fieldelement(FirstName; memberapplication."First Name")
                {
                }
                fieldelement(LastName; memberapplication."Last Name")
                {
                }
                fieldelement(DateOfBirth; memberapplication."Date of Birth")
                {
                }
                fieldelement(IdentificationType; memberapplication."Identificationtype")
                {
                }
                fieldelement(NationalIDPassportNumber; memberapplication."National ID/Passport Number")
                {
                }
                fieldelement(EmailAddress; memberapplication."Email")
                {
                }
                fieldelement(PhoneNumber; memberapplication."Phone Number")
                {
                }
                fieldelement(Address; memberapplication."Address")
                {
                }
                fieldelement(City; memberapplication."City")
                {
                }
                fieldelement(PostCode; memberapplication."Postal Code")
                {
                }
                fieldelement(Country; memberapplication."Country")
                {
                }
                fieldelement(OccupationCode; memberapplication."Occupation Code")
                {
                }
                fieldelement(annualIncome; memberapplication."Annual Income")
                {
                }
                fieldelement(membercategory; memberapplication."Member Category")
                {
                }

            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(Name; MemberApplication."First Name")
                    {
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {

                }
            }
        }
    }

    var
        myInt: Integer;
}