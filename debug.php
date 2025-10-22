<?php
echo "<pre>";
echo "Current directory: " . __DIR__ . "\n\n";
echo "Listing files recursively:\n";
system('ls -lR /var/www/html');
echo "</pre>";
?>
