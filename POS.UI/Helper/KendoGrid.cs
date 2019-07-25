using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Runtime.Serialization;

namespace POS.UI.Helper
{
    /// Represents a sort expression of Kendo DataSource.
    [DataContract]
    public class Sort
    {
        /// Gets or sets the name of the sorted field (property).
        [DataMember(Name = "field")]
        public string Field { get; set; }

        /// Gets or sets the sort direction. Should be either "asc" or "desc".
        [DataMember(Name = "dir")]
        public string Dir { get; set; }

        /// Converts to form required by Dynamic Linq e.g. "Field1 desc"
        public string ToExpression()
        {
            return Field + " " + Dir;
        }
    }

    /// Represents a filter expression of Kendo DataSource.
    [DataContract]
    public class Filter
    {
        /// Gets or sets the name of the sorted field (property). Set to <c>null</c> if the <c>Filters</c> property is set.
        [DataMember(Name = "field")]
        public string Field { get; set; }

        /// Gets or sets the filtering operator. Set to <c>null</c> if the <c>Filters</c> property is set.
        [DataMember(Name = "operator")]
        public string Operator { get; set; }

        /// Gets or sets the filtering value. Set to <c>null</c> if the <c>Filters</c> property is set.
        [DataMember(Name = "value")]
        public string Value { get; set; }

        /// Gets or sets the filtering logic. Can be set to "or" or "and". Set to <c>null</c> unless <c>Filters</c> is set.
        [DataMember(Name = "logic")]
        public string Logic { get; set; }

        /// Gets or sets the child filter expressions. Set to <c>null</c> if there are no child expressions.
        [DataMember(Name = "filters")]
        public IEnumerable<Filter> Filters { get; set; }

        /// Mapping of Kendo DataSource filtering operators to Dynamic Linq
        private static readonly IDictionary<string, string> operators = new Dictionary<string, string>
        {
            {"eq", "="},
            {"neq", "!="},
            {"lt", "<"},
            {"lte", "<="},
            {"gt", ">"},
            {"gte", ">="},
            {"startswith", "StartsWith"},
            {"endswith", "EndsWith"},
            {"contains", "Contains"},
            {"doesnotcontain", "Contains"}
        };

        /// Get a flattened list of all child filter expressions.
        public IList<Filter> All()
        {
            var filters = new List<Filter>();

            Collect(filters);

            return filters;
        }

        private void Collect(IList<Filter> filters)
        {
            if (Filters != null && Filters.Any())
            {
                foreach (Filter filter in Filters)
                {
                    filters.Add(filter);

                    filter.Collect(filters);
                }
            }
            else
            {
                filters.Add(this);
            }
        }

        /// Converts the filter expression to a predicate suitable for Dynamic Linq e.g. "Field1 = @1 and Field2.Contains(@2)"
        /// <param name="filters">A list of flattened filters.</param>
        public string ToExpression(IList<Filter> filters)
        {
            if (Filters != null && Filters.Any())
            {
                return "(" + String.Join(" " + Logic + " ", Filters.Select(filter => filter.ToExpression(filters)).ToArray()) + ")";
            }

            int index = filters.IndexOf(this);

            string comparison = operators[Operator];

            if (Operator == "doesnotcontain")
            {
                return String.Format("!{0}.{1}(@{2})", Field, comparison, index);
            }

            if (comparison == "StartsWith" || comparison == "EndsWith" || comparison == "Contains")
            {
                return String.Format("{0}.{1}(@{2})", Field, comparison, index);
            }

            return String.Format("{0} {1} @{2}", Field, comparison, index);
        }
    }

    public interface IKendoGrid
    {
        IQueryable<T> Filter<T>(IQueryable<T> queryable, Filter filter);
        IQueryable<T> Sort<T>(IQueryable<T> queryable, IEnumerable<Sort> sort);
    }

    public class KendoGrid : IKendoGrid
    {
        public IQueryable<T> Filter<T>(IQueryable<T> queryable, Filter filter)
        {
            if (filter != null && filter.Logic != null)
            {
                // Collect a flat list of all filters
                var filters = filter.All();

                // Get all filter values as array (needed by the Where method of Dynamic Linq)
                var values = filters.Select(f => f.Value).ToArray();

                // Create a predicate expression e.g. Field1 = @0 And Field2 > @1
                string predicate = filter.ToExpression(filters);

                // Use the Where method of Dynamic Linq to filter the data
                queryable = queryable.Where(predicate, values);
            }

            return queryable;
        }

        public IQueryable<T> Sort<T>(IQueryable<T> queryable, IEnumerable<Sort> sort)
        {
            if (sort != null && sort.Any())
            {
                // Create ordering expression e.g. Field1 asc, Field2 desc
                var ordering = String.Join(",", sort.Select(s => s.ToExpression()));

                // Use the OrderBy method of Dynamic Linq to sort the data
                return queryable.OrderBy(ordering);
            }

            return queryable;
        }
    }
}
