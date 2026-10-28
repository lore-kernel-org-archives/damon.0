Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206329;
	b=x86xOZrno0guGW6ZXYySQ+9PBd2SdgdqRm6bHI1L5N52lgFZ0l3LOXi66QYUKfqmcteX
	 dGQNF5P5Nd+E6XC/J9V+keaWhZ2bmh08UJG4wNrwDevTyOt9WEjVnnUVHXJlRxDpDaHzr
	 espksUkVk0BZBiMnt+fdVQts1vinamz0fv0bvJz8Z1Fg4ILkfleuFDPaasSh8rm5KA3F/
	 ZKhTDIj6HGJlF0twJsaRRCRqkic69j+ym5pEtoMddivkH05nKgHHnknRI8SqU1qE7K7nU
	 z+7TterxqTaKHe+F7re/8ut5PVrQnDTdf+6ZCoJw07P1a5pokAv612OmLTTGnZCd5YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206329;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-MBO-RS-META:X-MBO-RS-ID;
	bh=1YA1pnK2XncY5lqNVKOymhfOhZgmGZ7s1l1eW83JveE=;
	b=Ge09TiCe5cNRG+rotRUW0daJRJ/Z6PErpFWhE4s0FfR/FPpynJB5DLQGfmE9wTt6opYi
	 uSO08Y8qi/spVlWx5o5IXjzEsUf99OaC/n+IxH5tePQnItHLnHp+WmbHWX2arVkTZ+kzh
	 NjDIt78rWfXipNbK/UrU1rrs9I/b/DPIBIQhGgNca0HfITqC2uLmK2QRHVC3AizXqFNdB
	 a94l5Bq+FfNAxlfh7zndYpN1j2HOXVKUP0I/I7DTG5PsbGpH76YQlPpdiYBZoagV90VFj
	 fmpwQ1R2Tu5kuPvcEjD3axl8K3VXLM03tPPyy7tJHFrKTZWupOQesXks7nXW/oUcbkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=uUL+AdTg;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C324F606A31D
	for <damon@lists.linux.dev>; Wed, 28 Oct 2026 16:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C324F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=uUL+AdTg
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jFD102sZ8zMllN;
	Wed, 28 Oct 2026 17:52:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793206324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1YA1pnK2XncY5lqNVKOymhfOhZgmGZ7s1l1eW83JveE=;
	b=uUL+AdTgjM/9MiitX0whRTqEsijLx4C6KdxAhwRCKa0kb4eF0Sce7/FRtdiqf2XOzEBkdj
	p1g/KbhveW0qdGPfM04WDSHoIs6eUPJr3gwrhbkhffZmV6urAxgFaSb8zXDRRn491Bcj73
	1998YgkwZ3sEs2iPBApCD92oTVrYT701g8LIV4FO2QCQTaayhbVZVh35FT2/3fkzfEpN+w
	FBgPKyoMFdUPE56H6PeN7wv4KhcWdo584HvmGg5rAfhUCgDP0WpxW7h0HyytreXRGViHIl
	dHX1AlkEA1X54Ld0YUEkrKli/q4bDzbC600FPJIx8B4dE/bMkQX99lk9cuzWOA==
Message-ID: <1303b843e41498612cce4acdbb47941c054bcf7d.camel@mailbox.org>
Subject: Re: [PATCH v2 1/2] Docs/admin-guide/mm/damon/reclaim: improve
 grammar and style
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: SJ Park <sj@kernel.org>
Cc: corbet@lwn.net, damon@lists.linux.dev, jm5905938@gmail.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, 	rdunlap@infradead.org, skhan@linuxfoundation.org
Date: Wed, 28 Oct 2026 17:52:01 +0100
In-Reply-To: <20261028000637.157110-1-sj@kernel.org>
References: <20261028000637.157110-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MBO-RS-META: jjn9q5xi6rqow5uypb9g11hnxcsctzaq
X-MBO-RS-ID: 7eb96ce423f99d218cd

Hi SJ,

On Tue, 2026-10-27 at 17:06 -0700, SJ Park wrote:
> On Tue, 27 Oct 2026 20:05:04 +0100 Manuel Ebner <manuelebnerli@mailbox.or=
g> wrote:
>=20
> > Fix upper case. Fix tenses. Replace 'set as' with 'set to'. Add space a=
fter
> > sentence to make it double space.
> >=20
> > Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> > CC: Aveline Noir <jm5905938@gmail.com>
> > ---
> > @ -113,8 +113,8
> > Choose as you wish.

I will refer to this below.

> >=20
> > @ 20
> > should be:
> > -Free Pages Reporting [3]_ based
> > +Free pages reporting [3]_ based
> > or
> > +'*Free Pages Reporting'* [3]_ based
> > * the right kind of quoting/ kernel-doc highlighting.
> > Choose as you wish.
> > ---
> > =C2=A0.../admin-guide/mm/damon/reclaim.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 36 +++++++++----------
> > =C2=A01 file changed, 18 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documenta=
tion/admin-guide/mm/damon/reclaim.rst
> > index e4e2ffa52e..0bab2299ea 100644
> > --- a/Documentation/admin-guide/mm/damon/reclaim.rst
> > +++ b/Documentation/admin-guide/mm/damon/reclaim.rst
> [...]
> > @@ -30,12 +30,12 @@ guests could mitigate this problem.
> > =C2=A0How It Works?
> > =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0
> > -DAMON_RECLAIM finds memory regions that didn't accessed for specific t=
ime
> > +DAMON_RECLAIM finds memory regions that weren't accessed for specific =
time
> > =C2=A0duration and page out.=C2=A0 To avoid it consuming too much CPU f=
or the paging out
> > =C2=A0operation, a speed limit can be configured.=C2=A0 Under the speed=
 limit, it pages
> > -out memory regions that didn't accessed longer time first.=C2=A0 Syste=
m
> > +out memory regions that weren't accessed longer time first.=C2=A0 Syst=
em
> > =C2=A0administrators can also configure under what situation this schem=
e should
> > -automatically activated and deactivated with three memory pressure wat=
ermarks.
> > +automatically be activated and deactivated with three memory pressure =
watermarks.
>=20
> Let's keep 80 columns limit.=C2=A0 Same for below.

Okay.

> [...]
> > @@ -113,10 +113,10 @@ quota_sz
> > =C2=A0
> > =C2=A0Limit of size of memory for the reclamation in bytes.
> > =C2=A0
> > -DAMON_RECLAIM charges amount of memory which it tried to reclaim withi=
n a time
> > -window (quota_reset_interval_ms) and makes no more than this limit is =
tried.
> > -This can be used for limiting consumption of CPU and IO.=C2=A0 If this=
 value is
> > -zero, the limit is disabled.
> > +DAMON_RECLAIM records the amount of memory which it tried to reclaim w=
ithin a time
>=20
> Didn't we agree to keep use "charge" ?

I thought we agreed to "records' but I sensed a misunderstanding. That's wh=
y I wrote
> > @ -113,8 +113,8
> > Choose as you wish.
above. Should i have been more explicit?

Thanks
 Manuel
>=20
> Other than the above two things, looks good to me.
>=20
>=20
> Thanks,
> SJ
>=20
> [...]
