Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794092215;
	b=VHPNmPyZnRTB+sBbKqlbJd//0dSDoNVacW8zzPAAo+MShcShniheE0HqzL1EyczF8NYB
	 5BzZtLO0O5Xpe4dIwruqm9HKuvqv6l7ucO2oNgQEXyOKgXIFQWlRy37eKKPoMo0ruy+d/
	 N8maBINQ5dpqZ7IXeiCkvQZHTONuZnJKJ89s893I4uCocTmeqt5hJ2ciz3Os/3Q3buVsB
	 t1hq3a8mfHkob6P1SB8oKMvHA5+lms3n3LcmBuA/5NHpNwxpo8TTyPUZO72OlR5PZzedA
	 4YWMtRk9StocZCgKQPRXOSbc8+WsZNHNRvuixA1gZrMYGMDWYQmqEl5L4gizzQE6znw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794092215;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8wUwXJNx8JD7Fl9dgQdIfo0QjeGVmxmT1LPcE0XUKqw=;
	b=WjTEE/a1Rq+/0YNIL1llhpoH82+9GAE1cuuTp58cp8wNRh8xBUqCKIUIpWqRPckXa3rU
	 bg4kIOaFsIy07vpwwWBmADQkc+ZVmVH2LQkrDmx97SdWTx/9URrCydBLoo12gbd/kPU6S
	 OybMpKoYQ1FLto+sr86fBl+LfIWBu4mnioBwWtJ6ETYr3J1ZMhaRkBPyOZc09hQyx5g/g
	 uekCKPXoVOZS9jiDqRPfFvnamyb/2hoSww9h6DY2vE6TEZMYL/iUDCxRDfGxHlNrtjj8O
	 Ahbp22qI4EluLdlCj5imYgyz48Z7Q/f2b9jbLe7ChUcXcCHkiqJX1TV63H0H0hoMz7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLchhquA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E636A606A326
	for <damon@lists.linux.dev>; Sat,  7 Nov 2026 22:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLchhquA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345101F0089F;
	Sat,  7 Nov 2026 22:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794092214;
	bh=8wUwXJNx8JD7Fl9dgQdIfo0QjeGVmxmT1LPcE0XUKqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DLchhquAjxZ4d+JYytrasILc/gJMBTIr4SAHeTcBr6036pTK4jVv0PePY54yGNLWd
	 1Bdzm6yxhulvRkXT+gvnNFsNVRIvr9u9g/Df8pR0CWlzj4o4aoWrCA6DS+jybjuIEf
	 O4h7WB1YW02o4Y3AzzHqKxW5afsZrJIfyVN7zpBllKgSVbziqn0Sth185PcBx1+dgj
	 2psPju/Om+1RcnzCadXIFmXSPjieZrAFPsj7ARJb72ku/8V1mvHlAGrVOymyBlCJ5H
	 i/tN//2+7oBX/ex30ytKRj+o8fsT59k20qiT3QVQyMhf51WYf3l+FMCa4f4tlyozA7
	 iWD8B+Cjz22hA==
Message-ID: <sashiko-outbox-203373@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.1.y 1/2] mm/damon/core: skip applying scheme if
 region split for quota fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Usama Arif" <usamaarif642@gmail.com>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261107224800.340250-2-sj@kernel.org>
References: <20261107224800.340250-1-sj@kernel.org>
 <20261107224800.340250-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 22:56:53 +0000
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
- [Low] mm/damon: inflated tried stats in damon_do_apply_schemes() on
  split failure
--

commit 2d405ecddea503227b3b4138fe63cbeb95dc50b9
Author: SJ Park <sj@kernel.org>

mm/damon/core: skip applying scheme if region split for quota fails

This commit changes damon_split_region_at() to return an error on memory
allocation failure and skips applying the DAMOS scheme in
damon_do_apply_schemes() when splitting a region to fit within the size
quota fails.

Link: https://lore.kernel.org/20260901131850.98037-1-sj@kernel.org
Link: https://lore.kernel.org/20260901131850.98037-2-sj@kernel.org
Link: https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org [1]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index f0da5cb2b88a0..9206737d05ae7 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -810,7 +810,8 @@ static void damon_do_apply_schemes(struct damon_ctx *=
c,
>  						DAMON_MIN_REGION);
>  				if (!sz)
>  					goto update_stat;
> -				damon_split_region_at(t, r, sz);
> +				if (damon_split_region_at(t, r, sz))
> +					goto update_stat;

[Severity: Low]
Does jumping to update_stat here inflate s->stat.nr_tried and
s->stat.sz_tried when damon_split_region_at() fails?

Unlike the !sz path right above, sz holds the non-zero remaining quota
when damon_split_region_at() is called, and update_stat unconditionally
accounts it:

mm/damon/core.c:damon_do_apply_schemes() {
	...
update_stat:
		s->stat.nr_tried++;
		s->stat.sz_tried +=3D sz;
	...
}

Because c->ops.apply_scheme() is skipped and quota->charged_sz is not
advanced, any subsequent matching regions in the same pass that also fail
to split will repeatedly add sz to s->stat.sz_tried.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107224800.3402=
50-1-sj@kernel.org?part=3D1
