enum 50210 "Employment Status"
{
    Extensible = true;

    value(0; Unemployed)
    {
        Caption = 'Unemployed';
    }

    value(1; Employed)
    {
        Caption = 'Employed';
    }

    value(2; "Self Employed")
    {
        Caption = 'Self Employed';
    }

    value(3; Contractor)
    {
        Caption = 'Contractor';
    }
}
enum 50211 "Application Status"
{
    Extensible = true;

    value(0; Open)
    {
        Caption = 'Open';
    }

    value(1; Pending)
    {
        Caption = 'Pending';
    }

    value(2; Approved)
    {
        Caption = 'Approved';
    }

    value(3; Rejected)
    {
        Caption = 'Rejected';
    }
}

enum 50212 Gender
{
    Extensible = true;

    value(0; Male)
    {
        Caption = 'Male';
    }

    value(1; Female)
    {
        Caption = 'Female';
    }

    value(2; Other)
    {
        Caption = 'Other';
    }
}

enum 50213 "Marital Status"
{
    Extensible = true;

    value(0; Single)
    {
        Caption = 'Single';
    }

    value(1; Married)
    {
        Caption = 'Married';
    }

    value(2; Divorced)
    {
        Caption = 'Divorced';
    }

    value(3; Widowed)
    {
        Caption = 'Widowed';
    }
}

enum 50214 "Membership Type"
{
    Extensible = true;

    value(0; Individual)
    {
        Caption = 'Individual';
    }

    value(1; Group)
    {
        Caption = 'Group';
    }

    value(2; Corporate)
    {
        Caption = 'Corporate';
    }
}
enum 50215 "Dividend Payout Method"
{
    Extensible = true;

    value(0; "Capitalize to Shares")
    {
        Caption = 'Capitalize to Shares';
    }

    value(1; "Bank Transfer")
    {
        Caption = 'Bank Transfer';
    }

    value(2; "Mobile Money")
    {
        Caption = 'Mobile Money';
    }

    value(3; "Retain on Deposits")
    {
        Caption = 'Retain on Deposits';
    }
}

enum 50216 "Risk Assessment Rating"
{
    Extensible = true;

    value(0; Low)
    {
        Caption = 'Low';
    }

    value(1; Medium)
    {
        Caption = 'Medium';
    }

    value(2; High)
    {
        Caption = 'High';
    }
}
enum 50217 Title
{
    Extensible = true;

    value(0; Mr)
    {
        Caption = 'Mr.';
    }

    value(1; Mrs)
    {
        Caption = 'Mrs.';
    }

    value(2; Miss)
    {
        Caption = 'Miss';
    }

    value(3; Ms)
    {
        Caption = 'Ms.';
    }

    value(4; Dr)
    {
        Caption = 'Dr.';
    }

    value(5; Prof)
    {
        Caption = 'Prof.';
    }
}

enum 50218 "Identification Type"
{
    Extensible = true;

    value(0; "National ID")
    {
        Caption = 'National ID';
    }

    value(1; Passport)
    {
        Caption = 'Passport';
    }

    value(2; "Alien ID")
    {
        Caption = 'Alien ID';
    }

    value(3; "Military ID")
    {
        Caption = 'Military ID';
    }
}