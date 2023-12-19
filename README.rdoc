# Fashionfly API Documentation

## Getting Started

To retrieve the main categories:

```http
GET http://localhost:3000/de/api/categories.json
```

Example response:

```json
{
  "categories": [
    {"id": 487, "name": "Damenmode"},
    {"id": 570, "name": "Herrenmode"}
  ]
}
```

To get the main categories of a specific group:

```http
GET http://localhost:3000/de/api/categories/487.json
```

Example response:

```json
{
  "categories": [
    {"id": 488, "name": "Kleider"},
    {"id": 497, "name": "Oberteile"},
    ...
    {"id": 565, "name": "Bademode"}
  ]
}
```

For subcategories, provide the ID of a main category:

```http
GET http://localhost:3000/de/api/categories/488.json
```

Example response:

```json
{
  "categories": [
    {"id": 489, "name": "Causal Kleider"},
    {"id": 490, "name": "Abendkleider"},
    ...
    {"id": 496, "name": "Strickkleider"}
  ],
  "brands": [...],
  "colors": [...],
  "price_ranges": [...]
}
```

## Product Search

For product search, use:

```http
GET http://localhost:3000/de/api/products.json
```

Example response:

```json
{
  "pagination": {...},
  "products": [
    {
      "id": 50,
      "price": "79.99",
      "name": "Leder Pumps + High Heel",
      "image": "http://localhost:3000/uploads/product/image/50/dcab005e-d235-40f8-85e7-a1e7ae5a3ea5.png",
      "url": "http://www.zanox-affiliate.de/ppc/?28724477C79684775&ULP=[[pumps%2Fleder-pumps-high-heel-014EK1W053_001%3Fcamp%3DDE_IC_ZX_AF_20_001]]"
    }
  ]
}
```

### Search Parameters

- `page`: Page number
- `per`: Products per page
- `category`: Category ID
- `brand`: Brand ID
- `color`: Color hex value without "#"
- `price`: Range value "value1-value2" or ">value"