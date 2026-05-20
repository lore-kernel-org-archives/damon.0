Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED172BE05F
	for <damon@lists.linux.dev>; Wed, 20 May 2026 01:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779239918; cv=none; b=j8gomJn6GucyLar1EmARSgl0wsBjEngNX67XzNNcRDoz40ne5A+OHiJX1AuiviCUkq7yMmKY0u/KGunwine1AkF18YYYeffCZ/FjkBz4H7zKXc3egLJpN32A2h7xglOFe8VSIXBGz/FwWyYtcfnmLtJanawaOSMBHeIgX6KbyuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779239918; c=relaxed/simple;
	bh=/UAopj3BgHoQRuqXqmG//v2V5UWn2U5Nz9wrbhRah9A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V99M4qRk0acj4f3LsQukzrvf375RorpjGXd5t88Yx/oBN8OsQeYZbOs8rpGl1/o2/mYkPO+yw1V66g8O2+HMZAP2fMDT9kqShbm/zYUx0hDFfzn6xH7cFHGmDNu0gHhMRZBj6TkG8ZMhSs70V8nJccFVJgnEBruJJPZaB1HxTKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gH4MEFkg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gH4MEFkg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6192D1F000E9;
	Wed, 20 May 2026 01:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779239917;
	bh=T54DKsh/Bv/npzoXzQTHavPuUzVdiIF6mLIKHJTZ/Tg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gH4MEFkgnbJ+AlRWQXLydpkTagwOZm9asMegP5bTVrdrxZw/wQ7JoYicQ7nyvlo9Z
	 KbsRjjv7RThqWWnuqn/fi+NInnOFpZe8Q3cfXF67DhrF8F74UvizhT5stm3tAvloit
	 otGFAuPaH8f/HTYC8PBtJRnrnUmVfI89exc4J8ZAk2+Yp5Y6dLdL+l32+F9EOQeYjW
	 O6dOGdUfS/xF3BmC9ApJLXRt8aukXxPcu79xzpbVoxlmStHvtTFUR1hpa4ILhS1Mac
	 SGLcdH0Y1kj6OxbKOxrTyr4oWXSYU5WdWuUOlIr8+TlQoZTzvgdHGE5vEYNkmS7sX8
	 /qVJRW2ozGuKg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] mm/damon/core: trace esz at first setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260520005940.92003-1-sj@kernel.org>
References: <20260520005940.92003-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 01:18:37 +0000
Message-Id: <20260520011837.6192D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The monotonic accumulators `total_charged_ns` and `total_charged_s=
z` will rapidly overflow on 32-bit architectures, breaking the throughput e=
stimation logic.
--

commit 4cb83c3ed801305fa15e94548668201c275a1037
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: trace esz at first setup

This commit fixes an issue where the initial effective size quota is not
traced, which leaves tracepoint investigations incomplete when using the
temporal tuner. It updates the quota adjustment logic to unconditionally
trace the initial quota value.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 4e223857a0f99..0db6530825d1d 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2883,6 +2883,8 @@ static void damos_adjust_quota(struct damon_ctx *c,=
 struct damos *s)
>  	if (!quota->total_charged_sz && !quota->charged_from) {

[Severity: High]
This isn't a bug introduced by this patch, but will total_charged_ns and
total_charged_sz overflow on 32-bit architectures?

Since unsigned long is 32 bits on those systems, total_charged_ns will
overflow after roughly 4.29 seconds of total active execution time.

Additionally, the throughput calculation in damos_set_effective_quota():

damos_set_effective_quota() {
    ...
    if (quota->total_charged_ns)
        throughput =3D mult_frac(quota->total_charged_sz,
                1000000, quota->total_charged_ns);
    ...
}

uses mult_frac() which evaluates (x % d) * n internally using the type of x.
Since the remainder could be up to total_charged_ns - 1, multiplying it by
1,000,000 will quickly overflow the 32-bit boundary. This produces incorrect
throughput estimates and impacts the effective size quota calculations on
32-bit systems.

>  		quota->charged_from =3D jiffies;
>  		damos_set_effective_quota(c, s);
> +		if (trace_damos_esz_enabled())
> +			damos_trace_esz(c, s, quota);
>  	}
> =20
>  	/* New charge window starts */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520005940.9200=
3-1-sj@kernel.org?part=3D1
