import std.mmfile   : MmFile;
import std.ascii    : isWhite, newline, toUpper;
import std.array    : split, array, appender;
import std.algorithm: filter, map;
import std.conv     : to;
debug import std.stdio;

struct Fasta{
    string header;
    string[] sequence;

    @property string toString() const{
        string result = "";
        auto fasta  = appender(&result);
        fasta.put( header.idup ~ newline );
        foreach( seq; sequence )
            fasta.put( seq.idup ~ newline );
        return result;
    }
}

bool isNewline(dchar c) @safe pure nothrow {
    return ( c == 0x0A || c == 0x0D )? true : false;
}

struct byFasta{
    private:
    MmFile _file;
    size_t _pos;
    Fasta  _fasta;
    bool   _isEmpty;
    bool   _isInit;

    @property
    bool _empty(){ _isEmpty =  _pos >= _file.length ; return _isEmpty; }

    public:
    this( in string filename ){
        this( new MmFile( filename ) );
    }
    this( MmFile file ){
        _isEmpty    = false;
        _isInit     = false;
        _file       = file;
    }


    @property
    bool empty(){ return _isEmpty ; }

    @property
    ref Fasta front(){
        debug writefln( "[front] position: %d max: %d empty: %s", _pos, _file.length, empty );
        if( !_isInit ){
            _isInit             = true;
            popFront();
            debug writefln( "[front] position: %d max: %d empty: %s", _pos, _file.length, empty );
        }
        return _fasta;
    }

    void popFront(){
        void moveToFastaHeader(){
            bool isSearching = true;
            while( isSearching ){
                if( _empty || _file[_pos] == 62 )    // 62 is char >
                    isSearching = false;
                else
                    _pos++;
            }
        }
        void moveToNewline(){
            bool isSearching = true;
            while( isSearching ){
                if( _empty || isNewline( cast(dchar)_file[_pos] ) )
                    isSearching = false;
                else
                    _pos++;
            }
        }

        _fasta = _fasta.init;
        if( !_empty ){
            size_t startHeader = _pos;
            moveToNewline();
            _fasta.header = cast(string) _file[startHeader .. _pos];
            _pos++;
            size_t startSeq = _pos;
            moveToFastaHeader();
            _fasta.sequence = (cast(string)_file[startSeq .. _pos])
                                                        .split(newline)
                                                        .map!( (s) => s.filter!( c => !isWhite( c ) )
                                                                        .map!( c => toUpper(c) ) // maybe is useless cost too cpu time
                                                                        .to!(string) )
                                                        .array
                                                        .to!(string[]);
        }
        if( _empty && _fasta != _fasta.init)
            _isEmpty    = false;
    }

    @property
    ref Fasta back(){
        debug writefln( "[back] position: %d max: %d empty: %s", _file.length - _pos, _file.length, empty );
        if( !_isInit ){
            _isInit             = true;
            popBack();
            debug writefln( "[back] position: %d max: %d empty: %s", _file.length - _pos, _file.length, empty );
        }
        return _fasta;
    }

    void popBack(){
        void moveToFastaHeader(){
            bool isSearching = true;
            while( isSearching ){
                if( _empty || _file[_file.length - _pos - 1] == 62 )    // 62 is char >
                    isSearching = false;
                else
                    _pos++;
            }
        }
        sizediff_t findNewline(){
            size_t index = _pos;
            bool isSearching = true;
            while( isSearching ){
                if( index == 0  || isNewline( cast(dchar)_file[_file.length - index - 1] ) )
                    isSearching = false;
                else
                    index--;
            }
            if( index == 0 && !isNewline( cast(dchar)_file[_file.length - index - 1] ) )
                index = -1;
            else
                index = cast(uint)_file.length - index - 1;
            return index;
        }

        _fasta          = _fasta.init;
        size_t endSeq   = cast(uint)_file.length - _pos - 1;
        moveToFastaHeader();
        if( !_empty ){
            size_t      startHeader = cast(uint)_file.length - _pos - 1;
            sizediff_t  endHeader   = findNewline();
            if( endHeader >= 0 ){
                _fasta.header = cast(string) _file[startHeader .. endHeader];
                _pos++;
                size_t startSeq = endHeader + 1;
                _fasta.sequence = (cast(string)_file[startSeq .. endSeq])
                                                            .split(newline)
                                                            .map!( (s) => s.filter!( c => !isWhite( c ) )
                                                                            .map!( c => toUpper(c) ) // maybe is useless cost too cpu time
                                                                            .to!(string) )
                                                            .array
                                                            .to!(string[]);

            }
            else
                assert( 0, "Error when searching back newline in header" );
        }
        if( _empty && _fasta != _fasta.init)
            _isEmpty    = false;
    }

    @property
    ref byFasta save(){
        return this;
    }

}


void main(){
    import std.stdio;
    import std.file;
    import std.range;
    File fastaFile = File( "sequence.fasta", "w");
    fastaFile.write(
">SEQUENCE_1
MTEITAAMVKELRESTGAGMMDCKNALSETNGgfdkavqllREKGLGKAAKKADRLAAEG
LVSVKVSDDFTIAAMRPSYLSYEDLDMTFVENEYKALVAELEKENEERRRLKDPNKPEHK
IPQFASRKQLSDAILKEAEEKIKEELKAQGKPEKIWDNIIPGKMNSFIADNSQLDSKLTL
MGQFYVMDDKKTVEQVIAEKEKEFGGKIKIVEFICFEVGEGLEKKTEDFAAEVAAQL
>SEQUENCE_2
SATVSEINS ETDFVAKNDQFIALTK DTTAHIQSNSLQSVEELHSS TINGVKFEEYLKSQI
ATIGENLVVRRFATLKAGANGVVNGYIHTNGRVGVVIAAACDSAEVASKSRDLLRQICMH"
);
    fastaFile.close;
    string fastaname = "sequence.fasta";
    scope(exit) remove(fastaname);

    writeln( "test 1" );

    foreach( Fasta f; byFasta(fastaname) )
        writeln( f );

    writeln( "test 2" );

    MmFile mf1 = new MmFile( fastaname );
    foreach( Fasta f; mf1.byFasta() )
        writeln( f );

    writeln( "test 3" );

    MmFile mf2 = new MmFile( fastaname );
    writeln( take(mf2.byFasta, 2) );

    writeln( "test 4" );

    MmFile mf3 = new MmFile( fastaname );
    foreach( Fasta f; retro( mf3.byFasta() ) )
        writeln( f );

    writeln( "test 5" );
    auto bf = retro( byFasta( fastaname ) );
    writeln( takeOne( bf )[0] );
    writeln( takeOne( retro( bf ) )[0] );

}
