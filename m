Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166238;
	b=5LkWBP+2/HOpNFFGVOIFQR8LJOGPhmsgtyuqFY2QZHqjnX785Sx6Iu6ZW+NghSSEhyi/
	 5am2/QJAunkjSjz/ELFuECTDe+4e1ubHWrMrxnKgytgGePRmgWOH2jNGMvyNTTGZmtWYA
	 PTjRy1WCMuIWeHoGUJgq2OdTZ41eKP1WMyZT5pQ+7cDOe2lWiKbjYCfYyMJB7opSSVxjR
	 vkrJbn3+6u1Nx+AoT1Jg3fEwhTcThiJ/4m4NyKoH19zxC2VG/Mn9jOT5ceRolqVS9YQaC
	 MW1pkR+VmeXZjiLApbuslhBBWu6opnDqg8c/AnP2brjHa2Fgb4OhqRlskZQHFM7bhhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166238;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FGWcdi0dUz45RUK9WtiCKIc1bZXWd56im4xspZm7By8=;
	b=AYUaJbyGUDR1gK/TmRo9WVMD68NvJ68GiDN5lZ3d28KbgEmv2/SZHiguS8MNdufc2PXp
	 X5iJmKqjw9j1OAh4s/CxnmPZBgJ8BPK2kLvNvzSzStf71STjMXh1CMCmhxjxS+Jxdpyss
	 Er7ZRodteqgrjdbCRpMBVK9+BDQ1MRYb+t3/EmlFTFBffowMBcvANHCx29GsXQA0hJNQm
	 WWKJmyA5spLkQUH4Mzo3GLVQWdbVryE+CbmlYUj7MMBpkaP1ZUkN+tfzSJzUJeDCsXZHC
	 xUT9bVJsT3/vY0u6Zds6F7MKM3kFPwDDAuwHpyuRA/riWoyGg+EYpfggw5W6v/akzEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DzZfMQnc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13133606A31C
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 19:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DzZfMQnc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DDF1F0089F;
	Sun,  8 Nov 2026 19:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794166237;
	bh=FGWcdi0dUz45RUK9WtiCKIc1bZXWd56im4xspZm7By8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DzZfMQncqTIaP5p3UzNb7vrOecGw38WnRL2X5aQSu2cAD7rBl8MYqx+f+9yD504IE
	 lCEWYu8sVr+IcnAZj+LMKRBiDa+BtqQYoOuh9C+4gO5J/I46AkegV2di1xdmguyOIa
	 yPtF4lZeoWsWYFWOKwcslKnthVnVc7DqujgNV+lnJy2Lne727M5VddP61DfsXLfYnI
	 tbKlXHxV/OW34zYzWGR1XpnoQghexizUv+OxenfaHlYLx+x+QF7pUmdtYW0a4S6Gsf
	 nQ4MRas8P7JHnF9GT+JAIFUCOdbNSqDyoPXH6F1x6zvVbpDXQCzoC7HWGAd6YCtNqV
	 dVJfoqjmnhXyw==
Message-ID: <sashiko-outbox-203953@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y 3/5] mm/damon/sysfs-schemes: read
 sysfs_filter->sz_range only once
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Brendan Higgins" <brendan.higgins@linux.dev>, "David
 Gow" <davidgow@davidgow.net>, "Usama Arif" <usamaarif642@gmail.com>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261108192221.114362-4-sj@kernel.org>
References: <20261108192221.114362-1-sj@kernel.org>
 <20261108192221.114362-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 19:30:36 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] mm/damon/sysfs: TOCTOU race in damos_sysfs_add_quota_score()
  [1]
--

commit 244e62bfada7cc56b0025da40ea03dad6d9c6420
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once

This commit copies sysfs_filter->sz_range into filter->sz_range before
validating it in damon_sysfs_add_scheme_filters() so that a concurrent
sysfs update cannot pass an unvalidated size range to the core layer.

Link: https://lore.kernel.org/20260914142327.92510-3-sj@kernel.org

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 37e0a8bef4b1f..0f945ef043709 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -2493,12 +2493,11 @@ static int damon_sysfs_add_scheme_filters(struct =
damos *scheme,
>  		} else if (filter->type =3D=3D DAMOS_FILTER_TYPE_TARGET) {
>  			filter->target_idx =3D sysfs_filter->target_idx;
>  		} else if (filter->type =3D=3D DAMOS_FILTER_TYPE_HUGEPAGE_SIZE) {
> -			if (sysfs_filter->sz_range.min >
> -					sysfs_filter->sz_range.max) {
> +			filter->sz_range =3D sysfs_filter->sz_range;
> +			if (filter->sz_range.min > filter->sz_range.max) {
>  				damos_destroy_filter(filter);
>  				return -EINVAL;
>  			}
> -			filter->sz_range =3D sysfs_filter->sz_range;
>  		}
> =20
>  		damos_add_filter(scheme, filter);

[Severity: High]
This problem wasn't introduced by this patch, but can
damos_sysfs_add_quota_score() just below hit a similar double-read race on
sysfs_goal->target_value [1]?

mm/damon/sysfs-schemes.c:damos_sysfs_add_quota_score() {
	...
		if (!sysfs_goal->target_value)
			continue;

		goal =3D damos_new_quota_goal(sysfs_goal->metric,
				sysfs_goal->target_value);
	...
}

target_value_store() updates sysfs_goal->target_value without holding
damon_sysfs_lock:

CPU0                              CPU1
damos_sysfs_add_quota_score()
  if (!sysfs_goal->target_value)
                                  target_value_store()
                                    kstrtoul(..., &goal->target_value)
  damos_new_quota_goal(...,
      sysfs_goal->target_value)
  ...
damos_quota_score()
  mult_frac(...,
      goal->target_value)  <-- divide-by-zero

If a concurrent write sets sysfs_goal->target_value to 0 between the check
and the second read, damos_new_quota_goal() creates a goal with a zero
target_value, which later causes a divide-by-zero in damos_quota_score().
sysfs_goal->metric is also read twice in damos_sysfs_add_quota_score(), so
a concurrent metric_store() between damos_new_quota_goal() and the switch
can leave goal->nid or goal->current_value uninitialized.

[1] https://sashiko.dev/#/bug/linux-7f814c9a-986f-4103-a55a-ef9537dcf62b

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108192221.1143=
62-1-sj@kernel.org?part=3D3
