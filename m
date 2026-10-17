Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8E146DFE4
	for <damon@lists.linux.dev>; Sat, 17 Oct 2026 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792228723; cv=none; b=tVnKx31575MH8RUgExXJQC3DUzH0oroWNIS4i/UJDclMTkkdjxA6ybGM1NEVwz4W8LPLtHobThroaMnGocTI45mNWCmYyLbScoWKrCZyOMC8RLCiPoydMGmaVq5xB5WS2mk+axyHJMjpoLCCQJnNH+ESW3PrLNKj+lSzojxA/lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792228723; c=relaxed/simple;
	bh=AJNqfW0ioAwXAyHgrrMYr3i85p2JVBdKUXfKlT6Pido=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dg7XDm07USmyNkybwGc+GKN+fE1PPPnrjEo1oDDaOEoRMoFDVDRlELFk130vhCapCxQAFxtB6I60TkF+ZKMiiCyC0R/2ZbYiG0elpd1kCPvkKb/W/clrbAyQLkB2H8l3sezx465hrCNrf3s5uKnosx0f6nrVWbYuZH45X02z+rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=UqxkiEmf; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UqxkiEmf"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j6GSs6Ct8zKnTY;
	Sat, 17 Oct 2026 11:18:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792228717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJNqfW0ioAwXAyHgrrMYr3i85p2JVBdKUXfKlT6Pido=;
	b=UqxkiEmf8ArLdQmOp8pJzr16B+51FF6wd4VGNwPO/FNzS9wMD4L7/Bw1W9+HrxX4DFJBCi
	KqL8s8ND8VeJOTdFwRlJFsG5Ixw6fkR9jChBnm7cE/8TwGKdjtyzWSJ2F5xskI94RkLHjJ
	DD942aHIEMFTwtPKU6CmFWoWSUvbQH/cBml5Ja36Nigncb2r92fmRxBQRlNl4+QwSPe8+G
	MK/DhOJEWw2tK3SL0FvP3hyxhKOSu+O20vHcHkEw+LrfF7hoW+K4KFha1rIHQpt0FHfmkk
	c3kRrkpvLs89UAhUewPF+EFadAunu790rbD7e9wWaNL5R7PWwZ7DR0zUGEPt2Q==
Message-ID: <c575314d3e52d5fcff3d6fc47d12dc118a24bd63.camel@mailbox.org>
Subject: Re: [PATCH] mm/damon/reclaim: improve grammar and style
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: SJ Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>,  Randy Dunlap <rdunlap@infradead.org>,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Aveline Noir <jm5905938@gmail.com>
Date: Sat, 17 Oct 2026 11:18:34 +0200
In-Reply-To: <20261015140122.87808-1-sj@kernel.org>
References: <20261015140122.87808-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MBO-RS-META: 1hapjjy6635khx6ean1i9pxm4mypfzp9
X-MBO-RS-ID: 3cc1a3b206adc544abb

Hi SJ,

On Thu, 2026-10-15 at 07:01 -0700, SJ Park wrote:
> On Thu, 15 Oct 2026 10:06:23 +0200 Manuel Ebner <manuelebnerli@mailbox.or=
g> wrote:
>=20
> > Fix tenses. Replace 'set as' with 'set to'.
> > Rewrite complex sentences.
>=20
> Let's put two sentences in one line, while breaking it for the 75 column =
limit.

Will do.
>=20
> [...]
> > @@ -113,8 +113,8 @@ quota_sz
> > =C2=A0
> > =C2=A0Limit of size of memory for the reclamation in bytes.
> > =C2=A0
> > -DAMON_RECLAIM charges amount of memory which it tried to reclaim withi=
n a time
> > -window (quota_reset_interval_ms) and makes no more than this limit is =
tried.
> > +DAMON_RECLAIM recordes the amount of memory which it tried to reclaim =
within a time
>=20
> s/recordes/charges/=C2=A0 or s/recordes/records/ ?

For me charge is such a weird word exepct in 'charge a battery' or 'charge =
a fee'. And
'recordes' is a typo. Does this work:

DAMON_RECLAIM records the amount of memory which it tried to reclaim within=
 a time

I could do this in a second patch aswell.

>=20
> I'd prefer charges, but my English is definitely bad, so looking for your
> suggestion.
>=20
> > +window (quota_reset_interval_ms) and stops when this memory limit is r=
eached.
>=20
> I feel like readers might wonder what is stopped.=C2=A0 How about "stops =
trying
> reclaiming memory when ..." ?

window (quota_reset_interval_ms) and stops trying to reclaim memory when th=
is limit is reached.

>=20
> > =C2=A0This can be used for limiting consumption of CPU and IO.=C2=A0 If=
 this value is
> > =C2=A0zero, the limit is disabled.
> > =C2=A0
> > @@ -125,19 +125,19 @@ quota_reset_interval_ms
> > =C2=A0
> > =C2=A0The time/size quota charge reset interval in milliseconds.
> > =C2=A0
> > -The charge reset interval for the quota of time (quota_ms) and size
> > -(quota_sz).=C2=A0 That is, DAMON_RECLAIM does not try reclamation for =
more than
> > +The quota reset interval of time is quota_ms and of size is
> > +quota_sz.=C2=A0 That is, DAMON_RECLAIM does not try reclamation for mo=
re than
>=20
> I think this change is just wrong?=C2=A0 quota_ms is not quota reset inte=
rval of
> time.=C2=A0 Which part of the original sentence was difficult to read?

'charge' again, and I think there is the verb is missing.

>=20
> > =C2=A0quota_ms milliseconds or quota_sz bytes within quota_reset_interv=
al_ms
> > =C2=A0milliseconds.
> > =C2=A0
> > -1 second by default.
> > +1000 (1 second) by default.
>=20
> Isn't this (1 second in milliseconds is 1,000) easy enough to infer for
> readers?

Ok.

> > =C2=A0
> > =C2=A0quota_mem_pressure_us
> > =C2=A0---------------------
> > =C2=A0
> > =C2=A0Desired level of memory pressure-stall time in microseconds.
> > =C2=A0
> > -While keeping the caps that set by other quotas, DAMON_RECLAIM automat=
ically
> > +While keeping the caps set by other quotas, DAMON_RECLAIM automaticall=
y
>=20
> How about "caps that are set by ..." ?

Yes, this was my second choice.

>=20
> > =C2=A0increases and decreases the effective level of the quota aiming t=
his level of
> > =C2=A0memory pressure is incurred.=C2=A0 System-wide ``some`` memory PS=
I in microseconds
> > =C2=A0per quota reset interval (``quota_reset_interval_ms``) is collect=
ed and
>=20
>=20
> Thanks,
> SJ

I messed up the subject line, should be:
Docs/admin-guide/mm/damon/reclaim: improve grammar and style

I'll follow up with a [v2], including Aveline suggestions.

Thanks,
 Manuel
>=20
> [...]
