Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C05F2F617C
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 19:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789241384; cv=none; b=dcNlYHkd//c8lzeH8sQ64UC2Eu6a5G6ObJe8KX6/ebihDseYGMhOu7NvEW6jshvs9n1u8eILf8sV336lxVctj5vyRXQkskuFOwQPmIpUEFaNN+yWxefETswu1gZr3bH5UtuEj2a5wzpe7/4fZlw9mvJpeot2ebQ3KB2srHD09Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789241384; c=relaxed/simple;
	bh=Efe13oinaqQ9W1oAGNZJkXPvFedxxq2zVonO5zHKa9c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j4C4UytnoToBa1X6cNkCzxhRW+kNSHL0t2XTwC0OQWg4IKZV9s8F/RkZnZqjg3WnkEHW9khZlwM7GfIdtMewoYt7K7zpdlcyHuLTfbJoi91Vz9HYVdFLF2mmhfLXSkiQ5f0jBQIrKtwegPl+t8XLuezPXVkNYbftGZZ8w9OC37s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lC5vGIOf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lC5vGIOf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD411F000FF;
	Sat, 12 Sep 2026 19:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789241382;
	bh=xmyKr89+ZF6lvDu6qBPseofKxF1WH0IJBoe8SfvjCbM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lC5vGIOfE4Voc2R/2M1yVYzhCo85C1vqji2OYH0KYGmCSs0XJhKENjKf3qs4TR2x3
	 6PhpjKNEsF1Qw5U2r1pK/4dc4QW2FTf2+TmLDkGkSPF4NGJ6ItUm+5M5IvoRqd6QRX
	 q83tAhEBxBRvpJJgUOAqsaZ38IvVRSaXsT6O8p+tAa4R+FTvlkSIlIodxGFxgjsdKB
	 zB2hlJogMLNpyYv38KtvCjyGmVf8iBSCA68mROATNxBahi8BMFizyiI82h1SDsp2qZ
	 DP7VPOKZcmASPzHCua0yQTANyYXE9Fj9Y7/g5d/CXp/ppjw1L24+eD8TA0+aLwGuKu
	 XiVMvPsyCAvBQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/8] mm/damon/core: disallow max < min damos filter
 range arguments commit
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260912191807.138502-5-sj@kernel.org>
References: <20260912191807.138502-1-sj@kernel.org>
 <20260912191807.138502-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 19:29:42 +0000
Message-Id: <20260912192942.AAD411F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The newly introduced validation in `damos_commit_filter_arg()` ret=
urns `-EINVAL` on failure, but callers `damos_commit_core_filters` and `dam=
os_commit_ops_filters` ignore this return value for new filters, adding uni=
nitialized memory to active DAMON context.
- [High] `damos_commit_filter()` mutates the target filter's state (type, m=
atching, allow) before validating its arguments, leaving the live filter in=
 a corrupted state if validation subsequently fails.
--

commit b7aac655c61845e48301bed4669cfcf294cf84cb
Author: SJ Park <sj@kernel.org>

mm/damon/core: disallow max < min damos filter range arguments commit

This commit adds validation to damos_commit_filter_arg() to reject invalid
ranges where max is less than min. It returns -EINVAL when an invalid range
is provided, avoiding duplicated validation across different DAMON API call=
ers.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 3ad1fb2f21f3f..3dec1a8f7ed3a 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1325,15 +1325,21 @@ static int damos_commit_filter_arg(
>  		dst->memcg_id =3D src->memcg_id;
>  		break;
>  	case DAMOS_FILTER_TYPE_ADDR:
> +		if (src->addr_range.end < src->addr_range.start)
> +			return -EINVAL;

[Severity: High]
Does this code leave the target filter in a corrupted state on error?

Looking at damos_commit_filter(), the state is mutated before the newly
introduced validation has a chance to execute:

mm/damon/core.c:damos_commit_filter() {
	dst->type =3D src->type;
	dst->matching =3D src->matching;
	dst->allow =3D src->allow;
	return damos_commit_filter_arg(dst, src);
}

If damos_commit_filter_arg() returns -EINVAL here, dst->type, dst->matching,
and dst->allow have already been modified. If an existing ops filter receiv=
es
an invalid range update, its type will be updated but its union arguments w=
ill
belong to the previous type. When the filter executes, it might misinterpret
the old union memory according to the new type, causing unintended matching
behavior.


[Severity: High]
Can this validation error cause uninitialized memory to be added to the act=
ive
DAMON context?

Looking at damos_commit_core_filters() and damos_commit_ops_filters(), the
return value of damos_commit_filter_arg() is ignored when creating new filt=
ers:

mm/damon/core.c:damos_commit_core_filters() {
...
		new_filter =3D damos_new_filter(
				src_filter->type, src_filter->matching,
				src_filter->allow);
		if (!new_filter)
			return -ENOMEM;
		damos_commit_filter_arg(new_filter, src_filter);
		damos_add_filter(dst, new_filter);
	}

Because damos_new_filter() allocates memory without zero-initializing the u=
nion
arguments, returning -EINVAL from damos_commit_filter_arg() means the union
payload (like addr_range or sz_range) is left uninitialized. The callers ig=
nore
this error and add the filter to the system anyway, which could result in
using kmalloc garbage and triggering undefined matching behavior.

Additionally, damos_commit_ops_filters() ignores the return value of
damos_commit_filter() for existing ops filters:

mm/damon/core.c:damos_commit_ops_filters() {
...
	damos_for_each_ops_filter_safe(dst_filter, next, dst) {
		src_filter =3D damos_nth_ops_filter(i++, src);
		if (src_filter)
			damos_commit_filter(dst_filter, src_filter);
...

If an existing ops filter receives an invalid update, the validation error
is swallowed entirely.

>  		dst->addr_range =3D src->addr_range;
>  		break;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912191807.1385=
02-1-sj@kernel.org?part=3D4
