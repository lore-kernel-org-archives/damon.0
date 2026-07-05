Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B729371D11
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 21:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783285521; cv=none; b=JWwyLR3FgQmb+Md3iC86v8hw61gjSi6c2sO7iTxs5ZvNQsQXQZeQ2bRM9PeDgkIZmg6JDo0Vc+wUGjIyDAyjHVyBQSxaRoAUiJcgh0YvcRCYoXIKmO2aqRYEP8WTmv0EHzHu8Y1UTqMRpHGa8lvhqFYrAPVZt6vjHBRLLnHYSzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783285521; c=relaxed/simple;
	bh=TRyB8LlwWGt20ewf/J390wQqQx+Cv1eBqUbylDlseoc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JyKR4H86AN2jrYPuNm88MfdO+yzKysfCDEI9oaW0LEUVPnwjIaLIDtPyoobkn4Cs4OBxnpWnQAGLTYmK5khU++4/wEsa7QNPwqcEkbADjxY+kW6oB6PhK1GJHLPZmgCXZYoynoBajuPO8BkEqwkWiBENS6qRoHrfxqHbG71ZTHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5e9Zl4X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5e9Zl4X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99B51F000E9;
	Sun,  5 Jul 2026 21:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783285520;
	bh=DghpYyYNElmCSUWw1jBsqEfkO346i0z46bEgRz3uD8o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K5e9Zl4XK0HF5MOus8vo4ZAb6FopyRgSIbHK2otCRDASR1Ki+lhAB0b3sR3yIG04/
	 zd0ybyT1vrDegwFE0/CVYwsSxiUPe1jxexVzSDA/xgnl1NQdOGXoF0kuuzQxeqwVdH
	 phGlJS9mgWA9Ga45VbTYkhqcxz9BdeK9N6TtRdLC/oqwO99ZPVALk5loS3NJPJQzTD
	 zI3mPdLzdI/cqRwcV19H1NDwlfxmWArWwO8gX/F7GFvQzs08J9opqZe4qlvf0Ckv77
	 adIPj53k2ZJwK6u3QPsPYAe4A+jZTdSxf8785O/61bwVqfQcY4Qc2fvpT6eCe75FQx
	 nWpBIKCdxSKbQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 14/16] Docs/mm/damon/design: document attrs-only
 monitoring
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260705205743.98656-15-sj@kernel.org>
References: <20260705205743.98656-1-sj@kernel.org>
 <20260705205743.98656-15-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 21:05:19 +0000
Message-Id: <20260705210519.D99B51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Spelling mistakes in the newly added documentation: 'deeecided' and=
 'mechaanism'.
--

commit 802f6df741c5d3bfcb1ed21eadbf33ebee4db496
Author: SJ Park <sj@kernel.org>

Docs/mm/damon/design: document attrs-only monitoring

This commit updates the DAMON design document to include a section
describing the data attributes-only monitoring mode.

> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/d=
esign.rst
> index 457d6e8bc7878..67398e2133036 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst

[ ... ]

> @@ -316,6 +316,26 @@ Another way to do this for higher accuracy is using =
:ref:`DAMOS filter
>  information in page level.  But, because it is operated in page level, t=
he
>  overhead is proportional to the size of the memory.
> =20
> +Data Attributes-only Monitoring
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Data access is the primary monitoring information for DAMON.  Hence it
> +:ref:`adjusts <damon_design_data_attrs_monitoring>` regions using the ac=
cess
> +:ref:`counter <damon_design_region_based_sampling>` (``nr_accesses``).  =
In some
> +use cases, however, users may want some of :ref:`attributes
> +<damon_design_data_attrs_monitoring>` to be the primary information.
> +
> +Data attributes-only monitoring mode supports this use case.  For the mo=
de,
> +each attribute probe has their priority weight value.  Users can describ=
e by
> +what combination of the attributes the primary information is deeecided,=
 by

[Severity: Low]
This isn't a bug, but there is a typo here: "deeecided" should be "decided".

> +setting the priority weight value.  If the total sum of the weights is n=
ot
> +zero, the mode is enabled.  The regions adjustment mechaanism uses the w=
eighted

[Severity: Low]
This isn't a bug, but there is another typo here: "mechaanism" should be
"mechanism".

> +sum of the :ref:`probe hit counts <damon_design_data_attrs_monitoring>` =
instead
> +of ``nr_accesses`` in the case.  When the mode is enabled, access monito=
ring is
> +automatically turned off.  The access counter (``nr_accesses``) will alw=
ays be
> +zero and not updated.  Hence the mode is called Data Attributes "only"
> +monitoring.
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705205743.9865=
6-1-sj@kernel.org?part=3D14
