codeunit 50141 "Approval Management"
{
    procedure ApproveApplication(var MemApplication: Record "Member Application")
    begin
        if MemApplication.Status <> MemApplication.Status::Pending then
            Error('Only pending applications can be approved.');

        MemApplication.TestField("Application ID");
        MemApplication.Status := MemApplication.Status::Approved;
        MemApplication."Approval Date" := Today;
        MemApplication."Rejection Reason" := '';
        MemApplication.Modify(true);
    end;

    procedure RejectApplication(var MemApplication: Record "Member Application"; RejectionReason: Text[100])
    begin
        if MemApplication.Status <> MemApplication.Status::Pending then
            Error('Only pending applications can be rejected.');

        if RejectionReason = '' then
            Error('Enter a rejection reason before rejecting the application.');

        MemApplication.TestField("Application ID");
        MemApplication.Status := MemApplication.Status::Rejected;
        MemApplication."Approval Date" := 0D;
        MemApplication."Rejection Reason" := CopyStr(RejectionReason, 1, 100);
        MemApplication.Modify(true);
    end;
}