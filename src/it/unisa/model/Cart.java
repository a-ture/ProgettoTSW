package it.unisa.model;

import java.util.ArrayList;
import java.util.List;

import it.unisa.beans.CartProduct;
import it.unisa.beans.Product;

public class Cart {
	List<CartProduct> products;

	public Cart() {
		products = new ArrayList<>();
	}

	public void addProduct(Product product) {
		CartProduct cartProd = new CartProduct(product);
		if (products.contains(cartProd)) {
			var prod = products.get(products.indexOf(cartProd));
			prod.setQuantità(prod.getQuantità() + 1);
		} else {

			cartProd.setQuantità(1);
			products.add(cartProd);
		}
	}

	public void deleteProduct(Product product) {
		CartProduct cartProd = new CartProduct(product);
		for (CartProduct prod : products) {
			if (prod.equals(cartProd)) {
				products.remove(prod);
				break;
			}
		}
	}

	public boolean isEmpty() {
		return products.size() > 0 ? false : true;
	}

	public List<CartProduct> getProducts() {
		return products;
	}

	public int getTotalProductsQuantity() {
		var sum = 0;
		for (CartProduct prod : products) {
			sum += prod.getQuantità();
		}
		return sum;
	}

	public double getTotalPrice() {
		double sum = 0;
		for (CartProduct prod : products) {
			sum += prod.getTotalPrice();
		}
		return sum;
	}

	public void deleteAll() {
		products = new ArrayList<>();

	}

	public void updateProduct(Product product, int quantity) {
		CartProduct cartProd = new CartProduct(product);
		if (products.contains(cartProd)) {
			var prod = products.get(products.indexOf(cartProd));
			prod.setQuantità(quantity);
		}
	}

}
