## UsingAFNetworkingiOSExample
### My Stocks Portfolio

### Description:

My final project will help the user figure out the current position of their stocks based on the stock price that day.

### The UI:

Consists of a UI Text View and a UI Button (My Stocks Status) which displays the stock symbol name followed by (Loss/Gain) followed by the dollar amount of Loss (-) or Gain.

### How it works:

1.      Declared and defined a Stock class which has the following properties, symbol, purchased price, number of stocks bought and brokerage fee and two signature methods, on to init the stock object and the other to calculated the current position based on the current stock price fetched from Yahoo Finance API.
2.      When the user click on the My Stocks Status button:
    a.  The program read the text file (Stocks.txt)
    b.  Populates the Mutable array of stocks
    c.  Get the stocks symbols and initiate a GET call to the Yahoo API
    d.  Call the stock class signature method calGainLose
    e.  Display results in the UI Text View

### Input Format (text file - stocks.txt):

QCOM,63,1000,29
AAPL,109,1000,29
MSFT,39,500,29
JNJ,99,50,29
VZ,40,100,29
T,35,100,29

### Output Example:

My Stocks Gain/Loss

QCOM Loss = ($ -10305.00)
AAPL Gain = + $ 4891.00
MSFT Gain = + $ 7356.00
JNJ Gain = + $ 58.50
VZ Gain = + $ 463.00
T Loss = ($ -239.50)

Two concepts:
File Manager and Networking
