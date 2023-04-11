require "swagger_helper"

RSpec.describe "Read Person" do
  path "/api/v1/people/{id}" do
    get "Retrieves a person" do
      tags "Person"
      consumes "application/vnd.api+json"
      produces "application/vnd.api+json"
      parameter name: :id, in: :path, type: :string

      response "200", "Person found" do
        schema type: :object,
          properties: {
            data: {
              type: :object,
              properties: {
                id: { type: :string },
                type: { type: :string },
                links: {
                  type: :object,
                  properties: {
                    self: { type: :string }
                  }
                },
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
            links: {
              self: "http://localhost:3000/api/v1/people/1"
            },
            attributes: {
              first_name: "John",
              last_name: "Doe",
              email: "johndoe@example.com"
            }
          }
        }

        let(:id) { create(:person).id }

        run_test!
      end

      response "404", "Person not found" do
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
                status: { type: :string }
              }
            }
          }
        }

        example "application/vnd.api+json", :person, {
          errors: [
            {
              title: "Record not found",
              detail: "The record identified by 1 could not be found.",
              code: "404",
              status: "404"
            }
          ]
        }

        let(:id) { "1" }

        run_test!
      end
    end
  end
end
