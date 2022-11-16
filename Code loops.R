all_words = c("bikes", "biology", "coffee", "serendipity")

for( word in all_words){

  cat("\n..........Now working on this word: ", word, "......")
 
  sentence = paste0("There are", nchar(word), 
                    "characters in the word ", word, ".")
  cat("\n", sentence)
  
  all_nums = c(10,12,28,34,NA,NA,11,11)
  
  even_nums = NULL
  odd_nums = NULL
  for(n in all_nums){
    cat("\n Working on", n)
  }
    #if na move onto the next iteration
    if( is.na(n) == T){
      cat("\nWarning!!! NA value, skipping to next iteration")
      next}
  #if even store as even... if odd store as off
  if( (n %% 2) == 0 ){
    even_nums = c(even_nums, n)
    cat("\t storing into even vector")
  } else{
      odd_nums = c(odd_nums, n)
      cat("\t storing into odd vector")
  }
  
}

