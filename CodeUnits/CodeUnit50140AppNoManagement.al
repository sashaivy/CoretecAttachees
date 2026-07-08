codeunit 50140 "Application ID No. Mgt."
{
    procedure GetNextNo(): Code[12]
    var
        DailyCounter: Record "Daily Counter";
        NextNo: Integer;
        DateTxt: Text[8];
        SeqTxt: Text[4];
    begin
        if not DailyCounter.Get(Today) then begin
            DailyCounter.Init();
            DailyCounter.Date := Today;
            DailyCounter."Last No." := 1;
            DailyCounter.Insert();
            NextNo := 1;
        end else begin
            DailyCounter."Last No." += 1;
            DailyCounter.Modify();
            NextNo := DailyCounter."Last No.";
        end;

        DateTxt := Format(Today, 0, '<Year4><Month,2><Day,2>');
        SeqTxt := PadStr('', 4 - StrLen(Format(NextNo)), '0') + Format(NextNo);

        exit(DateTxt + SeqTxt);
    end;
}