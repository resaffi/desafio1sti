require 'spec_helper'

describe CSVParser do
    let (:csv_object) { CSVParser.new(nil) }
    context 'new object'
    it 'should raise an exception given an invalid file' do
        expect{csv_object}.to output{"Error ao abrir"}.to_stdout
    end

    describe '.parse_csv' do
        it 'should raise an excetion given a bad csv' do
            bad_csv = '""Words","email@email.com","","4253","57574","FirstName","","LastName, MD","","","576JFJD","","1971","","Words","Address","SUITE "A"","City","State","Zip","Phone","","" '
            csv_object.csv_data = bad_csv
            expect{csv_object.parse_csv}.to output("Bad CSV\n").to_stdout

        end
    end

end

