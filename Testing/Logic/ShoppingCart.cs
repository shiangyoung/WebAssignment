using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Testing.Models;

namespace Testing.Logic
{
    public class ShoppingCart : IDisposable
    {
        public int ShoppingCartId { get; set; }

        //Database context, need to change it to proper name
        private GalleryEntities1 _db = new GalleryEntities1();

        public const string CartSessionKey = "CartId";

        public void AddToCart(int ProductId)
        {
            //retrive product from the database
            ShoppingCartId = getCartId();

            //This is to check if the cart has the item already or not
            var cartItem = _db.CARTITEMs.SingleOrDefault(
                c => c.CartId == ShoppingCartId &&
                c.ProductId == ProductId);

            //Cart item does not exist in the cart
            if (cartItem == null)
            {
                // Create new cartitem
                cartItem = new CARTITEM
                {
                    CartId = ShoppingCartId,
                    ProductId = ProductId,
                    Quantity = 1,
                    TotalPrice = 0 //CHANGE THE TOTAL PRICE LATER 
                };
                _db.CARTITEMs.Add(cartItem);
            } else
            {
                //If item exists in the cart, add quantity
                cartItem.Quantity++;
            }

            _db.SaveChanges();

        }

        private int getCartId()
        {
            if(HttpContext.Current.Session[CartSessionKey] == null)
            {
                //create the new cart id
                CART cart = new CART();

                HttpContext.Current.Session[CartSessionKey] = cart.CartId;
                return cart.CartId;
            }

            //if (HttpContext.Current.Session[CartSessionKey] == null)
            //{
            //    if (!string.IsNullOrWhiteSpace(HttpContext.Current.User.Identity.Name))
            //    {
            //        HttpContext.Current.Session[CartSessionKey] = HttpContext.Current.User.Identity.Name;
            //    }
            //    else
            //    {
            //        //NEED TO REPLACE THIS TO RETRIEVE CART ID FROM DATABASE
            //        // Generate a new random GUID using System.Guid class.     
            //        Guid tempCartId = Guid.NewGuid();
            //        HttpContext.Current.Session[CartSessionKey] = tempCartId.ToString();
            //    }
            //}
            string cartSessionKey = HttpContext.Current.Session[CartSessionKey].ToString();
            return int.Parse(cartSessionKey);
        }

        public List<CARTITEM> GetCartItems()
        {
            ShoppingCartId = getCartId();

            //Retrieves the cart items with the cart ID that is equal to session's cart ID
            return _db.CARTITEMs.Where(
                c => c.CartId == ShoppingCartId).ToList();
        }

        public void Dispose()
        {
            if(_db != null)
            {
                _db.Dispose();
                _db = null;
            }
        }

    
        
    }
}