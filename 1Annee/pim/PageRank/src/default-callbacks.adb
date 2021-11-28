
with AWS.Messages;
with AWS.MIME;

package body Default.Callbacks is

   -------------
   -- Default --
   -------------

   function Default (Request : in Status.Data) return Response.Data is
      URI : constant String := Status.URI (Request);
   begin
      if URI = "/" then
         return Response.Build
           (MIME.Text_HTML, "<p>Hello World!");
      else
         return Response.Acknowledge (Messages.S404);
      end if;
   end Default;

end Default.Callbacks;
