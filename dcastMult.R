dcastMult <- function(data, formula, value.var = "value", 
                      funs = list("min" = min, "max" = max)) {
  require(reshape2)
  if (is.null(names(funs)) | any(names(funs) == "")) stop("funs must be named")
  Form <- formula(formula)
  LHS <- as.character(Form[[2]])
  if (length(LHS) > 1) LHS <- LHS[-1]
  temp <- lapply(seq_along(funs), function(Z) {
    T1 <- dcast(data, Form, value.var = value.var, 
                fun.aggregate=match.fun(funs[[Z]]), fill = 0)
    Names <- !names(T1) %in% LHS
    names(T1)[Names] <- paste(names(T1)[Names], names(funs)[[Z]], sep = "_")
    T1
  })
  Reduce(function(x, y) merge(x, y), temp)
}