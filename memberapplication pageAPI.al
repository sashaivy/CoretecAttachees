page 50322 "member application pageAPI"
{
    Caption = 'Member Application API';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "Member Application";
    APIPublisher = 'Barrack';
    APIGroup = 'MemberApplication';
    APIVersion = 'v1.0';
    entityName = 'memberapplication';
    entitySetName = 'memberapplications';
    ODataKeyFields = SystemId;


    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(No; Rec."No.") { }
                field(FullName; Rec."Full Name") { }
                field(LastName; Rec."Last Name") { }
                field(DOB; Rec."DOB") { }
                field(IDNO; Rec."IDNO") { }
                field(PhoneNo; Rec."PhoneNo") { }
                field(City; Rec."City") { }
                field(Email; Rec."Email") { }
                field(PostalCode; Rec."Postal Code") { }
                field(Address; Rec."Address") { }
                field(Country; Rec."Country") { }
                field(OccupationCode; Rec."Occupation Code") { }
                field(AnnualIncome; Rec."Annual Income") { }
                field(MemberCategory; Rec."Member Category") { }
                field(Status; Rec."status") { }

            }
        }
    }
}

