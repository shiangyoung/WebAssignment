//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Testing.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class PAYMENT
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public PAYMENT()
        {
            this.ORDERs = new HashSet<ORDER>();
        }
    
        public int PaymentId { get; set; }
        public Nullable<System.DateTime> Date { get; set; }
        public string TotalPaid { get; set; }
        public string OrderId { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ORDER> ORDERs { get; set; }
    }
}
