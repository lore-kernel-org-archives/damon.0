Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206351;
	b=fILUrM2meDmUuFDSnO5FnyYuof9kmJjPfr4AnGLCh+dZ0zu2UxbMx8hEJ+Rig1blWEPb
	 D8gSCcsJYlh3lHLwSRftm8Sqo4DFYpUBUmXUku0UVCLPsxjnubArrCgg2aaJo0yYK1UyE
	 Jl/i1tuYVgs7oxYfaUBht8FD55adm5Tjh1gP0dZr7P8L6kae3o6UotJEY3yj/fZyNH6ao
	 jaVGD8Opf3Fc+npuFHPj5X87zkGcBcXIPQz57pr9QCHtNbunN/+4PazB/zreWE7qHwljH
	 6o1zG/bpUDI9ex4j/4gsw21SpWU7UaJc3dU1p1CnGhQMWSCANVIErbe+xzQRhznYC6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206351;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-MBO-RS-META:X-MBO-RS-ID;
	bh=kSZ/p9sni9dlI5eyNVwd3UwnEXwjdQ5OzLQCHA5zC4s=;
	b=VloFZmb81QtgoU0qNn4vL9kEcZjEZqHg6Gp/0yLQwIqEet/cwPFk6Bz5ldQORyKMaV/C
	 flHkRDKhgUBseXyu5wXTIosMImvuhtQDlyjrhsFVy3zB+Ke1LN5Ju905UKypS//UNwWvR
	 nS6w+LCNJbqpM+RpymVZqv76OWabsv1yXLHngw9LsCaIROhCXYW4Qplh57xLcKRoSF5UJ
	 WRASvv4f89Zr4U4sJOYpX6cnVjwSltcmS3+mJ6lpRx+3hGCeXLuhA59vHRLPzrE1FX/5A
	 kGGozwaFZNyE4d9iHBmkw93k8zQty9kzvQ/MW2jPqjin9Pe/GFBL+903y5f9wVQWcYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=c4YI6jiN;
	arc=none smtp.remote-ip=80.241.56.171
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CA4606A31C
	for <damon@lists.linux.dev>; Wed, 28 Oct 2026 16:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37CA4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=c4YI6jiN
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jFD1H4MqVzMldZ;
	Wed, 28 Oct 2026 17:52:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793206339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kSZ/p9sni9dlI5eyNVwd3UwnEXwjdQ5OzLQCHA5zC4s=;
	b=c4YI6jiNA9MhxQQZCQBsb1ni2h0Iue1tzEE22yE0Ik1gue0bcVU2bldk3IDx7Vv2mSoopf
	7NhVbX6I9F2iD/hW//I6u8UR2J46NfEjcn3f/sq4dbTvQ0VficRtoEJPk12aUDPSJy8TTM
	Ja4L0iwGdZ/fDEDYTb8aJz/LISm/uTOgzhoP9mMSdpQq42aRl9RK+vDA3IWTe+OHM7PHca
	RNgdTW/o5XZ/OO9mIHuOlUiq/Q8sPDUs63yd3OQ3bA6lKtEqBL1b/GoYH13nJE53nv9v0R
	qhEz+uV9YB86IsLe5Md2vBurF8mELDpO/RTi2+iyPzXK/+b2+c1jpFXUCZRYRw==
Message-ID: <e68efe96e67c8b72047f2ab01c874026cecb025b.camel@mailbox.org>
Subject: Re: [PATCH v2 2/2] Docs/admin-guide/mm/damon/reclaim: rewrite
 complex parts
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: SJ Park <sj@kernel.org>
Cc: corbet@lwn.net, damon@lists.linux.dev, jm5905938@gmail.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, 	rdunlap@infradead.org, skhan@linuxfoundation.org
Date: Wed, 28 Oct 2026 17:52:17 +0100
In-Reply-To: <20261028001916.157488-1-sj@kernel.org>
References: <20261028001916.157488-1-sj@kernel.org>
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
X-MBO-RS-META: 7ta55qyrcan3bsd387ztgpp8hdim5cs8
X-MBO-RS-ID: 36aca95019600dc8a51

Hi SJ,

On Tue, 2026-10-27 at 17:19 -0700, SJ Park wrote:
> Hello Manuel,
>=20
>=20
> On Tue, 27 Oct 2026 22:23:46 +0100 Manuel Ebner <manuelebnerli@mailbox.or=
g> wrote:
>=20
> > Rewrite complex sentences.
>=20
> Any special reason to keep this as a separated one?=C2=A0 I think it is o=
k to merge
> this into the first patch.

In this mail ( https://lore.kernel.org/all/20261016142921.126622-1-sj@kerne=
l.org/ )
> Let's do such rewriting with another patch.

I understood this as 'make it two patches'.

> > Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> > Suggested-by: Aveline Noir <jm5905938@gmail.com>
> > ---
> > Two more minor changes
> > @ 31
> > /s/attempts to pages out those/attempts to page out those/
> > @ 126
> > + 'is' to fix grammar
> >=20
> > =C2=A0.../admin-guide/mm/damon/reclaim.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 19 ++++++++++---------
> > =C2=A01 file changed, 10 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documenta=
tion/admin-guide/mm/damon/reclaim.rst
> > index 0bab2299ea..033686f410 100644
> > --- a/Documentation/admin-guide/mm/damon/reclaim.rst
> > +++ b/Documentation/admin-guide/mm/damon/reclaim.rst
> > @@ -30,12 +30,13 @@ guests could mitigate this problem.
> > =C2=A0How It Works?
> > =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0
> > -DAMON_RECLAIM finds memory regions that weren't accessed for specific =
time
> > -duration and page out.=C2=A0 To avoid it consuming too much CPU for th=
e paging out
> > -operation, a speed limit can be configured.=C2=A0 Under the speed limi=
t, it pages
> > -out memory regions that weren't accessed longer time first.=C2=A0 Syst=
em
> > -administrators can also configure under what situation this scheme sho=
uld
> > -automatically be activated and deactivated with three memory pressure =
watermarks.
> > +DAMON_RECLAIM identifies memory regions that have not been accessed fo=
r a
> > +specified period and attempts to page out those.=C2=A0 To avoid it con=
suming
> > +too much CPU for the paging out operation, a speed limit can be config=
ured.
> > +Within the configured speed limit, it prioritizes regions that have be=
en
> > +idle longer for reclamation.=C2=A0 System administrators can also conf=
igure under
> > +what situation this scheme should automatically be activated and deact=
ivated
> > +with three memory pressure watermarks.
> > =C2=A0
> > =C2=A0Interface: Module Parameters
> > =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > @@ -125,8 +126,8 @@ quota_reset_interval_ms
> > =C2=A0
> > =C2=A0The time/size quota charge reset interval in milliseconds.
> > =C2=A0
> > -The charge reset interval for the quota of time (quota_ms) and size
> > -(quota_sz).=C2=A0 That is, DAMON_RECLAIM does not try reclamation for =
more than
> > +The charge reset interval for the quota of time is quota_ms and for th=
e quota of
> > +size is quota_sz.=C2=A0 That is, DAMON_RECLAIM does not try reclamatio=
n for more than
> > =C2=A0quota_ms milliseconds or quota_sz bytes within quota_reset_interv=
al_ms
> > =C2=A0milliseconds.
>=20
> I think the original sentence was not that confusing.=C2=A0 Also, this ch=
anges the
> nuance of the sentence?=C2=A0 What the sentence is saying is
> "quota_reset_interval_ms is the charge reset interval for ...".=C2=A0 If =
this was
> really confusing, maybe we can add "quota_reset_interval_ms is " part.
>=20
> But, I start feeling we might trying too much polishing...?

I think the verb is missing or can you tell which the verb is? If you can
no fix is required.

>=20
> > =C2=A0
> > @@ -137,7 +138,7 @@ quota_mem_pressure_us
> > =C2=A0
> > =C2=A0Desired level of memory pressure-stall time in microseconds.
> > =C2=A0
> > -While keeping the caps that are set by other quotas, DAMON_RECLAIM aut=
omatically
> > +While respecting the limits imposed by other quotas, DAMON_RECLAIM aut=
omatically
> > =C2=A0increases and decreases the effective level of the quota aiming t=
his level of
> > =C2=A0memory pressure is incurred.=C2=A0 System-wide ``some`` memory PS=
I in microseconds
> > =C2=A0per quota reset interval (``quota_reset_interval_ms``) is collect=
ed and
>=20
> I'm not sure if the original sentence was really difficult to understand.
>=20
> I'd prefer dropping this change.

That's ok.

Will you handle the final edit or should I send a [v3]?

Thanks
 Manuel
>=20
>=20
> Thanks,
> SJ
>=20
> [...]
