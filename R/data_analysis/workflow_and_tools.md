## The workflow

### A `tidyverse` perspective

The book [R for data science](https://r4ds.had.co.nz/introduction.html) introduces the diagram below as a generic model of a data science workflow.

![](https://d33wubrfki0l68.cloudfront.net/571b056757d68e6df81a3e3853f54d3c76ad6efc/32d37/diagrams/data-science.png)

### My take

This is how I think about a data workflow (or figuratively pipeline if we indulge in using oil as the metaphor for data in the information age.

> [data] creation -> preparation -> understand -> communication

* Data creation **produces raw data**. It usually involves data logging (e.g., for O&O properties) and data sourcing (e.g., from third-party data providers).

* Data preparation's goal is to **get data ready** for understanding (i.e., the next step). Data might be wrangled in a generic way (e.g., converting column types, treating missing values, imputation, etc) or a specific way with a particular matching analysis in mind (e.g., one-hot encoding for PCA, etc).

* Data understanding **extracts** information and insights from the data.

* Communication **tells a story using data** so that decisions can be made using the insights.

There are couple of differences between my take and the tidyverse perspective.

* I put data creation into the pipeline because the availability of data could have a large impact on all of the subsequent steps (not only data preparation but often data analysis).

* I group data import and data tidy as one block as data preparation. 1) Referring the steps as import and tidy focuses on the actions rather than the goal; and 2) The relationship between import and tidy is often circular rather than linear.

## Steps

### Data creation

### Data prepartion

#### Importing data into R  

Key considerations

1. Data source, usually a data warehouse. This impacts what languages are available to access the data and the APIs in those languages.

1. Data schema, including column mode (i.e., nested vs flat) and column types (i.e., datetime, character, integer, double, enum/factor, or boolean).

1. Business logic as functions. It's usually a good practice to separate raw data (e.g., data logged from web pages) and business logic (e.g., customer segmentation labels based on customer's past spending).

    1. If the datawarehouse allows, the business logic can be applied onto the raw data in the data warehouse before being imported into R. This can be done using user-defined functions (UDFs). The benefit of this is that business logic can be checked into a central deposit to maintain consistency and quality and to benefit more data users.
    
    1. If the datawarehouse doesn't allow such practice, business logic can be applied on the R side using functions.
    
1. Translating R manipulations to SQL. It's safe to assume that some SQL dialect is supported in the datawarehouse for data users to extract data and manage basic computations. The `dplyr` package and by extension the `tidyverse` family of packages (notably the `tidyr` package) has evolved to standardize common data manipulations into "verbs" or expressions. When those expressions are executed within the `tidyverse`, they are evaluated using R. It's also often possible to translate those expressions into SQL statements that can then be executed outside of R but in the datawarehouse.
