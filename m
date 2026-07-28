Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDF8391513
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 04:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785212607; cv=none; b=fbxLncCY6PCcw/nnOsRI+YOIYFseX+qt1Sa1bs+KLThtO0P4No4SAt++AX07YeT7VaFpzF7P83sAnsouRkaHYA/SjzAEjrolfek659N4xk3LLWzFOFL1tiEUOP1RZm4ZvYHQn77hi6iMajoamzXDBbFBt/Doh1B1JqLT7ltN2gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785212607; c=relaxed/simple;
	bh=CIejQ20ddc58sfUQN+ym2SVOiAj9nsg1wGEPtl3nWdI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KhJ9JwifjjhNjoc50/oB6bY3U5GMvvxL/pHq/h181rP9KQOvNEDVqVAHP0H/KkmQVKdDMc8CxTcQN6UfLznK7mgMg01oIh+HzOtH8XGqAB+EwzLL6sVw+xhS8tcOAOQ4iWpCow/s9TNUJmtZ2mPQ/sSuAtidkaHLOMEXD4acils=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3F4wygn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3F4wygn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FB51F000E9;
	Tue, 28 Jul 2026 04:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785212605;
	bh=BijJcFaoFSMwmls61IKhpqbdECkEjw8APpJ+3386x7Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J3F4wygnxLX1ftC3fiBgoFtPG/NSK9mPkih5UCPSiLrlBXzZPguTAesHfhT48Z+K1
	 77ZXpweNlttp3hmwAM6BDjj4s7HYoGXLFmdWAjCNVs6J+sWofz4wmpQ/TzZFpkzZos
	 ZZ0TIdYQDuZ32EvgrzCu+jJTJhToOojTsBe1fVIgMAmM+ngsHhfy/T8RwMZoxdHC7C
	 j5x43o2aTCxhjpWvGhFlSy14Do8/3n2lKX3fHI9PO8qA8BoBzezqqMeLLrPZctt68m
	 i8FE8R5GsUnaxVhIZpz+v8hpRGACs24SbaesBV4QYxOGkoG989JPyG1qb/crhQx4BS
	 7HNaxVutpgWFQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 01/17] mm/damon/core: introduce
 DAMON_FILTER_TYPE_PGIDLE_UNSET
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260728041242.187380-2-sj@kernel.org>
References: <20260728041242.187380-1-sj@kernel.org>
 <20260728041242.187380-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 04:23:24 +0000
Message-Id: <20260728042325.68FB51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly introduced DAMON_FILTER_TYPE_PGIDLE_UNSET enum is unha=
ndled in the filter matching logic and sysfs interface, leaving the promise=
d functionality completely missing.
--

--- Patch [1]: [RFC PATCH v2.2 01/17] mm/damon/core: introduce DAMON_FILTER=
_TYPE_PGIDLE_UNSET ---
commit 1ede3c3f87a9caeeb7ad80090cbb84d20b477505
Author: SJ Park <sj@kernel.org>

mm/damon/core: introduce DAMON_FILTER_TYPE_PGIDLE_UNSET
   =20
Introduce a new DAMON filter type, pgidle_unset. It will match pages
that have their PG_Idle flag unset, or the page table accessed bit set.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 0c8b7ddef9abb..a8bb9ee6979e3 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -742,12 +742,14 @@ struct damon_intervals_goal {
>  /**
>   * enum damon_filter_type - Type of &struct damon_filter
>   *
> - * @DAMON_FILTER_TYPE_ANON:	Anonymous pages.
> - * @DAMON_FILTER_TYPE_MEMCG:	Specific memcg's pages.
> + * @DAMON_FILTER_TYPE_ANON:		Anonymous pages.
> + * @DAMON_FILTER_TYPE_MEMCG:		Specific memcg's pages.
> + * @DAMON_FILTER_TYPE_PGIDLE_UNSET:	Pgidle is unset.
>   */
>  enum damon_filter_type {
>  	DAMON_FILTER_TYPE_ANON,
>  	DAMON_FILTER_TYPE_MEMCG,
> +	DAMON_FILTER_TYPE_PGIDLE_UNSET,

[Severity: Medium]
Is the implementation for this new filter type missing from this patch?

Looking at damon_pa_filter_match() in mm/damon/paddr.c, the switch
statement evaluating filter types does not appear to handle
DAMON_FILTER_TYPE_PGIDLE_UNSET. This means it will fall through to the
default case and fail to implement the promised page matching logic:

mm/damon/paddr.c:damon_pa_filter_match() {
    ...
    switch (filter->type) {
    case DAMON_FILTER_TYPE_ANON:
    ...
    }
}

Additionally, it looks like this new filter type is missing from the sysfs=
=20
name mapping array, damon_sysfs_filter_type_names, in mm/damon/sysfs.c:

mm/damon/sysfs.c:damon_sysfs_filter_type_names {
    {
        .type =3D DAMON_FILTER_TYPE_ANON,
        .name =3D "anon",
    },
    ...
}

Without this mapping, type_store() will fail with -EINVAL, making it=20
impossible for userspace to configure.

Will a follow-up patch add the handling logic and sysfs bindings, or should=
=20
they be included directly in this commit?

>  };
> =20
>  /**

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728041242.1873=
80-1-sj@kernel.org?part=3D1
