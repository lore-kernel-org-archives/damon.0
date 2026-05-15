Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96AC22538F
	for <damon@lists.linux.dev>; Fri, 15 May 2026 01:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778808142; cv=none; b=KaMGVJQOG/NmA75RIytc68PORPHct0OtivhMSu4KkeSEuvWJ4o8gvMix3M7quovqR5HwaVqRealgZhsoSJBCzzkU+lXO6ZmFUJTSnGr0Yvpy3THTFI9fK/D16uk+igdB9XgN5FVQ9Pgbq6A1I4z9ee22KDQk4ZU6u3kcqoUGyro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778808142; c=relaxed/simple;
	bh=8jRzXMOc1ZS3trzIlQ2vvzNbsDKd2UFt87l7638nlIc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OBtWLS/XKDyXhc2AqbtBzWVQzIWTA9AZcOY+W41nYG+WiuXeubcRt02ppK/vv0CBZOBx+Ff0vMt8fXprm5N9wMYwF+XcmHdWpVV6f4oT96cR/rCS4SgDXJc3hfquTxoihK8ytKJ1YMQm0dG4wmpzcVmoGKkEqXaKSDyn4d/Ep2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnfTUYP3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnfTUYP3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F47C2BCB3;
	Fri, 15 May 2026 01:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778808142;
	bh=8jRzXMOc1ZS3trzIlQ2vvzNbsDKd2UFt87l7638nlIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=FnfTUYP3tUP0hGiU1uu6hc0BSk99XpdCE3DWT23n60v9zuNtGVoPkVUnw6SNpWs5/
	 y4yXYQFQaiveBbcp7+ef/FIu3bIOLFYCpYUtQNv+k7cT4sn6IMq+J6rsor4e+YSq7q
	 yCe7LlNwBcFHfLQTEeFPrwWMgPe+Fvuf+rrnDjLSCNy6b0UivA1eRdghNN0UQx41KY
	 x3/08djaq5xQdxdS75rlz1dTn6vzSY37r6Hv4IMybOZpb7GHGt+SgKTmbcDIejzmnu
	 JmGVjZljJMX5/OIyLPg7x6Raq92kxbVhPzAeQ3ra+v7MtzsPJGafziypTEa3jm60qm
	 Axsc/pWGYxy3A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 22/28] mm/damon/core: introduce
 DAMON_FILTER_TYPE_MEMCG
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260515004433.128933-23-sj@kernel.org>
References: <20260515004433.128933-23-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 01:22:21 +0000
Message-Id: <20260515012222.72F47C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Newly appended DAMON filters in `damon_commit_filters()` fail to c=
opy the `memcg_id` field, leaving it uninitialized.
--

commit 01e48275cc904a624a318c3fbc6c7313978207ef
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: introduce DAMON_FILTER_TYPE_MEMCG

This commit introduces a new DAMON filter type, DAMON_FILTER_TYPE_MEMCG,
which allows monitoring and filtering based on specific memory cgroups.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index ab8ac9ec8450d..2d4a63dcc47fe 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1422,6 +1422,13 @@ static void damon_commit_filter(struct damon_filte=
r *dst,
>  	dst->type =3D src->type;
>  	dst->matching =3D src->matching;
>  	dst->allow =3D src->allow;
> +	switch (dst->type) {
> +	case DAMON_FILTER_TYPE_MEMCG:
> +		dst->memcg_id =3D src->memcg_id;
> +		break;
> +	default:
> +		break;
> +	}
>  }
> =20
>  static int damon_commit_filters(struct damon_probe *dst,

When new filters are appended during probe synchronization, does the
memcg_id field remain uninitialized?

Looking at damon_commit_filters() which immediately follows this function,
it creates new filters for any remaining source filters:

static int damon_commit_filters(...)
{
...
	damon_for_each_filter_safe(src_filter, next, src) {
		if (j++ < i)
			continue;

		new_filter =3D damon_new_filter(src_filter->type,
				src_filter->matching, src_filter->allow);
		if (!new_filter)
			return -ENOMEM;
		damon_add_filter(dst, new_filter);
	}
...
}

Since damon_new_filter() only initializes the type, matching, and allow
fields, and memcg_id is not manually copied here like it is in
damon_commit_filter(), could this leave the newly appended filter's
memcg_id with uninitialized memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515004433.1289=
33-1-sj@kernel.org?part=3D22
