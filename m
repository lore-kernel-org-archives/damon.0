Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B2234105B
	for <damon@lists.linux.dev>; Thu, 28 May 2026 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779951056; cv=none; b=YoescVBVWY5slqWXeYOaPjCohzE721ZvTzPFmSZ/tfyph5qOZqKzQwsyDctFcwxsVPsBq2q7SyELP83TZo6A7f5rwAKPPrtYt5TyHMS2YbpSPdGbH7DmN87k2jYRKLU4luDC/sCQEmJHKsYEbpbtq51YiZ6fPN92yUbJCJ/yOfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779951056; c=relaxed/simple;
	bh=HaOcCdxy2oQLj/gAxfXiSLaahghli0EmoJ6RagloBH4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RcxyOaCkvD3gmeEzuwMusHPmGqRBlap47MJ8CYhZ9XaLgYZ5AiQcofaKo8EEd2hEW4f6yhKPQ3XhtT2syH2iD9kz45OhQ6nMtISs+MZ9iWaKu2/E1Dpf9Zz+tIhDzSaUxDx94DLK8kDXFGRxagBlKtCkDmqK5E+uZo5sltRIeP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6l6ycgx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6l6ycgx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471371F000E9;
	Thu, 28 May 2026 06:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779951054;
	bh=fGWh/n2M1ApSAywXLeZCwA6X8AR+axsllnxYtndpHY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b6l6ycgxDryAWRNMtgMP4CGeAajIXzAcvgdt03cIxxO+O+DfhJ84XqCm3r5YDz5sW
	 QL9RAPEGhYpOqRxv7F6PEfWEC/nRtXab96gtfbMd0+MhKcmXVcJnOiJP5xuR0wRFeC
	 loZXEMhndLAopDDWhnZVuw1WyhyklUQR0LApBMZikGFkSnUhiHullDu3rwpKi+Ry0F
	 70fv4lwegD/ANoOgUIswUpBp1SojZjeQdmqtkQn27lG9a5Sz7h85uwOAclSRlgxO0q
	 1dddpywi8bBwjInyaLdfy0n3JsMuf6OybYZo35mWOoeJrDwq2PU4PIHl9S5YpC1WWC
	 JJ+gVhx5GItQA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] mm/damon/reclaim: handle ctx allocation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260528061110.2172-2-sj@kernel.org>
References: <20260528061110.2172-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 06:50:53 +0000
Message-Id: <20260528065054.471371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch prevents loading the damon_reclaim module with the 'enab=
led=3DY' parameter by returning -ENOMEM during parameter parsing.
--

commit d55c0d692febe0a6f116ac49f1c1187ff2f47d7b
Author: SeongJae Park <sj@kernel.org>
mm/damon/reclaim: handle ctx allocation failure

This commit adds a check in damon_reclaim_enabled_store() to return -ENOMEM
if the ctx pointer is NULL. This is intended to prevent a NULL pointer
dereference if the context allocation failed during initialization.

Cc: stable@vger.kernel.org # 6.18.x

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index ed446d00ef1cf..ce4499cf4b8b0 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -399,6 +399,10 @@ static int damon_reclaim_enabled_store(const char *v=
al,
>  	if (!damon_initialized())
>  		return 0;
> =20
> +	/* damon_modules_new_paddr_ctx_target() in the init function failed. */
> +	if (!ctx)
> +		return -ENOMEM;
> +

[Severity: High]
When the damon_reclaim module is loaded with the enabled=3DY parameter,
load_module() calls parse_args() before running the module's
damon_reclaim_init() function. At this point, damon_initialized()
returns true since the damon core is already initialized, but ctx is
still NULL.

Will this new check return -ENOMEM and abort the entire module loading
process during parameter parsing instead of successfully loading?

>  	return damon_reclaim_turn(enabled);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528061110.2172=
-1-sj@kernel.org?part=3D1
