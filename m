Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6D023183F
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 04:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783399820; cv=none; b=haK6L6g4fptjiAGWoQtQ94dGL18piKGwHhrr2xTzCbMUUk6Ww+riJ9LOwqdlHqt4LHxHbwDVXyIEPns37hbMZj87X1GWZgBXh/2mn74CTc+WHHeO9vxHGtHaTxgUXUn04wEWoXABOGUsqOxWKFXpPwuTdtQ1+zBYnh/Ng/aMz9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783399820; c=relaxed/simple;
	bh=GPbbvSqDX9COmCtAG1mGuR/J26iZfNqwmJGL0uBzEos=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rlp2ap7LN3i5O9X2XliN3vrW6MhvOgahbNOzAvaK/i+BRdSRzwz+TzqGWj6iwJ0Cnrv0JZLPmSyE2A460UoNXKD8J8xQEfnbEyMHhFn3phLBkwso9UHRh7fzMFBtbJR35FK26AK+WS2dnL2vd8p6nmMLqxvPvFUZxyEpjMlNWe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqSzUVRo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqSzUVRo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C227B1F000E9;
	Tue,  7 Jul 2026 04:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783399819;
	bh=eHf7md+63r8QbSYSePps/ogomXUl/znbcxsE4aeFCtg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PqSzUVRohCeYe9C4PAXcCHI7BT/uzJ2b3sX0rsKRYxGakfQhAGi6F3I3vCd7FZ65g
	 wKdXlCvuxdCkdPmrEk1gl+M30JX9WgJSj9FNu1c7+SoGgHmu9k8fNpnKkoix6y6jKU
	 ASeUt9wbGi5qB+WykmRc8ppBfcx8+vQibX0QfUrGpNhRmq3FnU4ZLRkEzZ9IXRjitd
	 01Gduf75V5amksYQ6hfuHPPB6CMVZHTl1A4iok0htR74GNG6erIC1m7Q1h+4Ndr7hE
	 2JBfR8m6SzSBNIiTDT8jjvnrLSu9E6knq8pzKwiuCK8UZUW9q6y3FSIt1pc8u7h3HA
	 iEpPmkmnCSvyA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/6] mm/damon/core:
 s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260707043828.97900-5-sj@kernel.org>
References: <20260707043828.97900-1-sj@kernel.org>
 <20260707043828.97900-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 04:50:18 +0000
Message-Id: <20260707045018.C227B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] 32-bit integer overflow in damon_sample_bp_to_count() and damon_sa=
mple_count_to_bp() corrupts memory access tracking.
--

--- Patch [4]: [RFC PATCH 4/6] mm/damon/core: s/nr_accesses_for_new_attrs/n=
r_samples_for_new_attrs/ ---
commit cb8a54b34f772f70862ab31ccf30eea4a5cb2263
Author: SJ Park <sj@kernel.org>

mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/

This commit renames damon_nr_accesses_for_new_attrs() to
damon_nr_samples_for_new_attrs() to clarify its general use for any
positive sample count.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 718268df27fa7..cda318806b65b 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -890,7 +890,7 @@ static unsigned int damon_sample_count_to_bp(
>  	return mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));
>  }
> =20

[Severity: High]
This is a pre-existing issue, but can this math silently overflow when the
sample count is large?

In mm/damon/core.c:damon_sample_count_to_bp(), the mult_frac() macro inheri=
ts
the 32-bit precision of 'count'. If the user configures sysfs such that max
samples exceeds ~429,496, the intermediate remainder multiplication can wrap
around UINT_MAX.

For instance, 450,000 accesses out of 500,000 maximum samples will silently
overflow during mult_frac() calculation, resulting in a basis point of 410
(4.1% hot) instead of 9000 (90% hot).

Similarly, in mm/damon/core.c:damon_sample_bp_to_count():

    static unsigned int damon_sample_bp_to_count(
            unsigned int bp, struct damon_attrs *attrs)
    {
        return bp * damon_nr_samples_per_aggr(attrs) / 10000;
    }

The multiplication occurs in 32-bit precision before the division by 10000.
If damon_nr_samples_per_aggr() exceeds ~429,496, this will also overflow.

This drastic corruption could cause DAMOS to incorrectly evaluate region
hotness, potentially swapping out highly accessed memory. Would it make sen=
se
to cast these to a 64-bit type before multiplication to avoid the overflow?

> -static unsigned int damon_nr_accesses_for_new_attrs(unsigned int nr_acce=
sses,
> +static unsigned int damon_nr_samples_for_new_attrs(unsigned int nr_acces=
ses,
>  		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
>  {
>  	return damon_sample_bp_to_count(

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707043828.9790=
0-1-sj@kernel.org?part=3D4
