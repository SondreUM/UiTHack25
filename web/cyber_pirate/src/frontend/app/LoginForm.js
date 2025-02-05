"use client";

import { useState } from "react";
import { ToastContainer, toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";

function LoginForm() {
  const [SecretKey, setSecretKey] = useState("");
  const [showModal, setShowModal] = useState(false);
  const [responseText, setResponseText] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      const response = await fetch("https://uithack-2.td.org.uit.no:8005/api/login", {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: `key=${encodeURIComponent(SecretKey)}`,
      });

      const responseText = await response.text();

      if (responseText === "Login failed!") {
        throw new Error("Login failed");
      } else if (responseText === "Dont even think about it!") {
        toast.warning(responseText, {
          autoClose: 5000,
          hideProgressBar: false,
          closeOnClick: true,
          draggable: true,
          position: "bottom-center",
        });
      } else {
        setResponseText(responseText);
        setShowModal(true);
      }

      if (!response.ok) {
        throw new Error("Login failed");
      }

      // Handle successful login here
    } catch (error) {
      toast.error("Login failed", {
        autoClose: 5000,
        hideProgressBar: false,
        closeOnClick: true,
        draggable: true,
        position: "bottom-center",
      });
    }
  };

  return (
    <div className="relative">
      <form
        className="flex flex-col items-center justify-center"
        style={{ height: "50vh" }}
        onSubmit={handleSubmit}
      >
        <div className="flex flex-col">
          <label className="mb-2 text-green-500">
            Enter key:
            <input
              className="border border-green-500 bg-black text-green-500 p-2 rounded"
              type="text"
              value={SecretKey}
              onChange={(e) => setSecretKey(e.target.value)}
            />
          </label>
          <input
            className="bg-green-500 hover:bg-green-700 text-black p-2 rounded mt-4 transition duration-300 ease-in-out cursor-pointer"
            type="submit"
            value="Submit"
          />
        </div>
        <ToastContainer />
      </form>
      {showModal && (
        <div className="fixed inset-0 flex items-center justify-center bg-black bg-opacity-75 z-50">
          <div className="bg-green-500 text-black p-8 rounded shadow-lg text-center">
            <h2 className="text-4xl font-bold mb-4">Access Granted</h2>
            <p className="text-2xl">{responseText}</p>
            <button
              className="mt-4 bg-black text-green-500 p-2 rounded"
              onClick={() => setShowModal(false)}
            >
              Close
            </button>
          </div>
        </div>
      )}
    </div>
  );
}

export default LoginForm;
