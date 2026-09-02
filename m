Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5B8347BDC
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358548; cv=none; b=RCSJOHhlOS64aLOl/7Us4u97uMffHEV+A+F7Gie8/5ZGu0f0AIQb/L5suiXloRgNlCuE/MgTL9vEHUMXSTfmq34f8lW6fUNVQYTKC3D0OOVeI9OQl08GMR4jiJxTkja/nRDjqBRjxq4Xm/SamryG6RXIALxqgjUI6e0gUw5BlvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358548; c=relaxed/simple;
	bh=lvgiBkL9HwauuoIhmZiBlhjU4TWtroTzC75+VYJcJ0I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q1XiDtZah3BH09+PfeoDSdbNLHxVkx5Bq8IkkJJldG2tTUTiVDoUQfOFn+x3IOR1QjNcfKUE0SUGKldMMG3GgTi2ih+ylCVU152xm/xz0uLX/RwBfrtYYQT2BdnE3z0KUDc6dZlJSj4ORYuGODP9u+4AszxWCutJ76LPD0jJRgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBsy9Trs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBsy9Trs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FED1F000E9;
	Wed,  2 Sep 2026 14:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788358546;
	bh=3+N5DNcl3MUlAyQk1tYf56IPqXqkuHZU+g3T/f4J2lc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mBsy9TrsN1JcTWQuabHlgKTmmXuk9ICXqm6ofPh+oNBi1NuOpY9X4+eka5kN8ya5J
	 +l5ImnvWDx5yo4SwC6PMi3tjf3b6JlUkvz+jd8g5UpJgpuxcxd11NdB9uS2IBEPGc1
	 sjPu9zNpyWRm5y7hMg4G8u5Nt33vOlt+R04k68hXtSj9zPgNhQZ6p+C6p8xMvNGcvX
	 9R2tUClHuUhcBBmSnypJ7TeXgB9B6LQlGA5zppRi64OmQ05HdicggcU92dBt6w3z9x
	 cDRA7BJmJ3nLsMy7EQfTyEYvtUaQOxu4Vr+u0g+Y2WyIBDLEOw9vV1OCZ3gyC82nHj
	 GOX1usltN28ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] selftests/damon/drgn_dump_damon_status: dump probes
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902140313.85983-5-sj@kernel.org>
References: <20260902140313.85983-1-sj@kernel.org>
 <20260902140313.85983-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:15:46 +0000
Message-Id: <20260902141546.82FED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing dictionary mapping for DAMON_FILTER_TYPE_PGIDLE_UNSET ca=
uses a KeyError crash when dumping DAMON status.
--

commit 331c442077c25bd4d245acf2c04de56eaa44e0db
Author: SJ Park <sj@kernel.org>

selftests/damon/drgn_dump_damon_status: dump probes

This commit extends drgn_dump_damon_status.py to dump damon_ctx->probes. It=
 is
intended to monitor in-kernel DAMON status changes when the user sets probes
via sysfs.

> diff --git a/tools/testing/selftests/damon/drgn_dump_damon_status.py b/to=
ols/testing/selftests/damon/drgn_dump_damon_status.py
> --- a/tools/testing/selftests/damon/drgn_dump_damon_status.py
> +++ b/tools/testing/selftests/damon/drgn_dump_damon_status.py
> @@ -48,6 +48,37 @@ def attrs_to_dict(attrs):
>          ['max_nr_regions', int],
>          ])
> =20
> +def filter_to_dict(damon_filter):
> +    filter_type_keyword =3D {
> +            0: 'anon',
> +            1: 'memcg',
> +            }
> +    dict_ =3D {
> +            'type': filter_type_keyword[int(damon_filter.type)],

[Severity: Medium]
Will filter_to_dict() crash with a KeyError if a user configures a DAMON pr=
obe
with a filter of type pgidle_unset via sysfs?

If damon_filter.type is assigned the value 2 (DAMON_FILTER_TYPE_PGIDLE_UNSE=
T),
the filter_type_keyword dictionary does not have a mapping for it. This cou=
ld
cause the Python diagnostic script to crash, preventing the user from
inspecting the internal DAMON state.

> +            'matching': bool(damon_filter.matching),
> +            'allow': bool(damon_filter.allow),
> +            }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902140313.8598=
3-1-sj@kernel.org?part=3D4
