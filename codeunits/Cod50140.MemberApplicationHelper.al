codeunit 50140 "Member Application Helper"
{
    trigger OnRun()
    begin
        navigateToSingle();
    end;
    

    local procedure navigateToSingle()
    var
        varMemberSingle: Page "Member Single";
    begin
        varMemberSingle.Run();
    end;

    var
        myInt: Integer;
}