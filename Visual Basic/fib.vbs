' Aidan Fitzpatrick - fib.vbs
' Find the number of numbers exactly y-digits long in a fibonacci sequence
' of length n.

Function fibs(n, y)
    ' define the variables... I don't know if this is actually necessary,
    ' but I'm doing it anyway because it works
    Dim a, b, c
    a=0
    b=1
    c=0
    count=0

    ' Adding the values that aren't covered by the loop
    If y = 1 Then
    count = 2
    End If

    ' Iterate through all of the fibonacci numbers
    for val=0 to n
        ' Formula ( a = fib(n-1), b = fib(n-1) )
        c=a+b
        
        ' get the length of the number using logarithm maths
        ' ln(num)/ln(10) = log10(num) (+1 to offset)
        length=Int(Log(c)/Log(10))+1
        
        ' If the length is correct, increment the count
        If length = y Then
        count = count + 1
        End If

        ' swap around the numbers to prepare for the next iteration
        If b < a Then
        b = c
        c = 0
        Else
        a = c
        c = 0
        End If
    Next
    ' Print the final count to the terminal
    fibs = count
End Function

' take input...
' I presume there's an easier way to do this, but I have no experience with
' VBScript
nval = Int(InputBox("Enter the number of fibonacci sequence numbers to generate: "))
yval = Int(InputBox("Enter how many digits in length numbers in the sequence to be counted must be: "))

' run the function
returnval = fibs(nval, yval)
a = MsgBox("There are "&returnval&" numbers of length "&yval&" in the first "&nval&" fibonacci numbers.", 1)
