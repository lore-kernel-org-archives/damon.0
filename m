Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C400429833
	for <damon@lists.linux.dev>; Thu, 30 Apr 2026 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777559469; cv=none; b=Qjb4I6fgCq6BIReT98Os9wcJmgK6uGRFO+RAA2bC0bNwEs9G3jmFjaQVteHDQezfT4JQXUGTawzXMVNlyyAfRhPrS3mb10zTAmuVMLKwV5zsKexZGIrDYDNKVahfrW3vVLuP1OvXw+KWn3YX4QH/lqUb+SVgknggDrvQOe+Uz6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777559469; c=relaxed/simple;
	bh=dtSiRMTbPiPgUHg+AwwS3TTtC/ggIRdSVLCZEHedeWU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G5cA97zBJjWTfR4sVGhVVaZi/rKn0q9vWyg/C9nqY9JNnl6ntiijv3XLd2FoHXRVdALMKvTam7wh2EHvO7D651rRwJ65xXHAd1DVlJhvRvJ8/jQwedw7kShZNWJRID+uoOgoNRC6Gq9i8HHIJ78g+2QNgzc+IBFCqVs0Tl1PZzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qo5jclBR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qo5jclBR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEFCC2BCB3;
	Thu, 30 Apr 2026 14:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777559468;
	bh=dtSiRMTbPiPgUHg+AwwS3TTtC/ggIRdSVLCZEHedeWU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qo5jclBR87AVUNV6OFykzlEbL9HhdhwuvE8t+8Bo/g0ELFhmo+1ElvVv1NksyYrCf
	 apLjrnFWh/MP+eDrbqhaITD8T8rkNYniDQkB2qhW7CI1nSmZgeD8qtwDs+WqZtlqaB
	 dNYgmDRNrqIMTKmSl517GSrz0thXGS7ggLmh+1FdCR4V+c+sb7IdZMgkWvoT3aia4Y
	 oP/pfWb0x0hfaA8UjJUvBS/Wd7VzzCCAt8Cgab6Pb4ajtcNrIJqLyUIeO/Gr6fdvhY
	 a5/AP9LkSd8o15UQPdmMQGXS8wbnlaUCiqC4Gd0+5IozXis7VKv+FxrRv86UaTbrG5
	 KYR7hPJjbn7+Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 2/4] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE
 auto tuning
Reply-To: sashiko@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260430134139.2446417-3-gutierrez.asier@huawei-partners.com>
References: <20260430134139.2446417-3-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 14:31:07 +0000
Message-Id: <20260430143108.8EEFCC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Divide-by-zero panic in damos_get_used_hugepage_mem_bp() when =
no anonymous memory is mapped.
- [Medium] Missing sysfs string mapping for DAMOS_QUOTA_HUGEPAGE renders th=
e metric unconfigurable via userspace.
--

commit 46bdbb5e7c05e4c06aea38af1c50ac5407f8b9c3
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning

Introduce DAMOS_QUOTA_HUGEPAGE auto tuning Add a new DAMOS quota goal
metric to measure the amount of huge page consumption to total anonymous
memory consumption ratio.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 143d024fec845..ee937b3892c68 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -174,6 +174,7 @@ enum damos_quota_goal_metric {
>  	DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
>  	DAMOS_QUOTA_ACTIVE_MEM_BP,
>  	DAMOS_QUOTA_INACTIVE_MEM_BP,
> +	DAMOS_QUOTA_HUGEPAGE,

Is there a missing update to the string mapping array in sysfs for this new
metric?

If damos_sysfs_qgoal_metric_names in mm/damon/sysfs-schemes.c isn't updated
to include DAMOS_QUOTA_HUGEPAGE, wouldn't configuring this metric from
userspace fail and return -EINVAL?

>  	NR_DAMOS_QUOTA_GOAL_METRICS,
>  };

[ ... ]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 1af84e0ac1dd4..63cbf30288d53 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -2320,6 +2320,18 @@ static unsigned int damos_get_in_active_mem_bp(boo=
l active_ratio)
>  	return mult_frac(inactive, 10000, total);
>  }
> =20
> +/*
> + * Returns anon hugepage memory to total anon memory use ratio.
> + */
> +static unsigned int damos_get_used_hugepage_mem_bp(void)
> +{
> +	unsigned long used_hugepages, total_used;
> +
> +	used_hugepages =3D global_node_page_state(NR_ANON_THPS);
> +	total_used =3D global_node_page_state(NR_ANON_MAPPED);
> +	return mult_frac(used_hugepages, 10000, total_used);

Can total_used be zero here?

If there is no anonymous memory mapped in the system (for example, right
after boot or on a system running purely file-backed workloads), total_used
would evaluate to 0.

Since mult_frac() directly performs division and modulo without
zero-checking the denominator, wouldn't passing 0 as total_used trigger a
divide-by-zero exception and crash the kernel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430134139.2446=
417-1-gutierrez.asier@huawei-partners.com?part=3D2
