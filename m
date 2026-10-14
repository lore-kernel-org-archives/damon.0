Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7907C54704D
	for <damon@lists.linux.dev>; Wed, 14 Oct 2026 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981312; cv=none; b=bjpzd9eRs6VCK7d1edqH+CjDqivTuqyFX9Sonn/yWfk83OdQVyh8Q6iepA2ax93RI/Svg3qIcLjsr028CWH5KA+0EJssvUdejam9u0rSCcnfdTajYJ1Ca1fEqdMRn9Nc+Q9G3i+568LgvDfXVDf/+SQsFGkfLwgobKuWsoCFptE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981312; c=relaxed/simple;
	bh=0AkDMeQD6/VjrX56ncWAfVnO24iSFNw/Yc8eC00oXyA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aEmKCLEDltBqvMh5XZsDzh+EA/sWPt/lPuLCIKN3ZxDBP4EPpSmy9dNf1+Z97HVe5e9q2XGgxCNULG30XtUKnbdu4ZsgPwMefWKK81qOVfFflDIRaojrdBzicMtZPF+koC2NOUlqhTLnYzHJWsSCDVtAbvdEfsqc1NgLlUtuzH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=PEsyjnDv; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PEsyjnDv"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j4Vyr23mFzMlTH;
	Wed, 14 Oct 2026 14:35:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791981300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=deI6tRQ3FBGqgf5VLrNCIzeDLo8uR0T/R2GhdiHbgig=;
	b=PEsyjnDveHgEGz6sTplxOjMmvpcUgyxRYPtDZ0CtqKD1uV4YZIv/jEDDqTeOT8w/DRqJmj
	1iw6VDB3vWUPqBbhJ3C27sf33T97t74lvpyqZ7sEAE57IkAOUXB9EjILmBLyAXb/RSCirM
	fBbCbwn9eSNoAViH48ZdNCnSp1M0V0rySxXNHSnA5v4kiiHmVesC8/7DGTgLPmr6cyoGxt
	AX3KvQtnWgJwq6/qn/RzTC4YSByjbSg0O9P+IQA5iTvSCxvyNBATujaosmwO3iiCmWKQqS
	B2n1gO3y+RWhSMaI9A9m2RhGynCe7RK0HcVPPbLtZMUwkmRyANXV/k2KuFVt+w==
Message-ID: <dfa05908286b5e5684ea0002dde1ee99627154a4.camel@mailbox.org>
Subject: Re: [PATCH] Docs/admin-guide/mm/damon/lru_sort: fix grammar and
 stlye
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	 <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
	 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
	 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	 <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	damon@lists.linux.dev, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2026 14:34:51 +0200
In-Reply-To: <20261014003258.142926-1-sj@kernel.org>
References: <20261014003258.142926-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MBO-RS-META: ko86gy8rzxz8iyf6ysb7mp1kfuurbwa6
X-MBO-RS-ID: 94973415d2ae5663d4b

Hi SJ,

On Tue, 2026-10-13 at 17:32 -0700, SJ Park wrote:
> Hi Manuel,
>=20
> On Tue, 13 Oct 2026 21:13:27 +0200 Manuel Ebner <manuelebnerli@mailbox.or=
g> wrote:
>=20
> > mention 'least-recently-used' AKA lru at the beginning
>=20
> I think the readers would know what LRU means, and therefore
> 'least-recently-used' is not needed.

I'm probably one of the few that doesn't know. I didn't think of the whole =
picture.
You are right.

>=20
> > set as -> set to
>=20
> This commit message is using incomplete sentences and describing only a f=
ew of
> changes.=C2=A0 Please make it to use complete sentences and cover all cha=
nges.

Will do.

>=20
> >=20
> > Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> > ---
> > =C2=A0.../admin-guide/mm/damon/lru_sort.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 51 ++++++++++---------
> > =C2=A01 file changed, 26 insertions(+), 25 deletions(-)
> >=20
> > diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Document=
ation/admin-guide/mm/damon/lru_sort.rst
> > index 0c04d238ed..3b6d122887 100644
> > --- a/Documentation/admin-guide/mm/damon/lru_sort.rst
> > +++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
> > @@ -4,8 +4,9 @@
> > =C2=A0DAMON-based LRU-lists Sorting
> > =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0
> > -DAMON-based LRU-lists Sorting (DAMON_LRU_SORT) is a static kernel modu=
le that
> > -aimed to be used for proactive and lightweight data access pattern bas=
ed
> > +DAMON-based least-recently-used-lists (short LRU-lists) Sorting
> > +(DAMON_LRU_SORT) is a static kernel module that aims to be used
> > +for proactive and lightweight data access pattern based
>=20
> As I mentioned above, I don't think the above change is needed.

K

> > =C2=A0(de)prioritization of pages on their LRU-lists for making LRU-lis=
ts a more
> > =C2=A0trustworthy data access pattern source.
> > =C2=A0
> > @@ -17,7 +18,7 @@ systems, LRU lists are normally not proactively sorte=
d but partially and
> >  As page-granularity access checking overhead could be significant on h=
uge

Is this huge as in big or huge pages. For the latter I would put it: ``huge=
 page``-systems
or `huge page`-systems.

> >  systems, LRU lists are normally not proactively sorted but partially a=
nd
> > =C2=A0reactively sorted for special events including specific user requ=
ests, system
> > =C2=A0calls and memory pressure.=C2=A0 As a result, LRU lists are somet=
imes not so
> > =C2=A0perfectly prepared to be used as a trustworthy access pattern sou=
rce for some
> > -situations including reclamation target pages selection under sudden m=
emory
> > +situations including reclamation of target pages selection under sudde=
n memory
> > =C2=A0pressure.
>=20
> I cannot find what's wrong with the original sentence.=C2=A0 Could you ex=
palin?
> Also, I think the updated sentence is rather easier to misread.

It's two long sentences, thus (I think) hard to understand. I _rewrote_ it =
this way:

As page-granularity access checking overhead could be significant on huge s=
ystems,
LRU lists are normally not fully nor proactively sorted but rather partiall=
y=20
and reactively sorted for special events.  These events include specific us=
er requests,
system calls and memory pressure.  As a result, LRU lists are sometimes not
suitable to be used as a trustworthy access pattern source. These situation=
s=C2=A0
including reclamation target page selection under sudden memory pressure.

Please note:
  target pages selection
->target page selection

> > =C2=A0
> > =C2=A0Because DAMON can identify access patterns of best-effort accurac=
y while
> > @@ -28,9 +29,9 @@ pattern source with low and controlled overhead.
> > =C2=A0How It Works?
> > =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0
> > -DAMON_LRU_SORT finds hot pages (pages of memory regions that showing a=
ccess
> > +DAMON_LRU_SORT finds hot pages (pages of memory regions that show acce=
ss
> > =C2=A0rates that higher than a user-specified threshold) and cold pages=
 (pages of
>=20
> rates that "are" higher?
... that show access rates that are higher ...
and=20

>=20
> > -memory regions that showing no access for a time that longer than a
> > +memory regions that show no access for a time that longer than a

... show no access for a duration that is longer than a=20

Then ack.

> > =C2=A0user-specified threshold) using DAMON, and prioritizes hot pages =
while
> > =C2=A0deprioritizing cold pages on their LRU-lists.=C2=A0 To avoid it c=
onsuming too much
> > =C2=A0CPU for the prioritizations, a CPU time usage limit can be config=
ured.=C2=A0 Under
> > @@ -63,10 +64,10 @@ enabled
> > =C2=A0
> > =C2=A0Enable or disable DAMON_LRU_SORT.
> > =C2=A0
> > -You can enable DAMON_LRU_SORT by setting the value of this parameter a=
s ``Y``.
> > -Setting it as ``N`` disables DAMON_LRU_SORT.=C2=A0 Note that DAMON_LRU=
_SORT could do
> > +You can enable DAMON_LRU_SORT by setting the value of this parameter t=
o ``Y``.
> > +Setting it to ``N`` disables DAMON_LRU_SORT.=C2=A0 Note that DAMON_LRU=
_SORT could do
> > =C2=A0no real monitoring and LRU-lists sorting due to the watermarks-ba=
sed activation
> > -condition.=C2=A0 Refer to below descriptions for the watermarks parame=
ter for this.
> > +condition.=C2=A0 Refer to below descriptions of the watermarks paramet=
er for this.
> > =C2=A0
> > =C2=A0commit_inputs
> > =C2=A0-------------
> > @@ -74,9 +75,9 @@ commit_inputs
> > =C2=A0Make DAMON_LRU_SORT reads the input parameters again, except ``en=
abled``.
> > =C2=A0
> > =C2=A0Input parameters that updated while DAMON_LRU_SORT is running are=
 not applied
> > -by default.=C2=A0 Once this parameter is set as ``Y``, DAMON_LRU_SORT =
reads values
> > +by default.=C2=A0 Once this parameter is set to ``Y``, DAMON_LRU_SORT =
reads values
> > =C2=A0of parameters except ``enabled`` again.=C2=A0 Once the re-reading=
 is done, this
> > -parameter is set as ``N``.=C2=A0 If invalid parameters are found while=
 the
> > +parameter is set to ``N``.=C2=A0 If invalid parameters are found while=
 the
> > =C2=A0re-reading, DAMON_LRU_SORT will be disabled.
> > =C2=A0
> > =C2=A0Once ``Y`` is written to this parameter, the user must not write =
to any
> > @@ -86,37 +87,37 @@ violate this rule, the kernel may exhibit undefined=
 behavior.
> > =C2=A0active_mem_bp
> > =C2=A0-------------
> > =C2=A0
> > -Desired active to [in]active memory ratio in bp (1/10,000).
> > +Desired active to (in)active memory ratio in bp (1/10,000).
>=20
> I think use of brackets is also fine.=C2=A0 Let me know if I'm missing so=
mething.

There is 2x (de)prioritization, 6x [de]prioritizations, 2x[in]active and a =
few more in the
file. They are all fine by themself, but not mixed. [] or ()?

>=20
> > =C2=A0
> > =C2=A0While keeping the caps that set by other quotas, DAMON_LRU_SORT a=
utomatically
> > =C2=A0increases and decreases the effective level of the quota aiming t=
he LRU
> > -[de]prioritizations of the hot and cold memory resulting in this activ=
e to
> > -[in]active memory ratio.=C2=A0 Value zero means disabling this auto-tu=
ning feature.
> > +(de)prioritizations of the hot and cold memory resulting in this activ=
e to
> > +(in)active memory ratio.=C2=A0 Value zero means disabling this auto-tu=
ning feature.
>=20
> Ditto.
>=20
> > =C2=A0
> > =C2=A0Disabled by default.
> > =C2=A0
> > =C2=A0autotune_monitoring_intervals
> > =C2=A0-----------------------------
> > =C2=A0
> > -If this parameter is set as ``Y``, DAMON_LRU_SORT automatically tunes =
DAMON's
> > +If this parameter is set to ``Y``, DAMON_LRU_SORT automatically tunes =
DAMON's
> > =C2=A0sampling and aggregation intervals.=C2=A0 The auto-tuning aims to=
 capture meaningful
> > =C2=A0amount of access events in each DAMON-snapshot, while keeping the=
 sampling
> > -interval 5 milliseconds in minimum, and 10 seconds in maximum.=C2=A0 S=
etting this as
> > -``N`` disables the auto-tuning.
> > +interval to 5 milliseconds in minimum, and to 10 seconds in maximum.=
=C2=A0 Setting this
> > +to ``N`` disables the auto-tuning.
> > =C2=A0
> > =C2=A0Disabled by default.
> > =C2=A0
> > =C2=A0filter_young_pages
> > =C2=A0------------------
> > =C2=A0
> > -Filter [non-]young pages accordingly for LRU [de]prioritizations.
> > +Filter (non-)young pages accordingly for LRU (de)prioritizations.
>=20
> Ditto.
>=20
> > =C2=A0
> > =C2=A0If this is set, check page level access (youngness) once again be=
fore each
> > -LRU [de]prioritization operation.=C2=A0 LRU prioritization operation i=
s skipped
> > +LRU (de)prioritization operation.=C2=A0 LRU prioritization operation i=
s skipped
>=20
> Ditto.
>=20
> > =C2=A0if the page has not accessed since the last check (not young).=C2=
=A0 LRU
> > =C2=A0deprioritization operation is skipped if the page has accessed si=
nce the
> > =C2=A0last check (young).=C2=A0 The feature is enabled or disabled if t=
his parameter is
> > -set as ``Y`` or ``N``, respectively.
> > +set to ``Y`` or ``N``, respectively.
> > =C2=A0
> > =C2=A0Disabled by default.
> > =C2=A0
> > @@ -235,7 +236,7 @@ max_nr_regions
> > =C2=A0Maximum number of monitoring regions.
> > =C2=A0
> > =C2=A0The maximum number of monitoring regions of DAMON for the cold me=
mory
> > -monitoring.=C2=A0 This can be used to set upper-bound of the monitorin=
g overhead.
> > +monitoring.=C2=A0 This can be used to set the upper-bound of the monit=
oring overhead.
> > =C2=A0However, setting this too low could result in bad monitoring qual=
ity.=C2=A0 Please
> > =C2=A0refer to the DAMON documentation (:doc:`usage`) for more detail.=
=C2=A0 1000 by
> > =C2=A0defaults.
> > @@ -268,7 +269,7 @@ This parameter is for setting and getting the :ref:=
`address unit
> > =C2=A0
> > =C2=A0``monitor_region_start`` and ``monitor_region_end`` should be pro=
vided in this
> > =C2=A0unit.=C2=A0 For example, let's suppose ``addr_unit``, ``monitor_r=
egion_start`` and
> > -``monitor_region_end`` are set as ``1024``, ``0`` and ``10``, respecti=
vely.
> > +``monitor_region_end`` are set to ``1024``, ``0`` and ``10``, respecti=
vely.
> > =C2=A0Then DAMON_LRU_SORT will work for 10 KiB length of physical addre=
ss range that
> > =C2=A0starts from address zero (``[0 * 1024, 10 * 1024)`` in bytes).
> > =C2=A0
> > @@ -291,22 +292,22 @@ If DAMON_LRU_SORT is enabled, this becomes the PI=
D of the worker thread.=C2=A0 Else,
> > =C2=A0nr_lru_sort_tried_hot_regions
> > =C2=A0-----------------------------
> > =C2=A0
> > -Number of hot memory regions that tried to be LRU-sorted.
> > +Number of hot memory regions that try to be LRU-sorted.
>=20
> that were tried to be ?

Ack. Now I know why it's in the past.

> > =C2=A0
> > =C2=A0bytes_lru_sort_tried_hot_regions
> > =C2=A0--------------------------------
> > =C2=A0
> > -Total bytes of hot memory regions that tried to be LRU-sorted.
> > +Total bytes of hot memory regions that try to be LRU-sorted.
>=20
> that were tried to be ?

Ack.

>=20
> > =C2=A0
> > =C2=A0nr_lru_sorted_hot_regions
> > =C2=A0-------------------------
> > =C2=A0
> > -Number of hot memory regions that successfully be LRU-sorted.
> > +Number of hot memory regions that are successfully LRU-sorted.
>=20
> that were ?

Ack.

>=20
> > =C2=A0
> > =C2=A0bytes_lru_sorted_hot_regions
> > =C2=A0----------------------------
> > =C2=A0
> > -Total bytes of hot memory regions that successfully be LRU-sorted.
> > +Total bytes of hot memory regions that are successfully LRU-sorted.
>=20
> that were ?

Ack.

>=20
> > =C2=A0
> > =C2=A0nr_hot_quota_exceeds
> > =C2=A0--------------------
> > --=20
> > 2.55.0
>=20
>=20
> Thanks,
> SJ

Thanks for the feedback
 Manuel
