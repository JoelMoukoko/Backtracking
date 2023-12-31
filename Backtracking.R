place_queens <- function(X, Y) {
  solutions <- 0
  
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
  
  # Fonction récursive pour placer les reines
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
  
  # Démarrer le placement récursif avec un tableau vide
  board <- rep(0, Y) # Initialiser la carte avec des zéros
  place_queens_recursive(board, 1)
  
  return(solutions)
}

# Exemple d'usage:
solutions <- place_queens(10, 10)
print(solutions)
