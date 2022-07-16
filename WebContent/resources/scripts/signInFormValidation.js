/**
 * 
 */
	function formValidation() {

			var email = document.signIn.email;
			var password = document.signIn.password;
			var password1 = document.signIn.password1;
			
			var errorBox= document.getElementById("errorMessage"); 
			var alertDiv= '<div class="alert alert-danger alert-dismissible" role="alert"> '; 
			var alertBtn= '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>';

			email.style.border="1px solid #2e8c6a"; 
			password.style.border="1px solid #2e8c6a"; 
			password1.style.border="1px solid #2e8c6a"; 
			
			if(passwordValidation(password,password1,3,32, errorBox,alertDiv, alertBtn)){
				if(emailValidation(email ,errorBox, alertDiv, alertBtn)){
					if(nameValidation(username ,errorBox, alertDiv, alertBtn)) {
					return true;
					}
					}
				}
			return false;
		}

		function emailValidation(myEmail, errorBox, alertDiv, alertBtn) {
			var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;

			if (!(myEmail.value.match(mailformat))) {
				errorBox.innerHTML = alertDiv
						+ alertBtn
						+ '<strong>Attenzione!</strong> L email non rispetta i requisiti'
						+ '</div>';
				myEmail.focus();
				myEmail.style.border = "3px solid red";
				return false;
			}
			return true;
		}

		function nameValidation(myName, errorBox, alertDiv, alertBtn) {
			var letters = /^[A-Za-z_ ]+$/;

			if (myName.value.match(letters)) {
				return true;
			} else {
				errorBox.innerHTML = alertDiv
						+ alertBtn
						+ '<strong>Attenzione!</strong> Il nome deve contenere soltano lettere dell alfabeto'
						+ '</div>';
				myName.style.border = "3px solid red";
				myName.focus();
				return false;
			}
		}
		function passwordValidation(myPassword,myPassword1,minSize, maxSize, errorBox, alertDiv, alertBtn){
			var password_lengh= myPassword.value.length;
			var password_lengh1= myPassword1.value.length;
			
			if(password_lengh ==0 || password_lengh < minSize || password_lengh > maxSize)
			{
				errorBox.innerHTML=alertDiv + alertBtn + '<strong>Attenzione!</strong> La password non rispetta i requisiti'+'</div>' ; 
				myPassword.focus(); 
				myPassword.style.border="3px solid red";
				return false;
			}
			
			if(password_lengh != password_lengh1)
			{

				myPassword.focus(); 
				myPassword.style.border="3px solid red";
				myPassword1.style.border="3px solid red";
				errorBox.innerHTML=alertDiv + alertBtn + '<strong>Attenzione!</strong> Le due password non coincidono'+'</div>' ; 
				return false;
			}
			return true; 
		}
		function nameValidation(myName ,errorBox, alertDiv, alertBtn){
			var letters = /^[A-Za-z_ ]+$/;
			
			if(myName.value.match(letters)){
				return true; 
			}
			else {
			errorBox.innerHTML=alertDiv + alertBtn + '<strong>Attenzione!</strong> Il nome deve contenere soltano lettere dell alfabeto'+'</div>' ; 
				myName.style.border="3px solid red";
				myName.focus(); 
				return false;
			}
		}