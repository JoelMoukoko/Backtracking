# Projet Backtracking
## Introduction
Le projet "BACKTRACKING" est un script R conçu pour résoudre le problème classique des N Reines. Le script place N reines sur un échiquier X×Y de manière à ce qu'aucune reine ne puisse en attaquer une autre. La solution comprend une fonction pour vérifier la sécurité des placements des reines et une fonction récursive pour placer les reines sur l'échiquier.

## Environnement de développement
### Outils et bibliothèques
- **[R](https://www.r-project.org/other-docs.html)**: Le script a été écrit pour être exécuté dans l'environnement de programmation R.
- **[RStudio](https://www.r-studio.com/fr/Unformat_Help/)**: Un environnement de développement intégré (IDE) recommandé pour exécuter le script.
- **[ggplot2](https://ggplot2.tidyverse.org/reference/)**: Une bibliothèque R pour la création de visualisations de données.
- **[reshape2](https://www.rdocumentation.org/packages/reshape2/versions/1.4.4)**: Un package R pour restructurer et agencer les données, utilisé pour préparer les données pour la visualisation.
### Installation
Assurez-vous que R et RStudio sont installés sur votre système. Vous pouvez installer les bibliothèques nécessaires en exécutant les commandes suivantes dans la console R :
```r
install.packages("ggplot2")
install.packages("reshape2") 
```
## Aperçu
Ce code R résout le problème des N Reines, où l'objectif est de placer N reines sur un échiquier X×Y sans qu'aucune reine ne puisse en attaquer une autre. Il comprend une série de fonctions pour le placement des reines et une visualisation des attaques sur l'échiquier.

## Détails du Code & Documentation du Code R

### 1.1 Fonction `place_queens`
La fonction `place_queens` est conçue pour résoudre le problème des N Reines sur un échiquier de taille X par Y.

- **Arguments** :
Cette fonction initie le processus avec les paramètres suivants :
  - `X` : Nombre de lignes de l'échiquier.
  - `Y` : Nombre de colonnes de l'échiquier.
```r
place_queens <- function(X, Y)
```

### 1.2 Compteur `solutions`
`solutions` est utilisé pour compter le nombre total de solutions trouvées par l'algorithme.

### 1.3 Fonction d'assistance `is_safe`
La fonction `is_safe` vérifie si une reine peut être placée dans une rangée et une colonne données sans être attaquée par d'autres reines. Elle utilise une boucle while pour vérifier les attaques le long des colonnes précédentes, ainsi que des diagonales gauche et droite.
```r
 is_safe <- function(board, row, col) {
    i <- 1
    while (i < col) {
      if (board[i] == row || 
          board[i] - i == row - col || 
          board[i] + i == row + col) {
        return(FALSE)
      }
      i <- i + 1
    }
    return(TRUE)
  }
```  

### 1.4 Fonction récursive `place_queens_recursive`
`place_queens_recursive` tente de placer une reine dans chaque colonne. Si la colonne actuelle dépasse X, cela indique que toutes les reines sont placées en toute sécurité, et une solution est trouvée, d'où l'incrément du compteur `solutions`. Sinon, elle tente de placer une reine dans chaque rangée de la colonne actuelle, se rappelant récursivement pour la colonne suivante si une position sûre est trouvée.
```r
place_queens_recursive <- function(board, col) {
    if (col > X) {
      solutions <<- solutions + 1
      cat(paste0(board[1:X], collapse = ""), "_")
      return()
    }
    
    row <- 1
    while (row <= Y) {
      if (is_safe(board, row, col)) {
        board[col] <- row
        place_queens_recursive(board, col + 1)
      }
      row <- row + 1
    }
  }
```

### 1.5 Vecteur `board`
`board` est un vecteur initialisé avec des zéros qui représente l'échiquier, où chaque indice est une colonne, et la valeur à cet indice représente la rangée où une reine est placée.
```r
board <- rep(0, Y) # Initialiser la carte avec des zéros
  place_queens_recursive(board, 1)
  
  return(solutions)
```

### 1.6 Exécution
Enfin, `place_queens_recursive` est appelée avec le tableau initial et la première colonne, et la fonction `place_queens` retourne le nombre total de solutions après avoir tenté de placer les reines dans toutes les configurations possibles.

La dernière ligne du code appelle `place_queens` avec `X = 10` et `Y = 10`, ce qui initierait le processus de recherche de solutions pour un échiquier de 10 par 10.
```r
place_queens(10, 10)
```

### 1.7  Résumé
Ce code R est un exemple de mise en œuvre de l'algorithme de retour sur trace, une méthode classique pour résoudre le problème des N Reines.

### 2.1 Ajouts et Fonctionnalités

- **Importation de bibliothèques** : 
Les bibliothèques suivantes sont nécessaires pour exécuter le script :
  - `ggplot2` : Utilisée pour la création de visualisations graphiques.
  - `reshape2` : Utilisée pour la manipulation de données et nécessaire pour la préparation des visualisations.
```r
library(ggplot2)
library(reshape2)
```
### 2.2 Modifications dans la fonction `place_queens`

- **Initialisation de la matrice `attaques`** :
  - Une matrice est créée pour comptabiliser le nombre de fois qu'une case est attaquée par une reine. Sa taille est définie par les dimensions de l'échiquier (`X` par `Y`).

- **Enregistrement des positions des reines** :
  - À chaque solution trouvée, la position des reines est marquée dans la matrice `attaques`, en augmentant le compteur à la position correspondante pour chaque reine placée.

- **Retour de la fonction** :
  - `place_queens` retourne désormais une liste avec le nombre total de solutions (`solutions`) et la matrice `attaques`.

### 2.3 Création de la Heatmap

- **Transformation de la matrice `attaques`** :
  - Utilisation de `melt` de `reshape2` pour convertir la matrice `attaques` en un format adapté à la visualisation avec `ggplot2`.
  ```r
  attaques_melted <- melt(result$attaques)
  ```

- **Utilisation de `ggplot2` pour la visualisation** :
  - La fonction `aes` de `ggplot2` mappe les variables aux axes et à la couleur des tuiles de la heatmap.
  - `geom_tile` est employé pour ajouter les tuiles à la visualisation.
  - La couleur des tuiles est déterminée par le nombre d'attaques dans la matrice `attaques`.
```r
gplot(attaques_melted, aes(Var2, Var1, fill = value)) +
  geom_tile(color = "white")
```
- **Personnalisation de la visualisation** :
  - `scale_fill_gradient` crée un gradient de couleur pour la heatmap, du blanc au rouge.
  - `labs` ajoute des étiquettes pour les axes et la légende.
  - `theme_minimal()` applique un thème minimaliste à la visualisation.
  - `coord_fixed()` assure que l'échelle des axes est fixée pour des tuiles carrées.
```r
  scale_fill_gradient(low = "white", high = "red") +
  labs(title = "Heatmap of Queen's Attacks", x = "Column", y = "Row", fill = "Attack Count") +
  theme_minimal() +
  coord_fixed()
```
### 2.4 Usage de l'exemple
Exemple d'appel de fonction pour un échiquier de 11×11.
```r
result <- place_queens(11, 11)
```

### 2.5 Résumé
La visualisation finale sous forme de carte de chaleur montre la fréquence des attaques sur chaque case pour toutes les solutions possibles via une heatmap, offrant une vue d'ensemble des positions les plus souvent attaquées sur l'échiquier.

