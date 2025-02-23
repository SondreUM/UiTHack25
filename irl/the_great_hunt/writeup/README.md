# Calculating Norwegian Social Security Number

## The first 6 numbers in SSN
* The date of birth, first page says 15.06.1995

## Number 7, 8 and 9, the "individ nummer"
* Based on the order at which you where born that day
* Men get odd number
* Women get even numbers

* Find the name you are looking for and count how many male/females there are before that name
* Example:
    1. Kim Karlsen is male
    2. They are the 204th male in the sequence
    3. Males get odd numbers
    4. The 204th odd number would be: 204 × 2 - 1 = 407

Therefore, Kim Karlsen's individual number is 407.

## Last 2 digits, the checksum
* Date of Birth: 15.06.1995
* Individual Number: 407

### Step 1: Arrange Initial Digits
| D1 | D2 | M1 | M2 | Y1 | Y2 | I1 | I2 | I3 |
|----|----|----|----|----|----|----|----|----|
| 1  | 5  | 0  | 6  | 9  | 5  | 4  | 0  | 7  |

### Step 2: Calculate K1
Multiply each digit by weight factor and sum:

| D1 | D2 | M1 | M2 | Y1 | Y2 | I1 | I2 | I3 |
|----|----|----|----|----|----|----|----|----|
| 1  | 5  | 0  | 6  | 9  | 5  | 4  | 0  | 7  |
| ×3 | ×7 | ×6 | ×1 | ×8 | ×9 | ×4 | ×5 | ×2 |
| 3  | 35 | 0  | 6  | 72 | 45 | 16 | 0  | 14 |

* Sum = 3 + 35 + 0 + 6 + 72 + 45 + 16 + 0 + 14 = 191
* 191 mod 11 = 4
* K1 = 11 - 4 = 7

### Step 3: Calculate K2
Multiply each digit (including K1) by weight factor and sum:

| D1 | D2 | M1 | M2 | Y1 | Y2 | I1 | I2 | I3 | K1 |
|----|----|----|----|----|----|----|----|----|----|
| 1  | 5  | 0  | 6  | 9  | 5  | 4  | 0  | 7  | 7  |
| ×5 | ×4 | ×3 | ×2 | ×7 | ×6 | ×5 | ×4 | ×3 | ×2 |
| 5  | 20 | 0  | 12 | 63 | 30 | 20 | 0  | 21 | 14 |

* Sum = 5 + 20 + 0 + 12 + 63 + 30 + 20 + 0 + 21 + 14 = 185
* 185 mod 11 = 9
* K2 = 11 - 9 = 2

## Final Result
The complete Norwegian social security number is:
* **150695 407 72**

Where:
* 150695 = Date of birth (DDMMYY)
* 407 = Individual number
* 72 = Checksum digits (K1K2)


Weight factor is the same as on wiki.