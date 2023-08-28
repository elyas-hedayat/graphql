import graphene


class Query(graphene.ObjectType):
    hello = graphene.Field(graphene.String)

    @staticmethod
    def resolve_hello(parent, info, **kwargs):
        print(info.context.body)
        return  "hello"



schema = graphene.Schema(query=Query)
