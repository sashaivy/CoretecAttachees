enum 50132 "Member Application Status"
{
    Extensible = true;

    value(0; Pending)
    {
        Caption = 'Pending';
    }
    value(1; Approved)
    {
        Caption = 'Approved';
    }
    value(2; Rejected)
    {
        Caption = 'Rejected';
    }
}

enum 50133 "Occupation Code"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Employed)
    {
        Caption = 'Employed';
    }
    value(2; SelfEmployed)
    {
        Caption = 'Self-Employed';
    }
    value(3; Unemployed)
    {
        Caption = 'Unemployed';
    }
    value(4; Student)
    {
        Caption = 'Student';
    }
    value(5; Retired)
    {
        Caption = 'Retired';
    }
}

enum 50134 "Member Category"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Regular)
    {
        Caption = 'Regular';
    }
    value(2; Premium)
    {
        Caption = 'Premium';
    }
    value(3; Corporate)
    {
        Caption = 'Corporate';
    }
    value(4; Student)
    {
        Caption = 'Student';
    }
}