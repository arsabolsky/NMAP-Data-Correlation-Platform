import { useState, useMemo } from "react";
import { useSearchParams, useNavigate } from "react-router";
import { ArrowLeft, ArrowUpDown, ChevronLeft, ChevronRight } from "lucide-react";
import { Button } from "./ui/button";
import { Input } from "./ui/input";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "./ui/table";
import { mockNmapData, NmapResult } from "../data/mockNmapData";

type SortField = keyof NmapResult;
type SortDirection = "asc" | "desc";

export function ResultsPage() {
  const [searchParams] = useSearchParams();
  const navigate = useNavigate();
  
  const searchField = searchParams.get("field") || "";
  const searchQuery = searchParams.get("query") || "";
  const startDate = searchParams.get("startDate");
  const endDate = searchParams.get("endDate");

  const [sortField, setSortField] = useState<SortField>("dateTime");
  const [sortDirection, setSortDirection] = useState<SortDirection>("desc");
  const [currentPage, setCurrentPage] = useState(1);
  const [columnFilters, setColumnFilters] = useState<Record<string, string>>({
    id: "",
    dateTime: "",
    ipAddress: "",
    operatingSystem: "",
    openPorts: ""
  });

  const itemsPerPage = 10;

  // Filter and sort data
  const filteredAndSortedData = useMemo(() => {
    let data = [...mockNmapData];

    // Apply search query filter
    if (searchQuery && searchField) {
      data = data.filter((item) => {
        const value = item[searchField as keyof NmapResult];
        return value?.toString().toLowerCase().includes(searchQuery.toLowerCase());
      });
    }

    // Apply date range filter
    if (startDate || endDate) {
      data = data.filter((item) => {
        const itemDate = new Date(item.dateTime);
        if (startDate && new Date(startDate) > itemDate) return false;
        if (endDate && new Date(endDate) < itemDate) return false;
        return true;
      });
    }

    // Apply column filters
    Object.entries(columnFilters).forEach(([key, value]) => {
      if (value) {
        data = data.filter((item) => {
          const itemValue = item[key as keyof NmapResult];
          return itemValue?.toString().toLowerCase().includes(value.toLowerCase());
        });
      }
    });

    // Sort data
    data.sort((a, b) => {
      const aValue = a[sortField] || "";
      const bValue = b[sortField] || "";
      
      if (sortDirection === "asc") {
        return aValue > bValue ? 1 : -1;
      } else {
        return aValue < bValue ? 1 : -1;
      }
    });

    return data;
  }, [searchQuery, searchField, startDate, endDate, columnFilters, sortField, sortDirection]);

  // Pagination
  const totalPages = Math.ceil(filteredAndSortedData.length / itemsPerPage);
  const paginatedData = filteredAndSortedData.slice(
    (currentPage - 1) * itemsPerPage,
    currentPage * itemsPerPage
  );

  const handleSort = (field: SortField) => {
    if (sortField === field) {
      setSortDirection(sortDirection === "asc" ? "desc" : "asc");
    } else {
      setSortField(field);
      setSortDirection("asc");
    }
  };

  const handleColumnFilter = (column: string, value: string) => {
    setColumnFilters(prev => ({ ...prev, [column]: value }));
    setCurrentPage(1); // Reset to first page when filtering
  };

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4">
          <Button
            variant="outline"
            onClick={() => navigate("/")}
            className="flex items-center gap-2"
          >
            <ArrowLeft className="h-4 w-4" />
            Back to Search
          </Button>
          <div>
            <h2 className="text-lg font-semibold text-neutral-900">Search Results</h2>
            <p className="text-sm text-neutral-600">
              Found {filteredAndSortedData.length} result{filteredAndSortedData.length !== 1 ? 's' : ''}
              {searchQuery && ` for "${searchQuery}" in ${searchField}`}
            </p>
          </div>
        </div>
      </div>

      {/* Results Table */}
      <div className="bg-white rounded-lg shadow-sm border border-neutral-200 overflow-hidden">
        <div className="overflow-x-auto">
          <Table>
            <TableHeader>
              <TableRow className="bg-neutral-50">
                <TableHead className="w-32">
                  <div className="flex items-center gap-2">
                    <button
                      onClick={() => handleSort("id")}
                      className="flex items-center gap-1 hover:text-neutral-900"
                    >
                      ID
                      <ArrowUpDown className="h-3 w-3" />
                    </button>
                  </div>
                </TableHead>
                <TableHead className="w-48">
                  <div className="flex items-center gap-2">
                    <button
                      onClick={() => handleSort("dateTime")}
                      className="flex items-center gap-1 hover:text-neutral-900"
                    >
                      Date/Time
                      <ArrowUpDown className="h-3 w-3" />
                    </button>
                  </div>
                </TableHead>
                <TableHead className="w-40">
                  <div className="flex items-center gap-2">
                    <button
                      onClick={() => handleSort("ipAddress")}
                      className="flex items-center gap-1 hover:text-neutral-900"
                    >
                      IP Address
                      <ArrowUpDown className="h-3 w-3" />
                    </button>
                  </div>
                </TableHead>
                <TableHead>
                  <div className="flex items-center gap-2">
                    <button
                      onClick={() => handleSort("operatingSystem")}
                      className="flex items-center gap-1 hover:text-neutral-900"
                    >
                      Operating System
                      <ArrowUpDown className="h-3 w-3" />
                    </button>
                  </div>
                </TableHead>
                <TableHead className="w-56">
                  <div className="flex items-center gap-2">
                    <button
                      onClick={() => handleSort("openPorts")}
                      className="flex items-center gap-1 hover:text-neutral-900"
                    >
                      Open Ports
                      <ArrowUpDown className="h-3 w-3" />
                    </button>
                  </div>
                </TableHead>
              </TableRow>
              <TableRow className="border-b-2">
                <TableHead className="py-2">
                  <Input
                    type="text"
                    placeholder="Filter..."
                    value={columnFilters.id}
                    onChange={(e) => handleColumnFilter("id", e.target.value)}
                    className="h-8 text-sm"
                  />
                </TableHead>
                <TableHead className="py-2">
                  <Input
                    type="text"
                    placeholder="Filter..."
                    value={columnFilters.dateTime}
                    onChange={(e) => handleColumnFilter("dateTime", e.target.value)}
                    className="h-8 text-sm"
                  />
                </TableHead>
                <TableHead className="py-2">
                  <Input
                    type="text"
                    placeholder="Filter..."
                    value={columnFilters.ipAddress}
                    onChange={(e) => handleColumnFilter("ipAddress", e.target.value)}
                    className="h-8 text-sm font-mono"
                  />
                </TableHead>
                <TableHead className="py-2">
                  <Input
                    type="text"
                    placeholder="Filter..."
                    value={columnFilters.operatingSystem}
                    onChange={(e) => handleColumnFilter("operatingSystem", e.target.value)}
                    className="h-8 text-sm"
                  />
                </TableHead>
                <TableHead className="py-2">
                  <Input
                    type="text"
                    placeholder="Filter..."
                    value={columnFilters.openPorts}
                    onChange={(e) => handleColumnFilter("openPorts", e.target.value)}
                    className="h-8 text-sm"
                  />
                </TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {paginatedData.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={5} className="text-center py-8 text-neutral-500">
                    No results found
                  </TableCell>
                </TableRow>
              ) : (
                paginatedData.map((result) => (
                  <TableRow key={result.id} className="hover:bg-neutral-50">
                    <TableCell className="font-mono text-sm">{result.id}</TableCell>
                    <TableCell className="text-sm">{result.dateTime}</TableCell>
                    <TableCell className="font-mono text-sm">{result.ipAddress}</TableCell>
                    <TableCell className="text-sm">{result.operatingSystem}</TableCell>
                    <TableCell className="font-mono text-sm">{result.openPorts}</TableCell>
                  </TableRow>
                ))
              )}
            </TableBody>
          </Table>
        </div>

        {/* Pagination */}
        {filteredAndSortedData.length > 0 && (
          <div className="flex items-center justify-between px-6 py-4 border-t border-neutral-200 bg-neutral-50">
            <div className="text-sm text-neutral-600">
              Showing {(currentPage - 1) * itemsPerPage + 1} to{" "}
              {Math.min(currentPage * itemsPerPage, filteredAndSortedData.length)} of{" "}
              {filteredAndSortedData.length} results
            </div>
            <div className="flex items-center gap-2">
              <Button
                variant="outline"
                size="sm"
                onClick={() => setCurrentPage(p => Math.max(1, p - 1))}
                disabled={currentPage === 1}
              >
                <ChevronLeft className="h-4 w-4" />
              </Button>
              <span className="text-sm text-neutral-700">
                Page {currentPage} of {totalPages}
              </span>
              <Button
                variant="outline"
                size="sm"
                onClick={() => setCurrentPage(p => Math.min(totalPages, p + 1))}
                disabled={currentPage === totalPages}
              >
                <ChevronRight className="h-4 w-4" />
              </Button>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
