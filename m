Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE05A22D7A1
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271008; cv=none; b=KDpZZk44hdce4lMDnHWpL2QL8fEIaeeZkT2+dHytw6mQA45K6VygGKZA6NGpadhOHc0ZPYsxPaxgbgIWI00whd8FxwkcvHOR17yPmqpl2GHeVEQ/unobV0AUtmILc8zxtbHhCVvkyPbIzHUnkRfJX1Bsu2uxrH+zrXJyvGBzY3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271008; c=relaxed/simple;
	bh=N7vuLeT6nNM2KBenimtixOcVwuRyAIuRrCWV4sp2lv8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yxa0BC+ujCFm27o8oqXtgdj9v+KdFbOMGinkoSaTfIS/mGuJhAtwCAUaOx/I2bt/N6F4W0ezhtkMjjquNS0vOXVADpy4z4qho6qjyQ3ySi5O7J7bvDwiWvyQ5068MFcMFhuSCd/RtDji2+Z9i9cJSrEKuNv282JPvRUIaMOZASM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYikraPV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYikraPV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD7A1F000E9;
	Tue,  1 Sep 2026 13:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788271007;
	bh=KIPmT4Jh7AZ/KYErN7F6pEgv4FRG0ePULjLDt7WbxZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lYikraPV5xBR4O3AgR3nu2RRg0PV6XRw/XNZaB+p8WqaLJWXaxeCvxeM0/NBKiKbm
	 mv9QPtaoycmlnaxAzLozTVV1G0hyQQBBo5LAecwiAOToP+hU6dunX/jdBUDetgIPOw
	 3VZ0NMjtwvIaaySV0Qz0ILUs7+ywvU+YiU2tXYUjVrRoO1FKqenfCD+PJWIFAoiNiu
	 TZfGQzDAW6ywcD82TksYzr8iApbufr0AerzqLa7J9eOMyUvGINSXL1irekn204cxVk
	 2m1euJwQo8zd2CdL8JLBVvg0uuLTSpsK96iIuuokrXKQwFi0dfW8npwrermCyCrBoz
	 AbOlsaxl/cuQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] mm/damon/core: handle extreme memory state in
 get_in_active_mem_bp()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901131326.97615-8-sj@kernel.org>
References: <20260901131326.97615-1-sj@kernel.org>
 <20260901131326.97615-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:56:46 +0000
Message-Id: <20260901135647.3AD7A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] 32-bit integer overflow in mult_frac() macro when calculating memo=
ry ratio on 32-bit systems, leading to completely incorrect DAMOS quota met=
rics.
--

commit b2f8512e8018294c2ac5082c2964a0519b9242e8
Author: SJ Park <sj@kernel.org>

mm/damon/core: handle extreme memory state in get_in_active_mem_bp()
   =20
damos_get_in_active_mem_bp() uses the sum of the active and inactive
memory amount as a denominator.  In an extreme and unlikely environment,
active and inactive memory might be zero.  In this case, hence, it
results in a divide by zero problem.  Avoid it by changing the
denominator to one if it is zero, before it is being used.

[1] https://lore.kernel.org/20260721034756.147011-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 6288bb3b09e65..fb96848174dcc 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3005,7 +3005,7 @@ static unsigned int damos_get_in_active_mem_bp(bool=
 active_ratio)
>  		global_node_page_state(NR_LRU_BASE + LRU_ACTIVE_FILE);
>  	inactive =3D global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_ANON) +
>  		global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_FILE);
> -	total =3D active + inactive;
> +	total =3D max(active + inactive, 1);
>  	if (active_ratio)
>  		return mult_frac(active, 10000, total);

[Severity: High]
This is a pre-existing issue, but does this calculation overflow on
32-bit systems?

If the active memory size exceeds 429,496 pages (about 1.75 GB), multiplying
the 32-bit unsigned long active variable by 10,000 inside the mult_frac()
macro will overflow ULONG_MAX.

This can result in effectively random DAMON quota metrics on 32-bit systems,
leading DAMON to misinterpret memory states and potentially over-reclaim or
under-reclaim memory.

A similar overflow can also happen in damos_quota_score():

mm/damon/core.c:damos_quota_score() {
    ...
    return mult_frac(goal->current_value, 10000, goal->target_value);
}

Here, goal->current_value multiplied by 10,000 overflows for large values,
such as when microseconds of stall time exceed 430ms.

>  	return mult_frac(inactive, 10000, total);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901131326.9761=
5-1-sj@kernel.org?part=3D7
