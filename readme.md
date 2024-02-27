git clone git@github.com:webpwnized/mutillidae.git
"mutillidae/includes/database-config.inc" update db config 

<?php
define('DB_HOST', 'db');
define('DB_USERNAME', 'testuser');
define('DB_PASSWORD', 'mutillidae');
define('DB_NAME', 'mutillidae');
define('DB_PORT', 3306);
?>


docker-compose up -d

