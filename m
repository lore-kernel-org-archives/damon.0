Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66E834CDD
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 04:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793418; cv=none; b=TWk8DLld+558+xSRNXkIcZFN1pt3St1TnpfCQ9uiHE6KEEfeKvzZgL+OuxReoHluQYwpYMx6jC3biS03BfMbdkimoWTKo+5zgjuq0Pl+mtfCHgLbCTi1ChpeXyHFAFaRnvWO12iF93z2l/HkSQFYnlQcFPbRfwI/bEbmNpOAm4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793418; c=relaxed/simple;
	bh=cYfGsMyrq8j7BXKqFBCoG0KSxynxNDLaN5UTT6bMjKI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RVWDwlL4osA7HBjLu8sB4L21Ca/x4uGsIhM51bvUx8UtI/+pCd9jffr/V05nh449NE8O3QzTt4w0OAIH73LVa0tNTWAjdwllDYP1TFTDIWNaW9mbf+5fu//zI4tuaLAMrPK2XFKB3bbLbs4T8QqNyl6Nc23tba1nvaaRPeD9dg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdU9W4TD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdU9W4TD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8CE1F000E9;
	Tue, 30 Jun 2026 04:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782793417;
	bh=gMyz+5j6Ajm68sXFnLUQO7pKClrJ5EENZtjPBrD9Xr4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IdU9W4TDtH3ZgIbxNfxBt5YurYbzLSOv4HujuQ1bg3yB/EFEekLGI4ZIqP98Lilu8
	 8DbDVTdPz3aorMIQoGCKutP1r9KBabnQ5W23TyiSs6vhQF1lX6gZkskIBWGKPQ6bBJ
	 BPZkzS4VVBls4KPX7cBhttxEOqvG1kyTtdi2qtX/DtmqP7gGsYKm+5cYIwefO1Fax+
	 8skRrFkUcbPr/whFQZyt61piDq7VnpAkse3SKJqKhQeOuJAkqNUd9A2is6gsIKL+E8
	 ddzcbNUvDeSRr5VAHIzvvhI+z+t9zmhIo7q36sZ7GW5c+MYww47eAfUiw5OGb4tmYe
	 T3E4grBJVI75g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/18] mm/damon/core: handle unreset nr_accesses in
 damon_nr_accesses_mvsum()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260630040812.149729-5-sj@kernel.org>
References: <20260630040812.149729-1-sj@kernel.org>
 <20260630040812.149729-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 04:23:36 +0000
Message-Id: <20260630042337.2F8CE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] damon_nr_accesses_mvsum() incorrectly returns stale data (r->las=
t_nr_accesses) when damon_set_attrs() is called exactly at the end of an ag=
gregation window.
--

commit ebe6cc65ba2de465cab83d7ffe913bb9f8304f66
Author: SJ Park <sj@kernel.org>

mm/damon/core: handle unreset nr_accesses in damon_nr_accesses_mvsum()

This commit adds logic to damon_nr_accesses_mvsum() to return
last_nr_accesses when the remaining window is full. It aims to avoid
unnecessarily counting unreset nr_accesses when damon_set_attrs() is
called at the end of an aggregation window.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 94dd425ee4353..df79f4d10bdc3 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -266,6 +266,9 @@ unsigned int damon_nr_accesses_mvsum(struct damon_reg=
ion *r,
>  			ctx->passed_sample_intervals;
>  	left_window_bp =3D mult_frac(left_window, 10000, window_len);
> =20
> +	if (left_window_bp =3D=3D 10000)
> +		return r->last_nr_accesses;
> +

[Severity: Medium]
Will this early return cause the function to return stale data from the=20
previous window instead of freshly accumulated data?

If damon_set_attrs() is called at the end of an aggregation window,
damon_update_monitoring_result() processes this with aggregating =3D false.=
=20
This intentionally preserves the fully accumulated r->nr_accesses for the
newly completed window.=20

After damon_set_attrs() pushes ctx->next_aggregation_sis forward, a
subsequent call to damon_nr_accesses_mvsum() will calculate left_window_bp
as 10000.=20

Because of this early return, won't it discard the freshly accumulated=20
r->nr_accesses and incorrectly return the older r->last_nr_accesses instead?

>  	return damon_mvsum(r->nr_accesses, r->last_nr_accesses,
>  			left_window_bp);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630040812.1497=
29-1-sj@kernel.org?part=3D4
