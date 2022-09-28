check_hashsum <- function(path_data, hashsum = NULL, hash_dir = NULL) {
  stopifnot(!missing(hashsum) || !missing(hash_dir))

  if (!missing(hash_dir)) {
    hash_file <- file.path(hash_dir, paste0(basename(path_data), ".sha256"))
    hashsum <- readr::read_file(hash_file)
  }

  data_hash <-
    digest::digest(
      path_data,
      algo = "sha256", file = TRUE, serialize = FALSE
    )

  if (data_hash != hashsum) {
    stop(
      paste(
        "Hash sums are different expected: '",
        hash,
        "', computed: '",
        data_hash,
        "'"
      )
    )
  }

  return(path_data)
}
