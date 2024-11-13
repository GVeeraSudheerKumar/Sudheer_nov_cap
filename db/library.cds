namespace mycapapp.db;
using {mycapapp.commons as common} from './commons';
using {temporal, cuid, managed } from '@sap/cds/common';

context master {

    entity student: common.address {
        key id        : common.Guid;
            firstName : String(32);
            lastName  : String(32);
            age       : Int32;
            class : Association to one standard;

    }

    entity standard {
        key classId        : common.Guid;
            semester       : Integer;
            specialization : String(32);
            hod            : String(32);

    }

    entity books {
        key bookId: common.Guid;
        bookName: localized String(64);
        author: String(32);
        
    }
}

context transaction {
    entity subcriptions: cuid, temporal, managed {
        book: Association to one master.books;
        student: Association to one master.student;
    }
}
