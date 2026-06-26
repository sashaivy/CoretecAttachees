page 50109 "Member Application Card"
{
    PageType = Card;
    SourceTable = "Member Application";
    ApplicationArea = All;
    Caption = 'Member Application';
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }

                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }

                field("National ID No."; Rec."National ID No.")
                {
                    ApplicationArea = All;
                }

                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }

                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = All;
                }
            }

            group("Personal Details")
            {
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }

                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }

                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }

                field(Occupation; Rec.Occupation)
                {
                    ApplicationArea = All;
                }

                field(Employer; Rec.Employer)
                {
                    ApplicationArea = All;
                }
            }

            group("Next of Kin")
            {
                field("Next of Kin Name"; Rec."Next of Kin Name")
                {
                    ApplicationArea = All;
                }

                field("Next of Kin Phone"; Rec."Next of Kin Phone")
                {
                    ApplicationArea = All;
                }
            }

            group("Status Information")
            {
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }

                field("Submitted By"; Rec."Submitted By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
