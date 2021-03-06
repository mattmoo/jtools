#' Format ggplot2 figures in APA style
#'
#' \code{theme_apa()} is designed to work like any other complete theme from
#'   \code{\link[ggplot2]{ggplot}}. To the extent possible, it aligns with
#'   the (vague) APA figure guidelines.
#'
#' @param legend.pos One of \code{"topleft"}, \code{"topright"}, \code{"topmiddle"},
#'   \code{"bottomleft"}, \code{"bottomright"}, or \code{"bottommiddle"}.
#'   Positions the legend, which will layer on top of any geoms, on the plane.
#'   Any other arguments will be passed to \code{\link[ggplot2]{theme}}'s
#'   \code{legend.position =} argument, which takes \code{"left"},
#'   \code{"right"}, \code{"top"}, and \code{"bottom"}.
#'
#' @param legend.use.title Logical. Specify whether to include a legend title. Defaults
#'   to \code{FALSE}.
#'
#' @param legend.font.size Integer indicating the font size of the labels in the
#'   legend. Default and APA-recommended is 12, but if there are many labels it
#'   may be necessary to choose a smaller size.
#'
#' @param x.font.size Font size of x-axis label.
#'
#' @param y.font.size Font size of x-axis label.
#'
#' @param facet.title.size Font size of facet labels.
#'
#' @details This function applies a theme to \code{ggplot2} figures with a style
#'   that is roughly in line with APA guidelines. Users may need to perform further
#'   operations for their specific use cases.
#'
#'   There are some things to keep in mind about APA style figures:
#'   \itemize{
#'    \item Main titles should be written in the word processor or typesetter
#'    rather than on the plot image itself.
#'    \item In some cases, users can forgo a legend in favor of describing the
#'    figure in a caption (also written in the word processor/typesetter).
#'    \item Legends are typically embedded on the coordinate plane of the figure
#'    rather than next to it, as is default in \code{ggplot2}.
#'    \item Use of color is generally discouraged since most of the applications
#'    for which APA figures are needed involve eventual publication in non-color
#'    print media.
#'    \item There are no hard and fast rules on font size, though APA recommends
#'    choosing between 8 and 14-point. Fonts in figures should be sans serif.
#'   }
#'
#'   Because APA style calls for positioning legends on the plane itself, this
#'   function includes options for choosing a position--top left, top right, bottom
#'   left, bottom right--to place the legend. \code{ggplot2} provides no obvious
#'   way to automatically choose a position that overlaps least with the geoms (the
#'   plotted data), so users will need to choose one.
#'
#'   Facetting is supported, but APA guidelines are considerably less clear for
#'   such situations.
#'
#'   This theme was created with inspiration from Rudolf Cardinal's
#'   \href{http://egret.psychol.cam.ac.uk/statistics/R/graphs2.html}{code}, which
#'   required updating for newer versions of \code{ggplot2} and adaptations for
#'   APA style.
#'
#' @author Jacob Long <\email{long.1377@@osu.edu}>
#'
#' @seealso \code{\link[ggplot2]{ggplot}}, \code{\link[ggplot2]{theme}}
#'
#' @references
#'
#' American Psychological Association. (2010). \emph{Publication manual of the American
#' Psychological Association, Sixth Edition}. Washington, DC: American Psychological
#'  Association.
#'
#' Nicol, A.A.M. & Pexman, P.M. (2010). \emph{Displaying your findings: A practical
#'  guide for creating figures, posters, and presentations, Sixth Edition}. Washington,
#'  D.C.: American Psychological Association.
#'
#' @examples
#' # Create plot with ggplot2
#' library(ggplot2)
#' plot <- ggplot(mpg, aes(cty, hwy)) +
#'   geom_jitter()
#'
#' # Add APA theme with defaults
#' plot + theme_apa()
#'
#'
#' @export theme_apa

theme_apa <- function(legend.pos = "topleft", legend.use.title = FALSE,
                      legend.font.size = 12, x.font.size = 12, y.font.size = 12,
                      facet.title.size = 12) {

  # Specifying parameters, using theme_bw() as starting point
  plot <- ggplot2::theme_bw() + ggplot2::theme(
    plot.title = ggplot2::element_text(face = "bold", size = 14),
    axis.title.x = ggplot2::element_text(size = x.font.size),
    axis.title.y = ggplot2::element_text(size = y.font.size,
                                         angle = 90),
    panel.grid.major = ggplot2::element_blank(), # no major gridlines
    panel.grid.minor = ggplot2::element_blank(), # no minor gridlines
    legend.text = ggplot2::element_text(size = legend.font.size),
    legend.key.size = ggplot2::unit(1.5, "lines"),
    # switch off the rectangle around symbols
    legend.key = ggplot2::element_blank(),
    legend.key.width = grid::unit(2, "lines"),
    strip.text.x = ggplot2::element_text(size = facet.title.size), # facet labs
    strip.text.y = ggplot2::element_text(size = facet.title.size),
    # facet titles
    strip.background = ggplot2::element_rect(colour = "white", fill = "white")
  )

  # Choose legend position. APA figures generally include legends that
  # are embedded on the plane, so there is no efficient way to have it
  # automatically placed correctly
  if (legend.pos == "topleft") {
    # manually position the legend (numbers being from 0,0 at bottom left of
    # whole plot to 1,1 at top right)
    plot <- plot + ggplot2::theme(legend.position = c(.05, .95),
                                  legend.justification = c(.05, .95))
  } else if (legend.pos == "topright") {
    plot <- plot + ggplot2::theme(legend.position = c(.95, .95),
                                  legend.justification = c(.95, .95))
  } else if (legend.pos == "topmiddle") {
    plot <- plot + ggplot2::theme(legend.position = c(.50, .95),
                                  legend.justification = c(.50, .95))
  } else if (legend.pos == "bottomleft") {
    plot <- plot + ggplot2::theme(legend.position = c(.05, .05),
                                  legend.justification = c(.05, .05))
  } else if (legend.pos == "bottomright") {
    plot <- plot + ggplot2::theme(legend.position = c(.95, .05),
                                  legend.justification = c(.95, .05))
  } else if (legend.pos == "bottommiddle") {
    plot <- plot + ggplot2::theme(legend.position = c(.50, .05),
                                  legend.justification = c(.50, .05))
  } else if (legend.pos == "none") {
    plot <- plot + ggplot2::theme(legend.position = "none")
  } else {
    plot <- plot + ggplot2::theme(legend.position = legend.pos)
  }

  # Should legend have title? If so, format it correctly
  if (legend.use.title == FALSE) {
    # switch off the legend title
    plot <- plot + ggplot2::theme(legend.title = ggplot2::element_blank())

  } else {
    plot <- plot +
      ggplot2::theme(legend.title =
                       ggplot2::element_text(size = 12, face = "bold"))
  }

  return(plot)

}
