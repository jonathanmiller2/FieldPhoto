import 'package:field_photo/CameraPassthrough.dart';
import 'package:field_photo/LabelledInvisibleButton.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'ImagePreviewScreen.dart';
import 'PositionIndicator.dart';
import 'main.dart';

class CameraScreen extends StatefulWidget {
	@override
	_CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
	@override
	Widget build(BuildContext context) {
		
		
		return Scaffold(
			body: Column(
				children: <Widget>[
					Container(
						color: Colors.black,
						child: CameraPassthrough(),
					),
					Expanded(
						child: Container(
								color: Color.fromARGB(255, 20, 20, 20),
								child: Center(
										child: PositionIndicator()
								)
						),
					),
				],
			),
			bottomNavigationBar: BottomAppBar(
				shape: const CircularNotchedRectangle(),
				child: Container(
						height: 50.0,
						child: Row(
							crossAxisAlignment: CrossAxisAlignment.stretch,
							children: <Widget>[
								Expanded(
									child: Padding(
										padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
										child: Align(
												alignment: Alignment.centerLeft,
												child: LabelledInvisibleButton(
													label: "Close",
													onPress: () {
														Navigator.pop(context);
													},
													defaultColor: Colors.blue[600],
													pressedColor: Colors.blue[200],
													centered: false,
													fontWeight: FontWeight.normal,
												)
										),
									),
								),
								Expanded(
									child: Padding(
										padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
										child: Align(
												alignment: Alignment.centerRight,
												child: LabelledInvisibleButton(
													label: "Geolock",
													onPress: () {
														if(!PositionIndicator.isGeolocked)
														{
															showDialog(
																	context: context,
																	builder: (BuildContext context) {
																		return AlertDialog(
																			title: Text("Enable geolock?"),
																			content: Text("Enabling geolock saves the current latitude and longitude and saves them for future photos"),
																			actions: <Widget>[
																				FlatButton(
																					child: Text("Cancel"),
																					onPressed: () {
																						Navigator.pop(context);
																					},
																				),
																				FlatButton(
																					child: Text("Enable"),
																					onPressed: () {
																						Navigator.pop(context);
																						PositionIndicator.toggleGeolock();
																						setState(() {});
																					},
																				)
																			],
																		);
																	}
															);
														}
														else
														{
															PositionIndicator.toggleGeolock();
															setState(() {});
														}
													},
													defaultColor: PositionIndicator.isGeolocked ? Colors.red[600] : Colors.blue[600],
													pressedColor: PositionIndicator.isGeolocked ? Colors.red[200] : Colors.blue[200],
													centered: false,
													fontWeight: FontWeight.normal,
												)
										),
									),
								),
							],
						)
				),
			),
			floatingActionButton: FloatingActionButton(
				backgroundColor: Colors.blue[600],
				onPressed: () async {
					if(PositionIndicator.getMostRecentPosition() == null)
					{
						showDialog(
								context: context,
								builder: (BuildContext context) {
									return AlertDialog(
										title: Center(
												child: Text(
														"Error retrieving position"
												)
										),
										content: Text(
												"There was an error retrieving your position. This app requires your position to geotag photos for our database."
										),
										actions: <Widget>[
											FlatButton(
												child: Text("Dismiss"),
												onPressed: () {
													Navigator.pop(context);
												},
											),
										],
									);
								}
						);
					}
					else
					{
						try {
							DateTime timestamp = DateTime.now();
							double latitude = PositionIndicator.getMostRecentPosition().latitude;
							double longitude = PositionIndicator.getMostRecentPosition().longitude;
							double altitude = PositionIndicator.getMostRecentPosition().altitude;
							double heading = PositionIndicator.getMostRecentHeading().toDouble();
							
							final path = join(
									(await getTemporaryDirectory()).path,
									'${timestamp.year.toString()}-${timestamp.month.toString()}-${timestamp.day.toString()}-${timestamp.hour.toString()}-${timestamp.minute.toString()}-${timestamp.second.toString()}.jpg'
							);
							
							await MyApp.cameraController.takePicture(path);
							
							//Data: Path, DateTime Taken, Latitude, Longitude, Heading, LULC Class, Field Notes
							//List<Object> photoData = [path, timestamp, lat, long, heading, 0, ""];
							
							Navigator.push(
								context,
								new MaterialPageRoute(builder: (context) => new ImagePreviewScreen(imagePath: path, timestamp: timestamp, latitude: latitude, longitude: longitude, heading: heading, altitude: altitude)),
							);
						} catch (e) {
							print(e);
							
							showDialog(
									context: context,
									builder: (BuildContext context) {
										return AlertDialog(
												title: Center(
														child: Text(
																"Error taking photo"
														)
												),
												content: Text(
														"The image could not be taken. Error text:\n" + e.toString()
												)
										);
									}
							);
						}
					}
				},
				child: Icon(
						Icons.camera,
						size: 36
				),
			),
			floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
		);
	}
}
