install.packages("ggplot2")
install.packages("reshape2")
library(ggplot2)
library(reshape2)

place_queens <- function(X, Y) {
  solutions <- 0
  attaques <- matrix(0, nrow = X, ncol = Y)
  
  # Fonction d'assistance pour vérifier si le placement de la reine est sûr
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
  
  # Fonction récursive pour placer les reines et enregistrer les attaques
  place_queens_recursive <- function(board, col) {
    if (col > X) {
      solutions <<- solutions + 1
      # Enregistrez la position de la reine comme une attaque
      for (c in 1:X) {
        attaques[board[c], c] <<- attaques[board[c], c] + 1
      }
    } else {
      row <- 1
      while (row <= Y) {
        if (is_safe(board, row, col)) {
          board[col] <- row
          place_queens_recursive(board, col + 1)
        }
        row <- row + 1
      }
    }
  }
  
  # Démarrer le placement récursif avec un tableau vide
  board <- rep(0, Y)
  place_queens_recursive(board, 1)
  
  # Renvoie à la fois le nombre de solutions et la matrice des attaques
  return(list(solutions = solutions, attaques = attaques))
}

# Exemple usage
result <- place_queens(11, 11)

# Créer la heatmap
attaques_melted <- melt(result$attaques)
ggplot(attaques_melted, aes(Var2, Var1, fill = value)) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "white", high = "red") +
  labs(title = "Heatmap of Queen's Attacks", x = "Column", y = "Row", fill = "Attack Count") +
  theme_minimal() +
  coord_fixed()
