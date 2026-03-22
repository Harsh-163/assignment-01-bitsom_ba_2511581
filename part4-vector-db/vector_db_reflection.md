## Subjective 
## Vector DB Use Case

In this scenario, a traditional keyword-based database search would not be sufficient. Keyword search relies on exact word matching, which can be limiting when dealing with large legal documents like 500-page contracts. Legal language is often complex, and the same concept can be expressed in multiple ways. For example, a clause related to “termination” might not always use the exact word “termination,” but could be phrased differently. A keyword-based system may miss such variations or return too many irrelevant results.

A vector database, on the other hand, works based on semantic understanding rather than exact keywords. It converts text into embeddings (numerical representations of meaning), allowing the system to understand the intent behind a user’s query. When a lawyer asks a question in plain English, the system can match it with relevant sections of the contract based on meaning, even if the wording is different.

In this system, the contracts would first be broken into smaller chunks and converted into embeddings using a language model. These embeddings would be stored in a vector database. When a query is asked, it is also converted into an embedding, and the database retrieves the most similar chunks using similarity search.

This approach makes the search more accurate, efficient, and user-friendly, especially for non-technical users who prefer natural language queries over keyword-based searches.
