import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SignupScreen.dart';

class LoginScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text(
						'Field Photo',
						style: TextStyle(
							fontSize: 22.0,
							color: Colors.black,
						)
				),
				backgroundColor: Colors.white,
				centerTitle: true,
			),
			body: Container(
				color: Colors.grey[200],
				child: Padding(
					padding: const EdgeInsets.all(30),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.start,
						crossAxisAlignment: CrossAxisAlignment.stretch,
						mainAxisSize: MainAxisSize.max,
						children: <Widget>[
							Form(
								child: Container(
									decoration: BoxDecoration(
										border: Border.all(
											color: Colors.grey[400],
											width: 1,
										),
										borderRadius: BorderRadius.all(
												Radius.circular(5)
										),
										color: Colors.white,
									),
									child: Column(
										children: <Widget>[
											Padding(
												padding: const EdgeInsets.symmetric(
														horizontal: 9, vertical: 0),
												child: TextField(
													decoration: InputDecoration(
														border: InputBorder.none,
														fillColor: Colors.white,
														hintText: 'Username',
													),
												),
											),
											Container(
												color: Colors.grey,
												height: 1,
											),
											Padding(
												padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 0),
												child: TextField(
													obscureText: true,
													decoration: InputDecoration(
														border: InputBorder.none,
														hintText: 'Password',
													),
												),
											),
										],
									),
								),
							),
							
							Padding(
								padding: const EdgeInsets.symmetric(
										horizontal: 0, vertical: 15),
								child: Container(
									height: 45,
								  child: FlatButton(
								  		onPressed: () {},
								  		color: Colors.green[700],
								  		child: Text(
								  			'Sign In',
								  			style: TextStyle(
								  					color: Colors.white,
								  					fontSize: 18
								  			),
								  		)
								  ),
								),
							),
							
							Padding(
								padding: const EdgeInsets.all(8.0),
								child: Center(
									child: Text(
											'Don\'t have an account?',
											style: TextStyle(
												fontSize: 15,
												color: Colors.grey[700],
											)
									),
								),
							),
							
							Padding(
							  padding: const EdgeInsets.all(10.0),
							  child: SignupButton(),
							),
							
							Padding(
								padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
								child: Center(
									child: Text(
										'You may capture and geotag photos without an account, but you must have an account to upload them to the University of Oklahoma\'s Earth Observation and Modelling Facility database.',
										style: TextStyle(
											fontSize: 15,
											color: Colors.grey[700],
										),
										textAlign: TextAlign.center,
									),
								),
							),
						],
					),
				),
			),
			bottomNavigationBar: BottomAppBar(
				shape: const CircularNotchedRectangle(),
				child: Container(
						height: 50.0
				),
			),
			floatingActionButton: FloatingActionButton(
				onPressed: () {},
				child: Icon(Icons.photo_camera),
			),
			floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
		);
	}
}

class SignupButton extends StatefulWidget {
	@override
	_SignupButtonState createState() {
		return _SignupButtonState();
	}
}

class _SignupButtonState extends State<SignupButton> {
	bool pressed = false;
	@override
	Widget build(BuildContext context) {
		return InkWell(
			child: Center(
				child: Text(
					'Sign Up',
					style: TextStyle(
							color: pressed ? Colors.white : Colors.blue[900],
							fontSize: 18,
							fontWeight: FontWeight.bold
					),
				),
			),
			onTap: () {
				setState(() {
					pressed = false;
					Navigator.push(
						context,
						new MaterialPageRoute(builder: (context) => new SignupScreen()),
					);
				});
			},
			onTapDown: (a) {
				setState(() {
					pressed = true;
				});
			},
		);
	}
}

