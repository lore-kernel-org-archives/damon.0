Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36953E7159
	for <damon@lists.linux.dev>; Fri, 26 Jun 2026 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462248; cv=none; b=SYmpXdTGFq3eNdKfJlIr1b/KKcW8hPEHUlNSC6mYOydiCwskjlVCi8kqrFwIF4d0buBGjEGmDlsJcXGDH+bP1mJv4KeSsK0B/NCNfqiHMXruBN0ia070G7QGGdhL4P4S6BeP2cgarbsvlzzpdqG8+vuNB410F1vSewDmqwLxi1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462248; c=relaxed/simple;
	bh=RERAtqviiP93fw69IDPIKFAKybkLCw6idKZiTUB0qvA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nYA/IfMDhd6J6s8PzDQB8zPXdR4PpiPIAOnKQ6YQz3hQZyaBcJ4d0ZnRDbZJNXGhhgtmZsKb9Glt2qYETkVv2AeUn5dvvdyFDTOd56HFM30jUlMkujOu1Cm35wbxBbIEJrAoOMJrAg01H+C/cuYmuykJi9ZztGt+aQOATiOgGxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6lXf3ii; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6lXf3ii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549071F000E9;
	Fri, 26 Jun 2026 08:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462247;
	bh=c/LNxr2G0MN/SRw4y7Gj4ZfnI4HRWJLDQI0mjcnyqq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l6lXf3iivJtzndBFtf4WwmPQyIItwcByO9NaPwWwr1itdO/MT9Ur0F36pHwTrRPxd
	 CyO5VNXYtCA/qbidwfG0JY02GBksv7PxKc3aUEi/vimRJtjndXFYCDxzSzHCMCe7ZN
	 yTitnL/FfYvfREcPG11iolfyJ1cDiz6ESo4EMZxy9Xmy3EWvh1yA3bS5f3ZGIIrm5R
	 0ukj8ld4uZ4cNnAJjU/jRb054OTjuHSi1hJyM9eyHk5+21ptNX/numKA1KlxcQJjHq
	 63jzOQJMMm66hPG4cCuO8OYFVXWzIkCSVdV1fwuIBhUbyFl7eg/ibU5IyD1pCCjhC7
	 6E9kO/fJ4J1Ig==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] mm/damon/reclaim: add 'available' memory as an
 optional watermarks metric
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260626081038.46569-1-aethernet65535@gmail.com>
References: <20260626081038.46569-1-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 08:24:06 +0000
Message-Id: <20260626082407.549071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Integer overflow in `DAMOS_WMARK_AVAILABLE_MEM_RATE` metric calcula=
tion on 32-bit systems with large RAM.
--

commit 6e3a23f197986b131330f066a94d4821743b7d21
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/reclaim: add 'available' memory as an optional watermarks metric

This commit introduces a new 'memrate_type' sysfs parameter to DAMON_RECLAI=
M.
It allows users to switch the watermark metric evaluation from free memory =
to
available memory, which is particularly useful on devices like Android that
maintain low free memory.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7e4b9affc5b06..f12d06081d70f 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -3300,11 +3300,17 @@ static bool kdamond_need_stop(struct damon_ctx *c=
tx)
>  static int damos_get_wmark_metric_value(enum damos_wmark_metric metric,
>  					unsigned long *metric_value)
>  {
> +	long available_pages;
> +
>  	switch (metric) {
>  	case DAMOS_WMARK_FREE_MEM_RATE:
>  		*metric_value =3D global_zone_page_state(NR_FREE_PAGES) * 1000 /
>  		       totalram_pages();
>  		return 0;
> +	case DAMOS_WMARK_AVAILABLE_MEM_RATE:
> +		available_pages =3D si_mem_available();
> +		*metric_value =3D available_pages * 1000 / totalram_pages();

[Severity: Low]
Can this calculation overflow on 32-bit systems with a large amount of memo=
ry?

Since available_pages is a long type, on 32-bit architectures it is a 32-bit
integer. If the system's available memory exceeds roughly 17.1 GB (about
4,294,967 pages), multiplying available_pages by 1000 before the division w=
ould
overflow the maximum 32-bit value.

This truncation could result in an artificially low watermark metric rate.

Would it be safer to cast available_pages to a 64-bit type or use mult_frac=
()=20
to prevent the potential overflow, even if such large memory sizes are unco=
mmon
on 32-bit targets?

> +		return 0;
>  	default:
>  		break;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626081038.4656=
9-1-aethernet65535@gmail.com?part=3D1
