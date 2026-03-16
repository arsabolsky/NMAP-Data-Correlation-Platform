import { useState } from "react";
import { useNavigate } from "react-router";
import { Search, Plus, Calendar } from "lucide-react";
import { Button } from "./ui/button";
import { Input } from "./ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "./ui/select";
import { Popover, PopoverContent, PopoverTrigger } from "./ui/popover";
import { Calendar as CalendarComponent } from "./ui/calendar";
import { format } from "date-fns";

export function SearchPage() {
  const navigate = useNavigate();
  const [searchField, setSearchField] = useState<string>("ipAddress");
  const [searchQuery, setSearchQuery] = useState<string>("");
  const [startDate, setStartDate] = useState<Date | undefined>(undefined);
  const [endDate, setEndDate] = useState<Date | undefined>(undefined);

  const handleSearch = () => {
    // Navigate to results with query parameters
    const params = new URLSearchParams({
      field: searchField,
      query: searchQuery,
      ...(startDate && { startDate: format(startDate, "yyyy-MM-dd") }),
      ...(endDate && { endDate: format(endDate, "yyyy-MM-dd") })
    });
    navigate(`/results?${params.toString()}`);
  };

  const handleKeyPress = (e: React.KeyboardEvent) => {
    if (e.key === "Enter") {
      handleSearch();
    }
  };

  return (
    <div className="space-y-8">
      {/* Search Section */}
      <div className="bg-white rounded-lg shadow-sm border border-neutral-200 p-6">
        <h2 className="text-lg font-semibold text-neutral-900 mb-4">Search NMAP Results</h2>
        
        <div className="space-y-4">
          {/* Date Range Selection */}
          <div className="flex gap-4 items-center">
            <div className="flex-1">
              <label className="text-sm font-medium text-neutral-700 mb-2 block">
                Start Date
              </label>
              <Popover>
                <PopoverTrigger asChild>
                  <Button
                    variant="outline"
                    className="w-full justify-start text-left font-normal"
                  >
                    <Calendar className="mr-2 h-4 w-4" />
                    {startDate ? format(startDate, "PPP") : "Select start date"}
                  </Button>
                </PopoverTrigger>
                <PopoverContent className="w-auto p-0" align="start">
                  <CalendarComponent
                    mode="single"
                    selected={startDate}
                    onSelect={setStartDate}
                    initialFocus
                  />
                </PopoverContent>
              </Popover>
            </div>

            <div className="flex-1">
              <label className="text-sm font-medium text-neutral-700 mb-2 block">
                End Date
              </label>
              <Popover>
                <PopoverTrigger asChild>
                  <Button
                    variant="outline"
                    className="w-full justify-start text-left font-normal"
                  >
                    <Calendar className="mr-2 h-4 w-4" />
                    {endDate ? format(endDate, "PPP") : "Select end date"}
                  </Button>
                </PopoverTrigger>
                <PopoverContent className="w-auto p-0" align="start">
                  <CalendarComponent
                    mode="single"
                    selected={endDate}
                    onSelect={setEndDate}
                    initialFocus
                  />
                </PopoverContent>
              </Popover>
            </div>
          </div>

          {/* Search Field and Query */}
          <div className="flex gap-3">
            <div className="w-64">
              <label className="text-sm font-medium text-neutral-700 mb-2 block">
                Search By
              </label>
              <Select value={searchField} onValueChange={setSearchField}>
                <SelectTrigger>
                  <SelectValue placeholder="Select field" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="id">ID</SelectItem>
                  <SelectItem value="ipAddress">IP Address</SelectItem>
                  <SelectItem value="hostname">Hostname</SelectItem>
                  <SelectItem value="operatingSystem">Operating System</SelectItem>
                  <SelectItem value="openPorts">Open Ports</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <div className="flex-1">
              <label className="text-sm font-medium text-neutral-700 mb-2 block">
                Search Query
              </label>
              <div className="flex gap-2">
                <Input
                  type="text"
                  placeholder="Search here..."
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                  onKeyPress={handleKeyPress}
                  className="flex-1"
                />
                <Button onClick={handleSearch} className="bg-blue-600 hover:bg-blue-700">
                  <Search className="h-4 w-4 mr-2" />
                  Search
                </Button>
              </div>
            </div>
          </div>

          {/* Advanced Options */}
          <div className="pt-2">
            <Button variant="outline" size="sm" className="text-neutral-600">
              <Plus className="h-4 w-4 mr-2" />
              Add Advanced Filter
            </Button>
          </div>
        </div>
      </div>

      {/* Quick Info Section */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div className="bg-white rounded-lg border border-neutral-200 p-4">
          <p className="text-sm text-neutral-600">Total Scans</p>
          <p className="text-2xl font-semibold text-neutral-900 mt-1">20</p>
        </div>
        <div className="bg-white rounded-lg border border-neutral-200 p-4">
          <p className="text-sm text-neutral-600">Active Hosts</p>
          <p className="text-2xl font-semibold text-neutral-900 mt-1">18</p>
        </div>
        <div className="bg-white rounded-lg border border-neutral-200 p-4">
          <p className="text-sm text-neutral-600">Last Scan</p>
          <p className="text-2xl font-semibold text-neutral-900 mt-1">Today</p>
        </div>
      </div>
    </div>
  );
}
