//Codeunit 50142 "Validate ID"
// {
//local procedure ValidateIdentification()
//var
// i: Integer;
//begin
// case "Identification Type" of
//"Identification Type"::"National ID":
//begin
// Length check
// if (StrLen("Identification Number") <> 7) and
// (StrLen("Identification Number") <> 8) then
// Error('A National ID must contain 7 or 8 digits.');

// Digits only
//  for i := 1 to StrLen("Identification Number") do
//if not ("Identification Number"[i] in ['0'..'9']) then
//     Error('A National ID can contain digits only.');
// end;

// "Identification Type"::Passport:
// begin
// Example validation
//if StrLen("Identification Number") < 6 then
//   Error('Enter a valid passport number.');
//end;
//  end;
//end;
//}