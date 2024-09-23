Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627D519E7E2
	for <damon@lists.linux.dev>; Mon, 23 Sep 2024 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110035; cv=none; b=tuMMN7UGv9pmjJ0swWgbEjqB3zr2pWls00xgrQVDkBw9gRVEgMUmsX50qFMG1fNinTEbY7kO0gJf0DR/fuFtFj/IPBHpGqHt4hZdy04GeYEX3J9C0c0v2J7s9uy/1vnhYU35aFti17KNzPnRnPOGD7RGOyZeNHVOhV/U3pR58aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110035; c=relaxed/simple;
	bh=C/WqVMj4DrTy4lgLnjS672bib2conoZWLJv3A7cquOg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SdQVjlEkIq3rJD8bZ6yHf0setf2bPdZ2UNb/AuheybL7kKPWYmLzmSE8phjJ/icQw38dhgTU7Peouo5EAGeXizJankP91CQVMlXQx7JaP22Pkh1jQFCttWwRuD8oC4iNI9GXxnKYNfk1VB59Bu8s1aBE6PbnvTVf5efqn0gVBLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=OLH/k+Jk; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="OLH/k+Jk"
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1727110030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lUIdOEihVUyd1ilWFDy6GeBjW5ZBlK+M2N/8lsqNaFg=;
	b=OLH/k+JkMD65LcM9ljhdOWgI81PmyWYDWuO4SqZQE3qTMNTvIbIqd0xEOVR++mv9Z/YCkf
	SQtRCpgscxtcGMFK3ozjWV344d6z3xCe5eJcNQJwzLrrjBdv+1anH6y1X0VgZADK/RoZVU
	NJaQoTpTWQDI2mdd754TCNHIKvM2S5adC99FOl43WrsQE+OkzKWUGSKVfdtVNfnXcVHeJr
	EsdkUgTVmfLP/8/gvYg98bthqmxqkQS1dqVtBi8GEh/Fcweaof4MihgD/ev2hpwO5Zrnse
	hJaYh4tNNaOyJa+DvBvIMuZvC8q0EEIwbQheSxnJpYKoCqZmoWcYpV+fzlXbsA==
Content-Type: multipart/signed;
 boundary=d0baebba785571bdc3f21f5e5605455d839280196496138da20ab2852bd8;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 23 Sep 2024 18:46:57 +0200
Message-Id: <D4DTEKH7A93W.1MGHTQZGU5UCC@cknow.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, "Diederik de Haas"
 <didi.debian@cknow.org>
Subject: Re: [PATCH] mm/damon: Update DAMON doc URL
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "SeongJae Park" <sj@kernel.org>
References: <20240923100615.14160-1-didi.debian@cknow.org>
 <20240923163226.550729-1-sj@kernel.org>
In-Reply-To: <20240923163226.550729-1-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

--d0baebba785571bdc3f21f5e5605455d839280196496138da20ab2852bd8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi SeongJae,

On Mon Sep 23, 2024 at 6:32 PM CEST, SeongJae Park wrote:
> On Mon, 23 Sep 2024 12:05:58 +0200 Diederik de Haas <didi.debian@cknow.or=
g> wrote:
>
> > The old URL doesn't really work anymore and as the documentation has
> > been integrated in the main kernel documentation site, change the URL t=
o
> > point to that.
>
> Nice finding!  Thank you for fixing this!
>
> Nonetheless, I'd prefer having 'mm/damon/Kconfig:' as the prefix of the c=
ommit
> subject.

Do you want me to send a v2 for it or will that be fixed when
committing?

> Other than the trivial nit,
>
> Reviewed-by: SeongJae Park <sj@kernel.org>

Thanks :)

Cheers,
  Diederik

> > ---
> >  mm/damon/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> > index fecb8172410c..35b72f88983a 100644
> > --- a/mm/damon/Kconfig
> > +++ b/mm/damon/Kconfig
> > @@ -9,7 +9,7 @@ config DAMON
> >  	  access frequency of each memory region. The information can be usef=
ul
> >  	  for performance-centric DRAM level memory management.
> > =20
> > -	  See https://damonitor.github.io/doc/html/latest-damon/index.html fo=
r
> > +	  See https://www.kernel.org/doc/html/latest/mm/damon/index.html for
> >  	  more information.
> > =20
> >  config DAMON_KUNIT_TEST
> > --=20
> > 2.45.2


--d0baebba785571bdc3f21f5e5605455d839280196496138da20ab2852bd8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZvGbhQAKCRDXblvOeH7b
bgEuAP9mbmpuhXYnoewUSGm6j4/Aq6MUtLwvMFewMTfmHmJ+5AD+N0cfqRmmPGKA
wmqOoiQJAHlViCo+NtMp9Any5X3AEA4=
=lQP8
-----END PGP SIGNATURE-----

--d0baebba785571bdc3f21f5e5605455d839280196496138da20ab2852bd8--
