<%-- 
    Document   : notificacione
    Created on : 12-sep-2017, 15:43:21
    Author     : desarrolloJuan
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <title>JSP Page</title>
        <link href="../Plugins/NotificationStyles/css/normalize.css" rel="stylesheet" type="text/css"/>
        <link href="../Plugins/NotificationStyles/css/demo.css" rel="stylesheet" type="text/css"/>
        <link href="../Plugins/NotificationStyles/css/ns-default.css" rel="stylesheet" type="text/css"/>
        <link href="../Plugins/NotificationStyles/css/ns-style-other.css" rel="stylesheet" type="text/css"/>
        
        
    </head>
    <body>
        <h1>Hello World!</h1>
        <button id="notification-trigger" class="progress-button" disabled="">
						<span class="content">Show Notification</span>
						<span class="progress"></span>
					</button>
        <script src="../Plugins/jquery-3.2.1.min.js" type="text/javascript"></script>
        <script src="../Plugins/NotificationStyles/js/modernizr.custom.js" type="text/javascript"></script>
        <script src="../Plugins/NotificationStyles/js/notificationFx.js" type="text/javascript"></script>
        <script src="../Plugins/NotificationStyles/js/classie.js" type="text/javascript"></script>
        <script>
            
            
			(function() {
				var bttn = document.getElementById( 'notification-trigger' );

				// make sure..
				bttn.disabled = false;

				bttn.addEventListener( 'click', function() {
					// create the notification
					var notification = new NotificationFx({
                                                
						message : '<p>I am using a beautiful spinner from <a href="http://tobiasahlin.com/spinkit/">SpinKit</a></p>',
						layout : 'other',
						effect : 'boxspinner',
						ttl : 9000,
						type : 'notice', // notice, warning or error
                                                posicion: 'right',
						onClose : function() {
							bttn.disabled = false;
						}
					});

					// show the notification
					notification.show();

					// disable the button (for demo purposes only)
					this.disabled = true;
				} );
			})();
		
                
        </script>
    </body>
</html>
