codeunit 50140 "Member Application Helper"
{
    trigger OnRun()
    begin
        navigateToSingle();
    end;

    procedure navigateToSingle()
    var
        varMemberSingle: Page "Member Single";
    begin
        varMemberSingle.Run();
    end;

    procedure RegisterMember(ID: Integer)
    var
        MemberApplication: Record "Member Application Table";
        Member : Record "Member Table";
        SendNotifications: Codeunit SendNotifications;
    begin
        if MemberApplication.Get(ID) then begin
            if MemberApplication.Status = MemberApplication.Status::Approved then begin
                Member.Init();
                Member.MemberNo := GenerateMemberNo();
                Member."Application Date" := MemberApplication."Application Date";
                Member."First Name" := MemberApplication."First Name";
                Member."Last Name" := MemberApplication."Last Name";
                Member."Date of Birth" := MemberApplication."Date of Birth";
                Member."ID/Passport Number" := MemberApplication."ID/Passport Number";
                Member."Phone Number" := MemberApplication."Phone Number";
                Member.Email := MemberApplication.Email;
                Member.Address := MemberApplication.Address;
                Member.City := MemberApplication.City;
                Member."Postal Code" := MemberApplication."Postal Code";
                Member.Country := MemberApplication.Country;
                Member."Occupation Code" := MemberApplication."Occupation Code";
                Member."Annual Income" := MemberApplication."Annual Income";
                Member."Member Category" := MemberApplication."Member Category";
                Member."Approval Date" := MemberApplication."Approval Date";
                Member.Insert();

                SendNotifications.Registered(Member.Email, Member.MemberNo);
            end else begin
                SendNotifications.RejectedApplicationEmail(MemberApplication.Email, MemberApplication."Rejection Reason");
            end;
            MemberApplication.Delete();
        end;
    end;

    procedure GenerateMemberNo() : Code[20]
    var
        MemberNo : Code[20];
        MemberCount : Integer;
        Member : Record "Member Table";
    begin
        Member.SetCurrentKey("Approval Date");
        if Member.FindLast() then begin
            MemberCount := Member.Count + 1;
        end else begin
            MemberCount := 1;
        end;
            
        MemberNo := 'MBR-'+Format(Today, 0, '<Year, 2><Month, 2>')+PadStr('', 4-StrLen(Format(MemberCount)), '0')+Format(MemberCount);
        exit(MemberNo);
    end;
}