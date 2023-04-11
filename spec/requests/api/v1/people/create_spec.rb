require "swagger_helper"

RSpec.describe "Create Person" do
  path "/api/v1/people" do
    post "Creates a person" do
      tags "Person"
      consumes "application/vnd.api+json"
      produces "application/vnd.api+json"
      parameter name: :person, in: :body, schema: {
        type: :object,
        properties: {
          data: {
            type: :object,
            properties: {
              type: {
                type: :string,
                default: "people"
              },
              attributes: {
                type: :object,
                properties: {
                  first_name: {
                    type: :string,
                    example: "John"
                  },
                  last_name: {
                    type: :string ,
                    example: "Doe"
                  },
                  email: {
                    type: :string ,
                    example: "johndoe@example.com"
                  }
                },
                required: ["first_name", "email"]
              }
            },
          }
        }
      }

      response "201", "Person created" do
        schema type: :object,
          properties: {
            data: {
              type: :object,
              properties: {
                id: { type: :string },
                type: { type: :string },
                attributes: {
                  type: :object,
                  properties: {
                    first_name: { type: :string },
                    last_name: { type: :string, nullable: true },
                    email: { type: :string }
                  }
                }
              }
            }
          }

        example "application/vnd.api+json", :person, {
          data: {
            id: "1",
            type: "people",
            attributes: {
              first_name: "John",
              last_name: "Doe",
              email: "johndoe@example.com"
            }
          }
        }

        let(:person) do
          {
            data: {
              type: "people",
              attributes: {
                first_name: Faker::Name.first_name,
                email: Faker::Internet.email
              }
            }
          }
        end

        run_test!
      end

      response "422", "Invalid request" do
        schema type: :object,
          properties: {
            errors: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  title: { type: :string },
                  detail: { type: :string },
                  code: { type: :string },
                  source: {
                    type: :object,
                    properties: {
                      pointer: { type: :string }
                    }
                  },
                  status: { type: :string }
                }
              }
            }
          }

        example "application/vnd.api+json", :error, {
          errors: [
            {
              title: "can't be blank",
              detail: "first-name - can't be blank",
              code: "100",
              source: {
                  pointer: "/data/attributes/first-name"
              },
              status: "422"
            }
          ]
        }

        let(:person) do
          {
            data: {
              type: "people",
              attributes: { email: Faker::Internet.email }
            }
          }
        end

        run_test!
      end
    end
  end
end
