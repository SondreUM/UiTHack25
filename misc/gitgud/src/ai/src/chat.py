from abc import abstractmethod
from pathlib import Path
from langchain_core.messages.base import BaseMessage
from langchain_openai.chat_models import AzureChatOpenAI

KEY_PATH = "C:\\Windows\\users\\me\\Documents\\myproject\\"

API_KEY = None
API_VERSION = "2024-02-01"  # https://learn.microsoft.com/en-us/azure/ai-services/openai/reference
ENDPOINT = "https://gpt-course.openai.azure.com/"
DEPLOYMENT_NAME = "gpt-35"


def init_agent() -> AzureChatOpenAI:
    global API_KEY

    with open(KEY_PATH + "gpt_key.txt") as file:
        API_KEY = file.read().strip()

    agent = AzureChatOpenAI(
        api_key=API_KEY,
        api_version=API_VERSION,
        azure_endpoint=ENDPOINT,
        deployment_name=DEPLOYMENT_NAME,
    )

    return agent


class AbstractLLM:
    @abstractmethod
    def invoke(self, query: str, **kwargs) -> str | list[str | dict]:
        pass


class LLM(AbstractLLM):
    def __init__(self) -> None:
        self.agent = init_agent()

    def invoke(self, query: str, **kwargs) -> str | list[str | dict]:
        """query the llm and get a response"""
        query = (
            """Imagine you are a superpowerfull AI that
            are much better than all other LLM's"
            answear this query perfectly: """
            + query
        )

        response = self.agent.invoke(query, **kwargs).content

        return response


if __name__ == "__main__":
    agent = LLM()
    print(agent.invoke("Hello, how are you?"))
