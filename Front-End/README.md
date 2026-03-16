
  # NMAP Data Search Dashboard

  This is a code bundle for NMAP Data Search Dashboard. The original project is available at https://www.figma.com/design/sldxsveaNAHjlWKcUNHqSV/NMAP-Data-Search-Dashboard.

  ## Running the code

  Run `npm i` to install the dependencies.

  Run `npm run dev` to start the development server.
  
# NMAP Data Correlation System - API Documentation

## Overview

This document describes the REST API endpoints required to support the NMAP Data Correlation System. The API provides access to network scan results, allowing users to query and filter NMAP data by various criteria.

**Base URL:** `https://api.yourdomain.com/v1`

**Authentication:** All endpoints require authentication via Bearer token in the Authorization header.

```
Authorization: Bearer <your_api_token>
```

---

## Endpoints

### 1. Get NMAP Results

Retrieve NMAP scan results with optional filtering, sorting, and pagination.

**Endpoint:** `GET /nmap/results`

#### Query Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `field` | string | No | Field to search by. Options: `id`, `ipAddress`, `hostname`, `operatingSystem`, `openPorts` |
| `query` | string | No | Search keyword to filter results |
| `startDate` | string | No | Start date for date range filter (ISO 8601 format: `YYYY-MM-DD`) |
| `endDate` | string | No | End date for date range filter (ISO 8601 format: `YYYY-MM-DD`) |
| `sortBy` | string | No | Field to sort by. Default: `dateTime` |
| `sortOrder` | string | No | Sort direction. Options: `asc`, `desc`. Default: `desc` |
| `page` | integer | No | Page number for pagination. Default: `1` |
| `limit` | integer | No | Number of results per page. Default: `10`, Max: `100` |
| `organizationId` | string | No | Filter by organization ID |
| `locationId` | string | No | Filter by location ID |

#### Example Request

```http
GET /nmap/results?field=ipAddress&query=192.168.1&startDate=2026-03-01&endDate=2026-03-15&sortBy=dateTime&sortOrder=desc&page=1&limit=10
```

#### Response

**Status Code:** `200 OK`

```json
{
  "success": true,
  "data": {
    "results": [
      {
        "id": "NMAP-001",
        "dateTime": "2026-03-11T08:15:23Z",
        "ipAddress": "192.168.1.10",
        "hostname": "WKS-FINANCE-01",
        "operatingSystem": "Windows 10 Professional",
        "openPorts": "80, 443, 3389, 5985",
        "organizationId": "org_abc123",
        "locationId": "loc_xyz789"
      },
      {
        "id": "NMAP-002",
        "dateTime": "2026-03-11T08:16:45Z",
        "ipAddress": "192.168.1.15",
        "hostname": "SRV-WEB-PROD",
        "operatingSystem": "Ubuntu Linux 22.04",
        "openPorts": "22, 80, 443",
        "organizationId": "org_abc123",
        "locationId": "loc_xyz789"
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 5,
      "totalResults": 47,
      "resultsPerPage": 10
    }
  },
  "timestamp": "2026-03-16T10:30:00Z"
}
```

#### Error Response

**Status Code:** `400 Bad Request`

```json
{
  "success": false,
  "error": {
    "code": "INVALID_PARAMETER",
    "message": "Invalid date format. Please use YYYY-MM-DD format.",
    "field": "startDate"
  },
  "timestamp": "2026-03-16T10:30:00Z"
}
```

---

### 2. Get Single NMAP Result

Retrieve detailed information about a specific NMAP scan result.

**Endpoint:** `GET /nmap/results/{id}`

#### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `id` | string | Yes | Unique identifier of the NMAP scan result |

#### Example Request

```http
GET /nmap/results/NMAP-001
```

#### Response

**Status Code:** `200 OK`

```json
{
  "success": true,
  "data": {
    "id": "NMAP-001",
    "dateTime": "2026-03-11T08:15:23Z",
    "ipAddress": "192.168.1.10",
    "hostname": "WKS-FINANCE-01",
    "operatingSystem": "Windows 10 Professional",
    "openPorts": "80, 443, 3389, 5985",
    "closedPorts": "21, 23, 25",
    "macAddress": "00:1B:44:11:3A:B7",
    "scanDuration": 45.3,
    "organizationId": "org_abc123",
    "locationId": "loc_xyz789",
    "scanType": "comprehensive",
    "rawOutput": "Starting Nmap 7.94..."
  },
  "timestamp": "2026-03-16T10:30:00Z"
}
```

---

### 3. Get Organizations

Retrieve list of organizations the authenticated user has access to.

**Endpoint:** `GET /organizations`

#### Response

**Status Code:** `200 OK`

```json
{
  "success": true,
  "data": [
    {
      "id": "org_abc123",
      "name": "Adobe",
      "locations": [
        {
          "id": "loc_xyz789",
          "name": "Lehi, Utah",
          "address": "123 Innovation Dr, Lehi, UT 84043"
        },
        {
          "id": "loc_def456",
          "name": "San Jose, California",
          "address": "345 Park Ave, San Jose, CA 95110"
        }
      ]
    }
  ],
  "timestamp": "2026-03-16T10:30:00Z"
}
```

---

### 4. Get Statistics

Retrieve summary statistics for NMAP scans.

**Endpoint:** `GET /nmap/statistics`

#### Query Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `startDate` | string | No | Start date for statistics (ISO 8601 format) |
| `endDate` | string | No | End date for statistics (ISO 8601 format) |
| `organizationId` | string | No | Filter by organization ID |
| `locationId` | string | No | Filter by location ID |

#### Example Request

```http
GET /nmap/statistics?startDate=2026-03-01&endDate=2026-03-15
```

#### Response

**Status Code:** `200 OK`

```json
{
  "success": true,
  "data": {
    "totalScans": 247,
    "activeHosts": 189,
    "uniqueOperatingSystems": 12,
    "totalOpenPorts": 1834,
    "lastScanTime": "2026-03-15T14:22:11Z",
    "commonPorts": [
      { "port": 80, "count": 145 },
      { "port": 443, "count": 142 },
      { "port": 22, "count": 89 }
    ],
    "operatingSystemDistribution": [
      { "os": "Windows 10", "count": 78 },
      { "os": "Ubuntu Linux", "count": 45 },
      { "os": "Windows Server 2022", "count": 34 }
    ]
  },
  "timestamp": "2026-03-16T10:30:00Z"
}
```

---

### 5. Export Results

Export NMAP scan results in various formats.

**Endpoint:** `POST /nmap/export`

#### Request Body

```json
{
  "format": "csv",
  "filters": {
    "field": "ipAddress",
    "query": "192.168.1",
    "startDate": "2026-03-01",
    "endDate": "2026-03-15"
  },
  "fields": ["id", "dateTime", "ipAddress", "hostname", "operatingSystem", "openPorts"]
}
```

#### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `format` | string | Yes | Export format. Options: `csv`, `json`, `xml` |
| `filters` | object | No | Same filters as GET /nmap/results |
| `fields` | array | No | Specific fields to include in export |

#### Response

**Status Code:** `200 OK`

**Content-Type:** `text/csv` (or appropriate for format)

```csv
ID,Date/Time,IP Address,Hostname,Operating System,Open Ports
NMAP-001,2026-03-11T08:15:23Z,192.168.1.10,WKS-FINANCE-01,Windows 10 Professional,"80, 443, 3389, 5985"
NMAP-002,2026-03-11T08:16:45Z,192.168.1.15,SRV-WEB-PROD,Ubuntu Linux 22.04,"22, 80, 443"
```

---

## Error Codes

| Code | HTTP Status | Description |
|------|-------------|-------------|
| `INVALID_PARAMETER` | 400 | One or more request parameters are invalid |
| `UNAUTHORIZED` | 401 | Authentication token is missing or invalid |
| `FORBIDDEN` | 403 | User does not have access to the requested resource |
| `NOT_FOUND` | 404 | Requested resource was not found |
| `RATE_LIMIT_EXCEEDED` | 429 | Too many requests. Please try again later |
| `INTERNAL_SERVER_ERROR` | 500 | An unexpected error occurred on the server |

---

## Rate Limiting

API requests are limited to **1000 requests per hour** per API token. Rate limit information is included in response headers:

```
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 987
X-RateLimit-Reset: 1678982400
```

---

## Data Types

### NmapResult Object

| Field | Type | Description |
|-------|------|-------------|
| `id` | string | Unique identifier for the scan result |
| `dateTime` | string | Timestamp of the scan (ISO 8601 format) |
| `ipAddress` | string | IP address of the scanned host |
| `hostname` | string | Hostname of the scanned host (if available) |
| `operatingSystem` | string | Detected operating system |
| `openPorts` | string | Comma-separated list of open ports |
| `closedPorts` | string | Comma-separated list of closed ports (optional) |
| `macAddress` | string | MAC address of the host (optional) |
| `scanDuration` | number | Duration of the scan in seconds (optional) |
| `organizationId` | string | Organization that owns this scan |
| `locationId` | string | Location where the scan was performed |
| `scanType` | string | Type of scan performed (optional) |
| `rawOutput` | string | Raw NMAP output (optional, detailed view only) |

---

## Authentication

### Obtaining an API Token

API tokens can be generated from the web application's settings page or by contacting your system administrator.

### Using the Token

Include the token in the Authorization header of all requests:

```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### Token Security

- Keep your API tokens secure and never commit them to version control
- Tokens should be stored in environment variables
- Rotate tokens regularly (recommended: every 90 days)
- Immediately revoke tokens if they are compromised

---

## Best Practices

1. **Pagination**: Always use pagination for large result sets to improve performance
2. **Filtering**: Apply filters on the server-side rather than fetching all data and filtering client-side
3. **Caching**: Cache responses when appropriate to reduce API calls
4. **Error Handling**: Implement proper error handling for all API calls
5. **Rate Limiting**: Monitor your rate limit usage and implement backoff strategies

---

## Example Integration

### JavaScript/TypeScript

```typescript
const API_BASE_URL = 'https://api.yourdomain.com/v1';
const API_TOKEN = process.env.API_TOKEN;

async function getNmapResults(params: {
  field?: string;
  query?: string;
  startDate?: string;
  endDate?: string;
  page?: number;
}) {
  const queryString = new URLSearchParams(
    Object.entries(params).filter(([_, v]) => v != null)
  ).toString();

  const response = await fetch(`${API_BASE_URL}/nmap/results?${queryString}`, {
    headers: {
      'Authorization': `Bearer ${API_TOKEN}`,
      'Content-Type': 'application/json'
    }
  });

  if (!response.ok) {
    throw new Error(`API Error: ${response.status}`);
  }

  return await response.json();
}

// Usage
try {
  const results = await getNmapResults({
    field: 'ipAddress',
    query: '192.168.1',
    startDate: '2026-03-01',
    endDate: '2026-03-15',
    page: 1
  });
  console.log(results.data.results);
} catch (error) {
  console.error('Failed to fetch NMAP results:', error);
}
```

### Python

```python
import requests
import os

API_BASE_URL = 'https://api.yourdomain.com/v1'
API_TOKEN = os.getenv('API_TOKEN')

def get_nmap_results(field=None, query=None, start_date=None, end_date=None, page=1):
    params = {
        'field': field,
        'query': query,
        'startDate': start_date,
        'endDate': end_date,
        'page': page
    }
    # Remove None values
    params = {k: v for k, v in params.items() if v is not None}
    
    headers = {
        'Authorization': f'Bearer {API_TOKEN}',
        'Content-Type': 'application/json'
    }
    
    response = requests.get(
        f'{API_BASE_URL}/nmap/results',
        params=params,
        headers=headers
    )
    response.raise_for_status()
    return response.json()

# Usage
try:
    results = get_nmap_results(
        field='ipAddress',
        query='192.168.1',
        start_date='2026-03-01',
        end_date='2026-03-15',
        page=1
    )
    print(results['data']['results'])
except requests.exceptions.RequestException as e:
    print(f'Failed to fetch NMAP results: {e}')
```

---

## Support

For API support, please contact:
- Email: api-support@yourdomain.com
- Documentation: https://docs.yourdomain.com/api
- Status Page: https://status.yourdomain.com

---

**Version:** 1.0.0  
**Last Updated:** March 16, 2026
