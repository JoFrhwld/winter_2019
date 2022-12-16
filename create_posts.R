library(glue)
library(readr)

yaml_format <- '---\n\\
title: "<<title>>"\n\\
date: 2023-1-9\n\\
error: true\n\\
---\n\\
\n\\
```{r}\n\\
library(tidyverse)\n\\
```\n
'

chapter_num <- gsub(" ", "0", format(0:16))
chapters <- paste0(chapter_num, "_chapter")
post_paths <- file.path("posts", chapters)
index_paths <- file.path(post_paths, "index.qmd")
for(i in seq_along(post_paths)){
  if(!dir.exists(post_paths[i])){
    dir.create(post_paths[i])
  }
  if(!file.exists(index_paths[i])){
    file.create(index_paths[i])
    chapter_title <- paste("Chapter", chapter_num[i])
    write_lines(
      glue(
        yaml_format, 
        title = chapter_title, 
        .open = "<<",
        .close = ">>"
        ), 
      file = index_paths[i]
      )
  }
}
