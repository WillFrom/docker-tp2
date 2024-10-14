<?php
// Informations de connexion à la base de données
$host = "data";
$db = "mydatabase";
$user = "myuser";
$pass = "mypassword";

try {
    // Connexion à la base de données MySQL avec PDO
    $pdo = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Insertion d'un enregistrement avec un nom aléatoire
    $stmt = $pdo->prepare("INSERT INTO test_table (name) VALUES (:name)");
    $stmt->execute(['name' => 'Nom aléatoire ' . rand(1, 100)]);

    // Récupération de tous les enregistrements de la table
    $stmt = $pdo->query("SELECT * FROM test_table");
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Affichage des enregistrements
    echo "<h2>Enregistrements dans la table :</h2>";
    foreach ($rows as $row) {
        echo "<p>ID : {$row['id']} - Nom : {$row['name']}</p>";
    }
} catch (PDOException $e) {
    // Gestion des erreurs de connexion et d'exécution des requêtes
    echo "Erreur de connexion : " . $e->getMessage();
}
?>
