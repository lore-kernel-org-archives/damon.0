Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1857F386C3B
	for <damon@lists.linux.dev>; Sat, 16 May 2026 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778970592; cv=none; b=l2LWFLxAQZRovm2xuofI9gtKKUN5U/aUmzkgWNHUo0ii/IAieZhLEjqPUWIjujuqdgo88H1MupMmxmq6O+CRWL7a61FhR4JqzVMoahCaypcedQUlZbbu98X5gU3R5e46KKNWrIyaDUzKdIQK6USv3ZwPy0P2A2j3XeZb6CdHI1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778970592; c=relaxed/simple;
	bh=F2tWeNFyQ7c7SV5doPynmhBnviVMtOnTq5+vjQUdTMw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vEby2VdpOw6QEyfc6NZgo8kI04gjgOcoOvDz5cY3jqIwpSGv0l+8m5FRYdOJ8XXGcvDRRzjrz/klEDwz1ZtivPhDx6WLHdrPMJvu+ktUe2+xIyVUZFLwihF+Hqk0ByxHJ7ir4wQ0bZeuzoxSQwoaaT/aQUbr7drKeDDmMA1tx2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cO5xYU+U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cO5xYU+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEFCC19425;
	Sat, 16 May 2026 22:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778970591;
	bh=F2tWeNFyQ7c7SV5doPynmhBnviVMtOnTq5+vjQUdTMw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cO5xYU+UUWBBU61c++C0cIi/lfcC94hXacnSbEQLDk4vspkqCwlK9Mdbn5dvMlTOC
	 gnJ5m9L3x4dJRdMpPqFJeSpDZxDEqCmNIB6NqPUsrPF4PjgG/5gaLt0GU5WrpYcgQZ
	 7N4dAA7Wb84LCFIaZtkAtx25GCdtV1yY9sxC+gSnMZVvhdKO33O53dXyufozIL0dqN
	 VaiD7VUk1hcx6fBFK7ZqCQ/kFuf7dZUyAaLpUVUGKoIeUGjycgiT4uTHSd6ZqBcd2Y
	 17knzvirLePzU9TM3g2M9rKDS74K5mgICorAYfLH357gzhhNuuQMmFgk56rjg1LT7E
	 66bZhkQ+W98aQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/5] mm/damon/core: fix nr_accesses_bp underflow in
 damon_moving_sum
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260516210357.2247-2-ravis.opensrc@gmail.com>
References: <20260516210357.2247-2-ravis.opensrc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 22:29:51 +0000
Message-Id: <20260516222951.8CEFCC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unsigned integer overflow in DAMON's moving sum and access rate tr=
acking for large intervals.
--

commit 1d58ed9728ddbaf4579ec265e453a7b3a233285c
Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

mm/damon/core: fix nr_accesses_bp underflow in damon_moving_sum

Guard against unsigned integer underflow when nomvsum/len_window exceeds
mvsum. When that subtraction wraps, the moving sum returns a near maximum
value and corrupts nr_accesses_bp. If subtrahend > mvsum, return new_value.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 3a8725e400c6b..9975f3d9ebfe9 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3449,7 +3449,11 @@ int damon_set_region_system_rams_default(struct da=
mon_target *t,
>  static unsigned int damon_moving_sum(unsigned int mvsum, unsigned int no=
mvsum,
>  		unsigned int len_window, unsigned int new_value)
>  {

This isn't a bug introduced by this patch, but could the nomvsum argument
passed here be silently overflowing?

Looking at damon_update_region_access_rate(), damon_moving_sum() is called
with r->last_nr_accesses * 10000:

mm/damon/core.c:damon_update_region_access_rate() {
	...
	if (attrs->sample_interval)
		len_window =3D damon_max_nr_accesses(attrs);
	r->nr_accesses_bp =3D damon_moving_sum(r->nr_accesses_bp,
			r->last_nr_accesses * 10000, len_window,
			accessed ? 10000 : 0);
	...
}

DAMON allows configuring aggr_interval / sample_interval up to the maximum
32-bit unsigned integer (for example, 10ms sampling and 1.5 hours
aggregation).

This means len_window, which bounds last_nr_accesses, can exceed 429,496.

If this happens, won't the multiplication r->last_nr_accesses * 10000
silently overflow the 32-bit unsigned int limit of 4,294,967,295?

If this overflows, the corrupted, wrapped-around value is passed as nomvsum,
which would cause subtrahend to be artificially small.

Additionally, would this cause r->nr_accesses_bp (which accumulates mvsum)
to also continuously wrap around 32-bit limits?

Could these silent integer overflows corrupt memory access tracking and lead
to erroneous memory management decisions, like reclaiming hot memory?

A proper fix might require bounding len_window to 429,496 or using 64-bit
integers.

> -	return mvsum - nomvsum / len_window + new_value;
> +	unsigned int subtrahend =3D nomvsum / len_window;
> +
> +	if (subtrahend > mvsum)
> +		return new_value;
> +	return mvsum - subtrahend + new_value;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260516210357.2247=
-1-ravis.opensrc@gmail.com?part=3D1
