# PySpark Sales Data Processing with Docker

This project demonstrates how to use PySpark DataFrames to process sales data inside a Docker container.

The application reads a CSV dataset, performs common data analysis operations, and exports filtered results to a CSV file. Everything runs inside Docker, so no local Spark installation is required.

---

## Features

* Read sales data from a CSV file using PySpark
* Sort products by sales in descending order
* Display the top 3 highest-selling products
* Filter products with sales greater than 80,000
* Export filtered records as a CSV file
* Run the complete application inside a Docker container

---

## Project Structure

```text
.
├── Dockerfile
├── queries.py
├── sales.csv
├── requirement.txt
├── README.md
└── output/
```

---

## Dataset

The dataset contains product sales information.

| Product ID | Product Name | Category    | Sales  |
| ---------- | ------------ | ----------- | ------ |
| 101        | Laptop       | Electronics | 150000 |
| 102        | Mobile       | Electronics | 95000  |
| 103        | TV           | Electronics | 120000 |
| 104        | Chair        | Furniture   | 30000  |
| 105        | Table        | Furniture   | 45000  |
| 106        | Sofa         | Furniture   | 80000  |
| 107        | Headphones   | Electronics | 25000  |
| 108        | Bed          | Furniture   | 90000  |

---

## Prerequisites

Before running the project, make sure the following is installed:

* Docker Desktop
* Git (optional, for cloning the repository)

Verify Docker installation:

```bash
docker --version
```

---

## Clone the Repository

```bash
git clone <repository-url>
cd <repository-folder>
```

---

## Build the Docker Image

Run the following command from the project root directory:

```bash
docker build --no-cache -t sales-df-app .
```

This command creates a Docker image containing Python, Java, and all required PySpark dependencies.

---

## Run the Application

```bash
docker run sales-df-app
```

When the container starts, the PySpark application runs automatically.

---

## Expected Console Output

The application will:

### 1. Sort Products by Sales

```text
Laptop      150000
TV          120000
Mobile       95000
Bed          90000
...
```

### 2. Display Top 3 Products

```text
Laptop      150000
TV          120000
Mobile       95000
```

### 3. Filter Products with Sales Greater Than 80,000

```text
Laptop      150000
Mobile       95000
TV          120000
Bed          90000
```

---

## Output Files

The filtered dataset is saved as a Spark-generated CSV output.

Spark creates:

```text
output/
└── salesData/
    ├── part-00000-xxxx.csv
    └── _SUCCESS
```

The CSV file inside the `salesData` folder contains all products with sales greater than 80,000.

---

## Technologies Used

* Python 3.12
* PySpark 3.5.6
* Apache Spark
* Docker
* OpenJDK
