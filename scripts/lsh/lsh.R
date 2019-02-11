crear_cubetas_fun <- function(h, r){
  particion <- split(1:h, ceiling(1:h / r))
  particion
  function(firma){
    map_chr(particion, function(x){
      prefijo <- paste0(x, collapse = '')
      cubeta <- paste(firma[x], collapse = "-")
      firma_str <- paste(c(prefijo, cubeta), collapse = '|')
      digest::digest(firma_str, 'xxhash64')
    })
  }
}