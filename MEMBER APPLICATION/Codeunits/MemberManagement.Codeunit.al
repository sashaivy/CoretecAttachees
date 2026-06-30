Codeunit 50100 "Member Management"
{
    procedure OpenRegisteredMemberInfo(Var CurrentMember: Record "Members")


    var
        SummaryPage: Page "Registered Member Information";
    begin
        SummaryPage.SetRecord(CurrentMember);
        SummaryPage.Run();
    end;

}