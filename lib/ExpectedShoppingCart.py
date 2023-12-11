from SeleniumLibrary.base import LibraryComponent, keyword

class ExpectedShoppingCart:
    def __init__(self):
        self.items = []
    """
    Represents an online shopping cart and provides methods for managing its items.
    """

    @keyword
    def create_new_expected_shopping_cart(self):
        """
        Creates a new instance of the shopping cart.
        """
        new_cart = ExpectedShoppingCart()
        return new_cart

    @keyword
    def add_expected_item(self, item_id, quantity, price):
        """
        Adds an item to the shopping cart.
        Args:
            item_id: The ID of the item to add.
            quantity: The quantity of the item to add.
        """
        # Check if the item already exists in the cart
        for item in self.items:
            if item.id == item_id:
                item.quantity += quantity
                return

        # Create a new item instance
        price_value = int(price.replace("Rs. ", "").replace(",", ""))

        new_item = Item(item_id, quantity, price_value)

        # Add the item to the cart
        self.items.append(new_item)

    @keyword
    def get_expected_total_cost(self):
        """
        Calculates the total cost of all items in the cart.
        Returns:
            The total cost of all items in the cart.
        """
        total_cost = 0
        for item in self.items:
            # Convert quantity to integer before multiplying
            quantity_value = int(item.quantity)
            total_cost += item.price * quantity_value
        return total_cost
    
    @keyword
    def get_expected_cart_product_ids(self):
        """
        Retrieves the list of items IDs in the shopping cart.
        Returns:
            An array of product ids
        """
        item_ids = []
        for item in self.items:
            item_ids.append(item.id)
        return item_ids


class Item:

    """
    Represents a single item in the shopping cart.
    """

    def __init__(self, id, quantity, price):
        """
        Initializes an item instance.
        Args:
            id: The ID of the item.
            quantity: The quantity of the item.
            price: The price of the item.
        """
        self.id = id
        self.quantity = quantity
        self.price = price
