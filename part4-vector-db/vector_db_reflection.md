## Vector DB Use Case

A keyword-based search system would be fundamentally inadequate for a law firm querying 500-page contracts in plain English. Here is why, and how a vector database solves the problem.

Traditional keyword search (like SQL `LIKE '%termination%'` or even Elasticsearch BM25) works by exact or near-exact term matching. A lawyer asking "What are the termination clauses?" would only retrieve paragraphs containing the literal word "termination." But legal contracts are full of semantic synonyms: "expiry of agreement," "conditions for dissolution," "early exit provisions," and "contract conclusion rights" all describe termination clauses without using the word "termination." Keyword search misses every one of these. In a 500-page contract, missing even a single relevant clause could expose the firm to liability.

There is also the question of query intent. A lawyer's plain-English question carries meaning beyond its words — she is asking about rights, conditions, notice periods, and consequences. A vector database captures this by converting both the query and every contract paragraph into high-dimensional semantic embeddings (for example, using a model like `sentence-transformers/all-MiniLM-L6-v2`). Embedding similarity (cosine distance) measures whether two pieces of text mean the same thing, not just whether they share words.

In this system, the workflow would be: (1) at ingestion time, each paragraph of every contract is embedded and stored in the vector database (e.g., Pinecone, Weaviate, or pgvector); (2) at query time, the lawyer's question is embedded with the same model; (3) a k-nearest-neighbor search retrieves the top-k most semantically similar paragraphs across all contracts; (4) those paragraphs are returned to the lawyer or passed to a language model for summarization.

This architecture enables genuine semantic retrieval, cross-document search, and natural-language access to legal knowledge that is entirely out of reach for keyword databases — making the vector database not just useful but essential for this use case.
