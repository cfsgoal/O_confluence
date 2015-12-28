module type Jsonable = Common.Jsonable

module Attachment : sig
  type t =
    { id : int option
    ; pageId : string option
    ; title : string option
    ; fileName : string option
    ; fileSize : string option
    ; contentType : string option
    ; created : int option
    ; creator : string option
    ; url : string option
    ; comment : string option
    }

  include Jsonable with type t := t
end

module Blogentry : sig
  type t =
    { id : int option
    ; space : string option
    ; title : string option
    ; url : string option
    ; version : int option
    ; content : string option
    ; permissions : int option
    }

  include Jsonable with type t := t
end

module Blogentrysummary : sig
  type t =
    { id : int option
    ; space : string option
    ; title : string option
    ; url : string option
    ; permissions : int option
    ; publishDate : int option
    }

  include Jsonable with type t := t
end

module Clusterinformation : sig
  type t =
    { isRunning : bool option
    ; name : string option
    ; numberCount : int option
    ; description : string option
    ; multicastAddress : string option
    ; multicastPort : string option
    }

  include Jsonable with type t := t
end

module Comment : sig
  type t =
    { id : int option
    ; pageId : string option
    ; title : string option
    ; content : string option
    ; url : string option
    ; created : int option
    ; creator : string option
    }

  include Jsonable with type t := t
end

module Contentpermission : sig
  type t =
    { type_ : string option
    ; userName : string option
    ; groupName : string option
    }

  include Jsonable with type t := t
end

module Contentpermissionset : sig
  type t =
    { type_ : string option
    ; contentPermissions : Contentpermission.t list option
    }

  include Jsonable with type t := t
end

module Contentsummaries : sig
  type t =
    { totalAvailable : int option
    ; offset : int option
    ; content : Contentsummary.t list option
    }

  include Jsonable with type t := t
end

module Contentsummary : sig
  type t =
    { id : int option
    ; type_ : string option
    ; space : string option
    ; status : string option
    ; title : string option
    ; created : int option
    ; creator : string option
    ; modified : int option
    ; modifier : string option
    }

  include Jsonable with type t := t
end

module Label : sig
  type t =
    { name : string option
    ; owner : string option
    ; namespace : string option
    ; id : int option
    }

  include Jsonable with type t := t
end

module Nodestatus : sig
  type t =
    { nodeId : int option
    ; jvmStats : string option
    ; props : string option
    ; buildStats : string option
    }

  include Jsonable with type t := t
end

module Pagehistorysummary : sig
  type t =
    { id : int option
    ; version : int option
    ; modifier : string option
    ; modified : int option
    ; versionComment : string option
    }

  include Jsonable with type t := t
end

module Page : sig
  type t =
    { id : int option
    ; space : string option
    ; parentId : int option
    ; title : string option
    ; url : string option
    ; version : int option
    ; content : string option
    ; created : int option
    ; creator : string option
    ; modified : int option
    ; modifier : string option
    ; homePage : bool option
    ; permissions : int option
    ; contentStatus : string option
    ; current : bool option
    }

  include Jsonable with type t := t
end

module Pagesummary : sig
  type t =
    { id : int option
    ; space : string option
    ; parentId : int option
    ; title : string option
    ; url : string option
    ; permissions : int option
    }

  include Jsonable with type t := t
end

module Pageupdateoptions : sig
  type t =
    { versionComment : string option
    ; minorEdit : bool option
    }

  include Jsonable with type t := t
end

module Searchresult : sig
  type t =
    { title : string option
    ; url : string option
    ; excerpt : string option
    ; type_: string option
    ; id : int option
    }

  include Jsonable with type t := t
end

module Serverinfo : sig
  type t =
    { majorVersion     : int option
    ; minorVersion     : int option
    ; patchLevel       : int option
    ; buildId          : string option
    ; developmentBuild : bool option
    ; baseUrl          : string option
    }

  include Jsonable with type t := t
end

module Space : sig
  type t =
    { key : string option
    ; name : string option
    ; url : string option
    ; homePage : int option
    ; description : string option
    }

  include Jsonable with type t := t
end

module Spacepermissionset : sig
  type t =
    { type_ : string option
    ; contentPermissions : Contentpermission.t list option
    }

  include Jsonable with type t := t
end

module Spacesummary : sig
  type t =
    { key : string option
    ; name : string option
    ; type_ : string option
    ; url : string option
    }

  include Jsonable with type t := t
end

module Userinformation : sig
  type t =
    { username : string option
    ; content : string option
    ; creatorName : string option
    ; lastModifierName : string option
    ; version : int option
    ; id : int option
    ; creationDate : int option
    ; lastModificationDate : int option
    }

  include Jsonable with type t := t
end

module User : sig
  type t =
    { name : string option
    ; fullname : string option
    ; email : string option
    ; url : string option
    }

  include Jsonable with type t := t
end
