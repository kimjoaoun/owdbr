# Open Welfare Data Brazil

Collects municipal-level data from Several Brazilian Government's Social Programs.

Collects data from Public API's that contains information related to the following programs:
- Bolsa Familia Program  **OK**
- PETI (Slave Labour Erradication Program)  **OK**
- FIES (Financiamento Estudantil)  *Soon*
- Seguro Defeso  *Soon*
- PROUNI  *Soon*

## Introduction:
The package has some simple functions that needs to be understood by the user. Only with that knowledge of these, one can make a good use of it. All these functions were written in a way to support multiple requests at once, in order to facilitate the download of data from multiple municipalities.

#### **``uflist()`` function** 

The first step in using the package is running the ``uflist()`` function, this function takes **no arguments** and it returns a tibble with three columns: the first one is the ``num``(With the numeric identifier of the State); the second one being the ``EST`` column, with the full name of the State; and the last one, the ``UF`` column, which contains the UF code, that is a short name (abbreviation?) for a State.
