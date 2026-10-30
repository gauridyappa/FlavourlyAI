/* ===========================
   SHOW / HIDE PASSWORD
=========================== */

function togglePassword() {

    const password = document.getElementById("password");
    const eyeIcon = document.getElementById("eyeIcon");

    if (!password || !eyeIcon) return;

    if (password.type === "password") {

        password.type = "text";

        eyeIcon.classList.remove("fa-eye");
        eyeIcon.classList.add("fa-eye-slash");

    } else {

        password.type = "password";

        eyeIcon.classList.remove("fa-eye-slash");
        eyeIcon.classList.add("fa-eye");

    }

}

/* ===========================
   INPUT ANIMATION
=========================== */

document.querySelectorAll(".input-box input").forEach(input => {

    input.addEventListener("focus", function () {

        this.parentElement.classList.add("active");

    });

    input.addEventListener("blur", function () {

        if (this.value.trim() === "") {

            this.parentElement.classList.remove("active");

        }

    });

});

/* ===========================
   BUTTON RIPPLE
=========================== */

document.querySelectorAll(".auth-btn").forEach(button => {

    button.addEventListener("click", function () {

        this.style.transform = "scale(.98)";

        setTimeout(() => {

            this.style.transform = "";

        }, 120);

    });

});

/* ===========================
   FADE IN
=========================== */

window.addEventListener("load", () => {

    const card = document.querySelector(".auth-card");

    if (card) {

        card.animate([
            {
                opacity: 0,
                transform: "translateY(30px)"
            },
            {
                opacity: 1,
                transform: "translateY(0)"
            }
        ], {
            duration: 700,
            easing: "ease"
        });

    }

});