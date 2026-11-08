Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168021;
	b=tuGLx3KPul9ehzG69GZPfKbB9Nj6iirZ8nVAhKibi/QZ4ok9JIs48m8hsMzYfgrLqx5a
	 4tJiqK0W9lpgPCx0SCrU/jkXJ2WIc4mMfaBIKYAJsla6NTA2Yu+IB1TuxGqlMy4d+0hxg
	 d1Tv9b5K/BuiOtuQaDItIN6lxIeuYqCAtzCHvFeufwjsLOw0L7NA4eyQLqe5z+7WEbpRs
	 mjAr6fbTZqo+CoyWSahAJGx2ppbXsOke6qPRceI+insQN4p3IfN96OydkM5VQ2MRgDxFC
	 UgOqhD7cDn+ybkl9kCJ7D7f9ndnfYq+zIk2qyG9SuoP2nHMThl5WGcyjEKkVFDeC95Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168021;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0t1IoikLmQeJOs13YrNXpWqFQtdpP6egbT1Ng/ntwIA=;
	b=UNhPDhc7vZ7PkIwD+NfaICjPKmUsklg69L0t9UZzwVWWOoas/Nmhc5kIErdJD991K5zu
	 NgZz1lrNF/1cnTz04/Vwtxpfj7pvWLxxB/m597HScRjiXCf1g6xO14j51UQOhXiZvzg4r
	 tQq47MN66nNkbwUBwXIfI+PS81+BqOxvyg/J5kfmWMyTgq9tV2b1jQW/wh8Ck/cHRrbiF
	 rnM8hq9W+VfTb8g4x4y+BAyFHxiQMlmNGXw66yNhwBxb+lWXQ/KGVp3pncjgwNSS+H4XV
	 EYOyBMVnUnoHaqW6EToZ75auk+cjUnWLJo0YbtzRJJquFvf8EIU/3ui7odhcaU0YGOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K54YUwye;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D398606A31C
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K54YUwye
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAE41F0089F;
	Sun,  8 Nov 2026 20:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794168021;
	bh=0t1IoikLmQeJOs13YrNXpWqFQtdpP6egbT1Ng/ntwIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K54YUwyeUgUB0aOnJcNqp57726P1hkg51pByTxgZXqeo39/89w82Rg3A/ypQm5hN/
	 db/DOqQY+zLjSGmUn02Tu8YsLlae6+ReMNYsvDQ2H6kTUFBgTOZ+jMcVspJtVROhdn
	 qDKWycKOfBP28WS8DRQqrtmkNU/YHv3m4xsKmW1czIcBwmZOGjmibTCGh10rQfBssz
	 VfE0QpaEQxJXw3XmTZnhr8JWRxe9i4lF9Cg33Ps15+KSqZdScNDNXjrnIldFORJsu6
	 5XtFrTwAuefHPMDiwxdE6V4iHKDOb40h7n/HW2HSlhUrK9vLjZIpfoTYF7bqSMJUJw
	 tIYiPApzBZhsA==
Message-ID: <sashiko-outbox-204000@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y 1/5] mm/damon/core: skip applying scheme if
 region split for quota fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Usama Arif" <usamaarif642@gmail.com>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261108195145.115792-2-sj@kernel.org>
References: <20261108195145.115792-1-sj@kernel.org>
 <20261108195145.115792-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 20:00:20 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] mm/damon/core: inaccurate tried stats on split failure in
  damos_apply_scheme()
--

commit 2d3797cf5f053ac8bc0b4587f17ff69eb9813ce6
Author: SJ Park <sj@kernel.org>

mm/damon/core: skip applying scheme if region split for quota fails

This commit updates damon_split_region_at() to return an error code on
allocation failure and skips applying the DAMOS scheme in
damos_apply_scheme() when splitting a region to fit within the remaining
size quota fails.

Link: https://lore.kernel.org/20260901131850.98037-1-sj@kernel.org
Link: https://lore.kernel.org/20260901131850.98037-2-sj@kernel.org
Link: https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org [1]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 81d44e41de210..6ef77741b783b 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -1470,7 +1470,8 @@ static void damos_apply_scheme(struct damon_ctx *c,=
 struct damon_target *t,
>  					DAMON_MIN_REGION);
>  			if (!sz)
>  				goto update_stat;
> -			damon_split_region_at(t, r, sz);
> +			if (damon_split_region_at(t, r, sz))
> +				goto update_stat;
>  		}
>  		if (damos_filter_out(c, t, r, s))
>  			return;

[Severity: Low]
Does jumping to update_stat when damon_split_region_at() fails
inaccurately inflate s->stat.nr_tried and s->stat.sz_tried?  At this
point sz holds the non-zero remaining quota, so damos_update_stat()
increments s->stat.nr_tried and adds sz to s->stat.sz_tried even though
scheme application and damos_filter_out() were skipped.  Because
quota->charged_sz is not updated on this failure path, any further
matching regions that also fail to split in the same walk will
repeatedly add the remaining quota to s->stat.sz_tried.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108195145.1157=
92-1-sj@kernel.org?part=3D1
