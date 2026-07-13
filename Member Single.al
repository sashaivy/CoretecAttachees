page 50340 "member Single"
{
    caption = 'Member Single';
    pagetype = Card;
    sourceTable = "Member Application";
    usageCategory = Documents;
    applicationArea = All;
    editable = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Application Details';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;


                }


                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field(DOB; Rec.DOB)
                {
                    ApplicationArea = All;
                }
                field(IDNO; Rec.IDNO)
                {
                    ApplicationArea = All;
                }

            }
            group(Generalinformation)
            {
                caption = 'Contact Information';
                field("Phone No."; Rec.PhoneNo)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Email"; Rec."Email")
                {
                    ApplicationArea = All;
                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ApplicationArea = All;
                }
                field("Address"; Rec."Address")
                {
                    ApplicationArea = All;
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                }
            }


            group(employmentinformation)
            {
                Caption = 'Employment Information';
                field("KRA PIN"; Rec."KRA PIN")
                {
                    ApplicationArea = All;
                }
                field("Annual Income"; Rec."Annual Income")
                {
                    ApplicationArea = All;
                }
                field("Member Category"; Rec."Member Category")
                {
                    ApplicationArea = All;
                }
            }

            group(StatusGroup)
            {
                Caption = 'Status';

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Decision Date"; Rec."Decision Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}