#COMP 3007, Fall 2018. Dr, R, Collier
#Danilo Orozco, 101035548
#Assignment 1, Question 1

#function for checking is letter is uppercase
def isUp(str_data):
	if ord(str_data) >= ord('A') and ord(str_data) <=ord('Z'):
		return True
	else:
		return False
		
#function for checking is letter is lowercase
def isLow(str_data):
	if ord(str_data) >= ord('a') and ord(str_data) <=ord('z'):
		return True
	else:
		return False

		
#recurisvefunction for changing all letters to lowercase
def recurseLow(word): 
    if word == '':
        return ''
    else:   
        if isUp(word[0]):
            return lowercase(word[0]) + recurseLow(word[1:])      
        elif isLow(word[0]):
            return word[0] + recurseLow(word[1:])

#Part A
#function for changing uppercase letters to lowercase letters
#function for converting uppercase to lowercase			
def lowercase(str_data):
	result = ''
	#if its uppercase convert to lowercase
	if isUp(str_data):
		result = chr(ord(str_data) + 32)
	else:
		result = str_data
	return result
	
#function for changing lowercase letters to uppercase letters
def uppercase(str_data):
	result = ''
	if isLow(str_data[0]):
		result = chr(ord(str_data[0]) - 32)
	else:
		result = str_data[0]
	return result

#Part B
#recursive function to change "studly caps" to specified format
def formatStudly(str_data):
	format = ''
	if len(str_data) == 1:
		return uppercase(str_data)
	else:
		#recurses backwards from last letter changing to lowercase excpet when its at 1 letter
		return formatStudly(str_data[:-1]) + lowercase(str_data[len(str_data)-1])
		
#Part C 
#recursive function that takes a list of strings and create a single string of camel case
def camelCase(strList):
	#base case
	if len(strList) == 1:
		return recurseLow(strList[0])
	else:
		return camelCase(strList[:-1]) + formatStudly(strList[len(strList)-1])
		
		
#Part D
#Recursive function that retains All capital letters from a string to form camel acrostic
def acrostic(str_data):
	upper = ''
	if str_data == '':
		return ''
	else:
		upper += acrostic(str_data[1:])
		if isUp(str_data[0]):
			return str_data[0] + upper
		else:
			return upper

def UI():
	#condition loop
	exit = True
	while (exit == True):
		#user input, words separated by comma and space
		sentence = input("Enter words of your choosing separated by a comma and a space: ")
		splitList = sentence.split(", ")
		camel = camelCase(splitList)
		print("Camel Case Conversion: ", camel)
		camelAcrostic = acrostic(camel)
		print("Camel Acrostic: ", camelAcrostic)
		choice = input("Would you like to create another camel acrostic? (y for yes/ n for no): ")
		if choice == "n":
			print("Goodbye!")
			#ends loop
			exit = False
	

#main, calls the user interface
UI()