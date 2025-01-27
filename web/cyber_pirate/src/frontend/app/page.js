import Image from "next/image";
import LoginForm from "./LoginForm";
import "./page.css";

export default function Home() {
  return (
    <div className="min-h-screen flex flex-col">
      <div className="flex justify-center items-center flex-grow">
        <div className="bg-black border border-green-500 rounded shadow-lg p-8">
      <header className="bg-black-500 text-white text-center text-4xl font-bold py-4 w-full flex justify-center items-center">
        TYPE IN THE SECRET KEY
      </header>
          <LoginForm />
        </div>
      </div>
    </div>
  );
}
