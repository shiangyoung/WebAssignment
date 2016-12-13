using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using Testing.Models;

namespace Testing.Logic
{
    public class ShoppingCart : IDisposable
    {
        public int ShoppingCartId { get; set; }

        //Database context, need to change it to proper name
        private GalleryEntities1 _db = new GalleryEntities1();
        //Get the username for the currently logged in user



        public const string CartSessionKey = "CartId";

        public void AddToCart(int ProductId)
        {
            //retrive product from the database
            ShoppingCartId = 9001;

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
                    TotalPrice = 1 //CHANGE THE TOTAL PRICE LATER 
                };
                _db.CARTITEMs.Add(cartItem);
            } else
            {
                //If item exists in the cart, add quantity
                cartItem.Quantity++;
            }

            _db.SaveChanges();

        }

        public int getCartId()
        {
            
            MembershipUser membershipUser = Membership.GetUser("Username");
            Guid userId = new Guid();
            
            if(membershipUser != null)
            {
                
                userId = (Guid)membershipUser.ProviderUserKey;
            }

            if (HttpContext.Current.Session[CartSessionKey] == null)
            {
                //create the new cart id
                CART cart = new CART
                {
                    CartId = 9001,
                    Date = DateTime.Today,
                    Discount = 0,
                    UserId = userId
                };

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

        public decimal GetTotal()
        {
            ShoppingCartId = getCartId();
            // Multiply product price by quantity of that product to get        
            // the current price for each of those products in the cart.  
            // Sum all product price totals to get the cart total.   
            decimal? total = decimal.Zero;
            total = (decimal?)(from cartItems in _db.CARTITEMs
                               where cartItems.CartId == ShoppingCartId
                               select (int?)cartItems.Quantity *
                               cartItems.PRODUCT.Price).Sum();
            return total ?? decimal.Zero;
        }

        public ShoppingCart GetCart(HttpContext context)
        {
            using (var cart = new ShoppingCart())
            {
                cart.ShoppingCartId = cart.getCartId();
                return cart;
            }
        }
        //Update the shopping cart database
        public void UpdateShoppingCartDatabase(int cartId, ShoppingCartUpdates[] CartItemUpdates)
        {
            using (var db = new GalleryEntities1())
            {
                try
                {
                    //get the number of updated items
                    //Store them into a list
                    int CartItemCount = CartItemUpdates.Count();
                    List<CARTITEM> myCart = GetCartItems();
                    foreach (var cartItem in myCart)
                    {
                        // Iterate through all rows within shopping cart list
                        for (int i = 0; i < CartItemCount; i++)
                        {
                            if (cartItem.PRODUCT.ProductId == CartItemUpdates[i].ProductId)
                            {
                                //If the quantity is 0 or remove item checkbox is checked
                                if (CartItemUpdates[i].PurchaseQuantity < 1 || CartItemUpdates[i].RemoveItem == true)
                                {
                                    RemoveItem(cartId, cartItem.ProductId);
                                }
                                else
                                {
                                    UpdateItem(cartId, cartItem.ProductId, CartItemUpdates[i].PurchaseQuantity);
                                }
                            }
                        }
                    }
                }
                catch (Exception exp)
                {
                    throw new Exception("ERROR: Unable to Update Cart Database - " + exp.Message.ToString(), exp);
                }
            }
        }

        //Remove the item from the database
        public void RemoveItem(int removeCartID, int removeProductID)
        {
            using (var _db = new GalleryEntities1())
            {
                try
                {
                    var myItem = (from c in _db.CARTITEMs where c.CartId == removeCartID && c.PRODUCT.ProductId == removeProductID select c).FirstOrDefault();
                    if (myItem != null)
                    {
                        // Remove Item.
                        _db.CARTITEMs.Remove(myItem);
                        _db.SaveChanges();
                    }
                }
                catch (Exception exp)
                {
                    throw new Exception("ERROR: Unable to Remove Cart Item - " + exp.Message.ToString(), exp);
                }
            }
        }

        //Update the item in the database
        public void UpdateItem(int updateCartID, int updateProductID, int quantity)
        {
            using (var _db = new GalleryEntities1())
            {
                try
                {
                    var myItem = (from c in _db.CARTITEMs where c.CartId == updateCartID && c.PRODUCT.ProductId == updateProductID select c).FirstOrDefault();
                    if (myItem != null)
                    {
                        myItem.Quantity = quantity;
                        _db.SaveChanges();
                    }
                }
                catch (Exception exp)
                {
                    throw new Exception("ERROR: Unable to Update Cart Item - " + exp.Message.ToString(), exp);
                }
            }
        }

        //Empty the shopping cart
        public void EmptyCart()
        {
            ShoppingCartId = getCartId();
            var cartItems = _db.CARTITEMs.Where(
                c => c.CartId == ShoppingCartId);
            foreach (var cartItem in cartItems)
            {
                _db.CARTITEMs.Remove(cartItem);
            }
            // Save changes.             
            _db.SaveChanges();
        }

        public int GetCount()
        {
            ShoppingCartId = getCartId();

            // Get the count of each item in the cart and sum them up          
            
            int? count = (from CARTITEM in _db.CARTITEMs
                          where CARTITEM.CartId == ShoppingCartId
                          select (int?)CARTITEM.Quantity).Sum();
            // Return 0 if all entries are null         
            return count ?? 0;
        }

        //A structure to pass the necessary details
        public struct ShoppingCartUpdates
        {
            public int ProductId;
            public int PurchaseQuantity;
            public bool RemoveItem;
        }


    }
}