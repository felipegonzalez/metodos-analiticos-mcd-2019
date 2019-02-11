sim_jaccard <- function(a, b){
    length(intersect(a, b)) / length(union(a, b))
}

shingle_chars <- function(string, k, lowercase = FALSE){
  tokenizers::tokenize_character_shingles(string, 
    n = k, lowercase = lowercase, simplify = TRUE, strip_non_alphanum = FALSE)
}

crear_tejas_reng <- function(textos, k = 4, tokenizer = shingle_chars){
  # Convertir documento a tejas y ordenar por tejas
  num_docs <- length(textos)
  # crear tejas
  tejas <- tokenizer(textos, k = k) %>% map(unique)
  # invertir
  tejas_df <- data_frame(texto_id = 1:num_docs, shingles = tejas) %>% 
    unnest %>% 
    mutate(shingle_n = as.numeric(factor(shingles))) %>% 
    group_by(shingle_n) %>% select(-shingles) %>% 
    summarise(textos = list(texto_id))
  list(tejas = tejas_df$textos, num_docs = num_docs, k = k)
}

crear_tejas_doc <- function(textos, k = 4, tokenizador = shingle_chars){
  # Convertir documento a tejas 
  num_docs <- length(textos)
  # crear tejas
  tejas <- tokenizador(textos, k = k) %>% map(unique)
  tejas_df <- data_frame(texto_id = 1:num_docs, shingles = tejas) %>%
    unnest %>% 
    mutate(shingle_n = as.numeric(factor(shingles))) %>% 
    group_by(texto_id) %>% 
    summarise(shingles = list(shingle_n))
  list(tejas = tejas_df$shingles, num_docs = num_docs, k = k)
}

generar_hash_mod <- function(p = 2038074743){
  a <- sample.int(p - 1, 2)
  hash_fun <- function(x) {
    # restamos y sumamos uno para mapear a enteros positivos
    ((a[1]*(x - 1) + a[2]) %% p) + 1
  }
  hash_fun
}


calc_firmas_hash_reng <- function(tejas_obj, hash_funs){
  # Calcular minhashes según algoritmo por teja de @mmd
  num_docs <- tejas_obj$num_docs
  # min hashing
  num_hashes <- length(hash_funs)
  tejas <- tejas_obj$tejas
  firmas <- matrix(Inf, ncol = num_docs, nrow = num_hashes)
  for(r in 1:length(tejas)){
    # calcular hashes de teja
    hashes <- map_dbl(hash_funs, ~.x(r))
    # extaer documentos que contienen la teja
    indices <- tejas[[r]]
    # actualizar matriz
    firmas[, indices] <- pmin(firmas[, indices], hashes)
  }
  firmas
}


calc_firmas_hash_doc <- function(tejas_obj, hash_funs){
  # Calcular minhashes documento por documento
  num_docs <- tejas_obj$num_docs
  # min hashing
  num_hashes <- length(hash_funs)
  tejas <- tejas_obj$tejas
  firmas <- vector("list", num_docs)
  for(i in 1:num_docs){
    firmas[[i]] = map_dbl(hash_f, ~ min(.x(tejas[[i]])))
  }
  data_frame(doc_id = 1:num_docs, firma = firmas)
}