"00-ReviewR.Rmd", , "02-Week02.Rmd" , "03-Week03.Rmd",
"04-Week04.Rmd", "05-Week05.Rmd", "06-Week06.Rmd" , "07-Week07.Rmd" , "08-Week08.Rmd",
"09-Week09.Rmd", "10-Week10.Rmd" , "11-Week11.Rmd" , "12-Week12.Rmd",
"13-Week13.Rmd", "14-Week14.Rmd"



```{r htmlTemp3, echo=FALSE, eval=TRUE}
codejs <- readr::read_lines("js/codefolding.js")
collapsejs <- readr::read_lines("js/collapse.js")
transitionjs <- readr::read_lines("js/transition.js")

htmlhead <-
  paste('
<script>',
        paste(transitionjs, collapse = "\n"),
        '</script>
<script>',
        paste(collapsejs, collapse = "\n"),
        '</script>
<script>',
        paste(codejs, collapse = "\n"),
        '</script>
<style type="text/css">
.code-folding-btn { margin-bottom: 4px; }
.row { display: flex; }
.collapse { display: none; }
.in { display:block }
</style>
<script>
$(document).ready(function () {
  window.initializeCodeFolding("show" === "show");
});
</script>
', sep = "\n")

readr::write_lines(htmlhead, file = paste0(here::here(), "/header.html"))
```
