#' @importFrom dplyr across everything select starts_with summarise
#' @importFrom ggplot2 position_dodge scale_x_continuous scale_y_continuous
#' @importFrom ggplot2 stat_summary theme xlab ylab
#' @importFrom purrr map_chr
#' @importFrom rlang :=
#' @importFrom stringr str_detect str_replace_all
#' @importFrom magrittr %>%
#' @importFrom msArrow get_data open_data write_data
#' @importFrom methods hasArg
#' @importFrom stats setNames na.omit
#' @importFrom utils head select.list
NULL

# The dataset store keeps its registry in two objects in the global
# environment: `.Datasets` holds file paths, `Datasets` holds previews. `Info`
# holds the import defaults. They are created by .add_dataset()/.add_defaults()
# and written with `<<-`, so R CMD check cannot see where they are bound.
#
# The remaining names are columns referred to by non-standard evaluation inside
# dplyr and tidyr pipelines.
utils::globalVariables(c(".Datasets",
                         "Datasets",
                         "Info",
                         ".",
                         ".data",
                         "n",
                         "Run",
                         "Channel",
                         "Precursor.Id",
                         "Protein.Group",
                         "Proteotypic",
                         "Decoy",
                         "Modified.Sequence",
                         "Stripped.Sequence",
                         "observations",
                         "variables"))
