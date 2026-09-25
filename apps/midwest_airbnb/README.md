# ISA 401 Job Scout Chat

**Ask a question in plain English, get the SQL and a table back**

A twelve-line [querychat](https://github.com/posit-dev/querychat) app built in ISA 401 (Miami University) on the job postings that [ChatISA](https://chatisa.fsb.miamioh.edu) Job Scout collected. It is the starting point for Assignment 05, where you rebuild it on the Airbnb data, deploy it to [Render](https://render.com) from your GitHub repository, and then improve it.

**Live app:** https://midwest-airbnb-chat-9rsr.onrender.com

---


**Example queries:**
- "Which neighborhood in columbus has the highest price home?"
- <img width="814" height="611" alt="image" src="https://github.com/user-attachments/assets/e4da865c-330c-414c-aac3-bd4c9aeeef3c" />

- "Which neighborhood in Chicago has has the lowest average price?"
- <img width="854" height="549" alt="image" src="https://github.com/user-attachments/assets/49cd7179-0b66-43ce-8ecf-f4d584c92aeb" />

- "What are the top 10 highest listings in the twin cities"
- <img width="1812" height="685" alt="image" src="https://github.com/user-attachments/assets/40d423b3-a651-4c91-9fe1-d647b2e24a2a" />


---

## Dataset Information

**Dataset:** `scout_postings` table in `data/scout.db` (1,891 rows, 19 columns)
**Source:** ChatISA Job Scout, which harvested the postings from public job boards between July 29 and August 23, 2026 (the `source` column records the board: `activejobs` or `usajobs`)
**Data dictionary:** `data/data_desc.md` (started in class; you complete it in Assignment 05)
**Query rules for the LLM:** `data/extra_instructions.md` (one starter rule; you add more)

### Key Fields

| Field | Description |
|-------|-------------|
| `title` | Job title as it appeared on the board |
| `company` | Employer name |
| `location_city` | City of the posting (blank for 61 rows) |
| `location_state` | Two-letter state code (blank for 30 rows) |
| `remote` | `1` if the posting is remote, `0` otherwise |
| `category` | `fulltime`, `federal`, or `internship` |

---

## Required Secret

The app calls OpenAI (`gpt-5.6-luna (reasoning off)`) through [ellmer](https://ellmer.tidyverse.org/), so it needs one environment variable:

```bash
export OPENAI_API_KEY="your-api-key-here"
```

On Hugging Face Spaces, add it under **Settings > Variables and secrets** as a secret named `OPENAI_API_KEY`. Never commit the key; `.Renviron` is listed in `.gitignore` for that reason.

---

## Running Locally

**With R (4.6.0, querychat 0.3.0):**
```r
# from inside apps/job_scout_chat/
shiny::runApp(".", port = 7860)
```

**With Docker:**
```bash
docker build -t job_scout_chat .
docker run --rm -p 7860:7860 -e OPENAI_API_KEY=$OPENAI_API_KEY job_scout_chat
```

Then open http://localhost:7860.

---

## Technology Stack

- **[Shiny](https://shiny.posit.co/)** - Web application framework for R
- **[querychat](https://github.com/posit-dev/querychat)** - Natural language data querying
- **[ellmer](https://ellmer.tidyverse.org/)** - LLM client for R
- **[RSQLite](https://rsqlite.r-dbi.org/)** - SQLite driver for R

---

## Course Information

This application was developed for **ISA 401** at **Miami University**. The polished version of the same idea, built on BLS wage data, is the [OEWS Jobs Explorer](https://huggingface.co/spaces/fmegahed/querychat_demo).
