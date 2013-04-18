//
//  KeyboardPrevNext2.h
//  VIM
//
//  Created by James Hollender on 1/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef VIM_KeyboardPrevNext_h
#define VIM_KeyboardPrevNext_h

// .h @interface must include <UITextFieldDelegate, UITextViewDelegate>

// KeyboardPrevNext1.h must be included before viewDidLoad

// This file must be included at the end of the viewDidLoad 
// method following the creation of arrayFields, defined in
// KeyboardPrevNext1.h, populated with UITextField and/or 
// UITextView objects in forward order, e.g.,
// arrayFields = [[NSArray alloc] initWithObjects:
//			   textFieldName, 
//			   textFieldAddress, 
//			   textFieldCity, 
//			   textFieldState, 
//			   textFieldPostalCode, 
//			   nil];

if ( ! toolbarKeyboard )
{
	toolbarKeyboard = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
	
	toolbarKeyboard.tintColor = [UIColor colorWithRed:12.0/255.0 green:77.0/255.0 blue:162.0/255.0 alpha:1.0];
	
	UIBarButtonItem *buttonPrevious = [[UIBarButtonItem alloc] initWithTitle:@"Prev." style:UIBarButtonItemStyleBordered target:self action:@selector(buttonPreviousTap:)];
	
	UIBarButtonItem *buttonNext = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(buttonNextTap:)];
	
	UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	
	UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(buttonDoneTap:)];
	
	buttonPrevious.width = 60.0;
	buttonNext.width = 60.0;
	buttonDone.width = 60.0;
	
	[toolbarKeyboard setItems:[[NSArray alloc] initWithObjects:buttonPrevious, buttonNext, extraSpace, buttonDone, nil]];
}

for ( int i = 0; i < [arrayFields count]; i++ )
{
	if ( [[arrayFields objectAtIndex:i] isKindOfClass:[UITextField class]] )
	{
		UITextField *field = [arrayFields objectAtIndex:i];
		field.inputAccessoryView = toolbarKeyboard;
		field.keyboardAppearance = UIKeyboardAppearanceAlert;
		field.delegate = self;
	}
	else
	{
		UITextView *field = [arrayFields objectAtIndex:i];
		field.inputAccessoryView = toolbarKeyboard;
		field.keyboardAppearance = UIKeyboardAppearanceAlert;
		field.delegate = self;
	}
}
}

- (void)changePositionOfFieldsForField:(UIView *)field
{
	UIView *field2 = [arrayFields objectAtIndex:0];
	UIView *viewParent = [field2 superview];
	CGFloat y = 0.0;
	
	if ( iPadDevice )
		return;
	
	if ( noNavBar == YES )
	{
		if ( field.frame.origin.y + field.frame.size.height > (145.0 + 44.0) )
		{
			y = (field.frame.origin.y + field.frame.size.height - 150.0 - 44.0) * -1;
		}
	}
	else
	{
		if ( field.frame.origin.y + field.frame.size.height > 145.0 )
		{
			y = (field.frame.origin.y + field.frame.size.height - 150.0) * -1;
		}
	}
	
	[UIView animateWithDuration:0.25 
					 animations:^{
						 viewParent.frame = CGRectMake(viewParent.frame.origin.x, y, viewParent.frame.size.width, viewParent.frame.size.height);
					 }];
}

- (void)buttonNextTap:(id)sender
{
	for ( int i = 0; i < [arrayFields count]; i++ )
	{
		UIView *field = [arrayFields objectAtIndex:i];
		
		if ( [field isFirstResponder] )
		{
			if ( i == [arrayFields count] - 1 )
				field = [arrayFields objectAtIndex:0];
				else
					field = [arrayFields objectAtIndex:i + 1];
					
					[field becomeFirstResponder];
			
			return;
		}
	}
}

- (void)buttonPreviousTap:(id)sender
{
	for ( int i = 0; i < [arrayFields count]; i++ )
	{
		UIView *field = [arrayFields objectAtIndex:i];
		
		if ( [field isFirstResponder] )
		{
			if ( i == 0 )
				field = [arrayFields objectAtIndex:[arrayFields count] - 1];
				else
					field = [arrayFields objectAtIndex:i - 1];
					
					[field becomeFirstResponder];
			
			return;
		}
	}
}

- (void)buttonDoneTap:(id)sender
{
	UIView *field0 = [arrayFields objectAtIndex:0];
	UIView *viewParent = [field0 superview];
	CGFloat y = 0.0;
	
	for ( int i = 0; i < [arrayFields count]; i++ )
	{
		if ( [[arrayFields objectAtIndex:i] isKindOfClass:[UITextField class]] )
		{
			UITextField *field = [arrayFields objectAtIndex:i];
			if ( [field isFirstResponder] )
			{
				[field resignFirstResponder];
				break;
			}
		}
		else
		{
			UITextView *field = [arrayFields objectAtIndex:i];
			if ( [field isFirstResponder] )
			{
				[field resignFirstResponder];
				break;
			}
		}
	}
	
	if ( iPadDevice )
		return;
	
	[UIView animateWithDuration:0.25 
					 animations:^{
						 viewParent.frame = CGRectMake(viewParent.frame.origin.x, y, viewParent.frame.size.width, viewParent.frame.size.height);
					 }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	[self changePositionOfFieldsForField:textField];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
	[self changePositionOfFieldsForField:textView];



#endif
