Vehicle-Management-System/
				│
				├── README.md    → Project description & setup guide
				├── vehicle.sql                    → Database schema & sample data
				│
				├── src/     → Java source code (Model + Controller)
				│   └── com/vehicle/
				│       ├── model/                 → Model classes (POJOs)
				│       │   ├── Area.java
				│       │   ├── Booking.java
				│       │   ├── City.java
				│       │   └── Vehicle.java
				            └──state
				            └──zip
				│       │
				│       ├── controller/            → Servlet controllers
				│       │  
				
				            ├── LoginServlet.java           	← Handle login requests
							├── RegisterServlet.java        	← Handle registration
							├── LogoutServlet.java          	← Handle logout
							├── DashboardServlet.java       	← Dashboard management
							├── BikeServlet.java            	← Bike listing and operations
							├── CarServlet.java             	← Car listing and operations
							├── BookServlet.java            	← Booking operations
							├── SellServlet.java            	← Add new vehicle
							├── DeleteVehicleServlet.java   	← Delete vehicle
							├── FilterAreaBikeServlet.java  	← Filter bikes by area
							├── FilterAreaCarServlet.java   	← Filter cars by area
							├── FilterPriceBikeServlet.java 	← Filter bikes by price
							├── FilterPriceCarServlet.java 		 ← Filter cars by price
							├── FilterCityBikeServlet.java  	← Filter bikes by city
							├── FilterCityCarServlet.java   	← Filter cars by city
							├── FilterStateBikeServlet.java 	← Filter bikes by state
							├── FilterStateCarServlet.java  	← Filter cars by state
							├── FilterZipBikeServlet.java   	← Filter bikes by zip
							├── FilterZipCarServlet.java    	← Filter cars by zip
							└── OrdersServlet.java         		 ← View orders/bookings
				│       │ 
				│       │
				│       └── util/        → Utility classes
				│           └── DbConnection.java
				│
				├── WebContent/                    → View layer (JSP + static files)
				│   ├── index.jsp                  → Landing page
				│   ├── bike.jsp
				│   ├── car.jsp
				│   ├── dashboard.jsp
				│   ├── home.jsp
				│   ├── login.jsp
				│   ├── orders.jsp
				│   ├── register.jsp
				│   ├── sell.jsp
				│   │
				│   ├── css/                       → Stylesheets
				│   ├── js/                        → JavaScript files
				│   ├── images/                    → Static images
				│   │
				│   ├── META-INF/
				│   └── WEB-INF/
				│       ├── web.xml                → Deployment descriptor
				│       └── lib/                   → JAR dependencies
				│
				└── Servers/      → Local server config (Eclipse/Tomcat)
				
				
