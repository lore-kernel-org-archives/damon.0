Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402C2484242
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397978; cv=none; b=V6nmc3/KNg2dwKZsb4V7K2TyyHn1FdQ7SUieZHV8KZwz34r8HgYrgOFVZueqk9/wEOEp+6K7ZaJvTnzAoJQadI3UmFks0TaP8oxmPi4jkhMj/6KJqZDaIE8f37zGTkYx7KjBK9kZmqANVx+kWkre3ofcqNQBWD2c1BltTL+9Dgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397978; c=relaxed/simple;
	bh=G8wq7yk5Sp4MLNtZS5ou1mq7KzjNBhyKMMJsroIANFI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KmkjCUK7hMa0x6u9psMNul8VXrN2f20ff0Oj/hXKQwIEPPV+HnzO+UtFGQJwc5QjP+TN7s0l0TAZmwhu8FSxuK70T9QnwCA9+o9MDeowF4zQ+mOe5G1DhRgA5nxUr4URxEX4/EjiX8JDgSlIh89fIhkEcyFlxDy6cjGo9tDIA5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCAr2BDu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCAr2BDu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E2F1F008A2;
	Mon, 14 Sep 2026 14:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397976;
	bh=WQKz9SBnLCEMbAYRsHKczKmDz1VPjFXGomxcuVJ3LD4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BCAr2BDuHj9d9zkR2g52xAJAdIdlm7wM0LFgycEz6xUuJVQenQd0aVlS1wROZ3BxO
	 4WgdC1tyMUB87F8om1OFpM9qMVp/NnyGyk9diHLq35PFrsXIkphr+PmVnf0jPT+X8m
	 ktCddmN8RviomVUf+3pelSssQBrpyqS1DrC1vuqAwXHR3MqXyHAOTDnCrI6xhEN8wk
	 8LJz7lFk63nGrv3X2H4p9ynqP9saNF+ds61cZl7DvY6v20QnKPE+H78imBRiAMvyea
	 A1YrHjemf5uQozLsYbSi44/4u4mtk4e8FraE0lr/UmXZ/r7rQU+80hnU+qytPJyA3L
	 +Jf9YxShgoUJA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/8] mm/damon/ops-common: support hugepage_size
 damon filter matching
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260914144448.93732-4-sj@kernel.org>
References: <20260914144448.93732-1-sj@kernel.org>
 <20260914144448.93732-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:59:36 +0000
Message-Id: <20260914145936.B4E2F1F008A2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Memory leak of newly allocated filter when HUGEPAGE_SIZE range i=
s invalid.
--

commit 5ea2818b5d3def212dc5a08d79877c1ebf66bd6e
Author: SJ Park <sj@kernel.org>

mm/damon/ops-common: support hugepage_size damon filter matching

Update ops-common data attribute filter matching logic to support
hugepage_size filter type.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 0c98f7e267d07..ecfe99450e5f0 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -1838,6 +1848,12 @@ static int damon_commit_filters(struct damon_probe=
 *dst,
>  		case DAMON_FILTER_TYPE_MEMCG:
>  			new_filter->memcg_id =3D src_filter->memcg_id;
>  			break;
> +		case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
> +			if (src_filter->range_max < src_filter->range_min)
> +				return -EINVAL;

[Severity: Medium]
Does this return path leak new_filter?

When src_filter->range_max < src_filter->range_min evaluates to true
in damon_commit_filters(), the function returns -EINVAL immediately.

Since new_filter was already allocated earlier in the loop:

        new_filter =3D damon_new_filter(src_filter->type,
                        src_filter->matching, src_filter->allow);
        if (!new_filter)
                return -ENOMEM;

and has not yet been added to the probe's filter list or freed before
this return, does this drop the only reference to it?

> +			new_filter->range_min =3D src_filter->range_min;
> +			new_filter->range_max =3D src_filter->range_max;
> +			break;
>  		default:
>  			break;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914144448.9373=
2-1-sj@kernel.org?part=3D3
