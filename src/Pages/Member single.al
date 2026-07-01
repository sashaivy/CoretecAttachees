page 50204 "Member Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Member";
    Caption = 'Member Profile';

    // 1. Keeps all text fields completely uneditable for everyone
    Editable = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General Information';
                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Title"; Rec."Title") { ApplicationArea = All; }
                field("First Name"; Rec."First Name") { ApplicationArea = All; }
                field("Middle Name"; Rec."Middle Name") { ApplicationArea = All; }
                field("Last Name"; Rec."Last Name") { ApplicationArea = All; }

                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    Style = Attention;
                    StyleExpr = (Rec."Status" <> Rec."Status"::Active);
                }
            }

            group(Personal)
            {
                Caption = 'Personal Details';
                field("Gender"; Rec."Gender") { ApplicationArea = All; }
                field("Date of Birth"; Rec."Date of Birth") { ApplicationArea = All; }
                field("Marital Status"; Rec."Marital Status") { ApplicationArea = All; }
                field("Nationality"; Rec."Nationality") { ApplicationArea = All; }
            }

            group(Identification)
            {
                Caption = 'Identification & Tax';
                field("Identification Type"; Rec."Identification Type") { ApplicationArea = All; }
                field("ID/Passport No."; Rec."ID/Passport No.") { ApplicationArea = All; }
                field("KRA PIN"; Rec."KRA PIN") { ApplicationArea = All; }
            }

            group(Contact)
            {
                Caption = 'Contact Info';
                field("Phone No."; Rec."Phone No.") { ApplicationArea = All; }
                field("Email"; Rec."Email") { ApplicationArea = All; }
                field("Address"; Rec."Address") { ApplicationArea = All; }
                field("City"; Rec."City") { ApplicationArea = All; }
            }

            group(AccountBalances)
            {
                Caption = 'SACCO Account Balances';
                field("Monthly Contribution Target"; Rec."Monthly Contribution Target") { ApplicationArea = All; }
                field("Dividend Payout Method"; Rec."Dividend Payout Method") { ApplicationArea = All; }
                field("Current Shares"; Rec."Current Shares") { ApplicationArea = All; }
                field("Total Deposits"; Rec."Total Deposits") { ApplicationArea = All; }
                field("Outstanding Loans"; Rec."Outstanding Loans") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("Status Management")
            {
                Caption = 'Membership Actions';
                Image = Customer;

                action(WithdrawMembership)
                {
                    ApplicationArea = All;
                    Caption = 'Process Withdrawal';
                    ToolTip = 'Change member status to Withdrawn and suspend active accounts.';
                    Image = CancelLine;
                    Promoted = true;
                    PromotedCategory = Process;

                    // Button is only clickable if the profile is currently Active
                    Enabled = (Rec."Status" = Rec."Status"::Active);

                    trigger OnAction()
                    var
                        UserSetup: Record "User Setup";
                    begin
                        // 2. DYNAMIC SECURITY CHECK: Look up the current operator in the User Setup table
                        if UserSetup.Get(UserId) then begin
                            // Assuming you add an "Is SACCO Admin" boolean field to the User Setup table
                            if not UserSetup."Is SACCO Admin" then
                                Error('Access Denied! You must be a SACCO Administrator to process member withdrawals.');
                        end else begin
                            // Fallback protection: If they aren't even in the setup table, block them out
                            Error('Access Denied! Your user account is not configured for structural status changes.');
                        end;

                        // 3. Financial safeguard validation checks
                        if Rec."Outstanding Loans" > 0 then
                            Error('Cannot process withdrawal. This member still has an outstanding loan balance of KSh %1.', Rec."Outstanding Loans");

                        if Confirm('Are you sure you want to process the withdrawal for this member? This will mark their profile as inactive.', false) then begin
                            Rec."Status" := Rec."Status"::Withdrawn;
                            Rec.Modify(true);
                            Message('Membership status updated to Withdrawn successfully.');
                        end;
                    end;
                }
            }
        }
    }
}