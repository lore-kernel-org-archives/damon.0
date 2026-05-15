Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DA8346FC3
	for <damon@lists.linux.dev>; Fri, 15 May 2026 01:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778807655; cv=none; b=XByrycJm7ubkCGj/PsVcNzFF18BDOGoBSNqwWnkUjhOlzr88guknV/s4A1DNPlwoxiUIsiRAWDKXT6M+StOwYN2pZMtUnMJHpaeRXpHC3OJr1qMz9NCpdOpHetUggJyfq8dyBggVXhPXR/b/JCj2wNUjObYyjT4rXtYgZZrAW+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778807655; c=relaxed/simple;
	bh=XvwS9kdNuN1gbSajZ/hiqbv3RQ+vvnQcgDFKkiiOVyw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RJWjh2C0TzhYnjbyRiktD+ajDTZnNhIp13zjxbqUTI7ZIdkkdKb0ZkX0piopLtrgXqS6KFZWrPwlE7dWCqqkKXXMVreoW99VRkuaLPreA6CrETIWg4Z+w/mc5/JeuYmFcK0oUK7/PEYdmVuHnBgrCqR/u+lAv3XcAEHXQBNKGf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onl+z+jB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onl+z+jB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAA4C2BCB3;
	Fri, 15 May 2026 01:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778807654;
	bh=XvwS9kdNuN1gbSajZ/hiqbv3RQ+vvnQcgDFKkiiOVyw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=onl+z+jBb00C7SJ8hsFA6HjADp1Lb/PlqwYo4IkA0SqdryzQcyFPN4EBc73Ve06Ve
	 Z6674ud8v1cjH2eptRYzd4KVSbsm7ZWGQDYhmbnqw5/y0KmEYMxhEPImxUa/B9TdB6
	 oWJJ7jpi1t3Tz8VqiwolXsJAVjhQ3sLDiIyVB8NpJxQbXuPbEcSc0DhsXAfW3dYSm+
	 O4aYHf/bvxDNSy+X1jkzTKt8mLaB3eWE8SyFWKKE3RJMwTBKWkx5qUfSzb7w5fcmxe
	 gRkWJCZ2Cf83sRjnXefUWm9vt3PukeBX5HrP+WAczf7lKDJz/qWxX9ogdyWGmO6V4G
	 nhh++4ZV49DTQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 03/28] mm/damon/core: introduce damon_filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260515004433.128933-4-sj@kernel.org>
References: <20260515004433.128933-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 01:14:13 +0000
Message-Id: <20260515011414.6BAA4C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Unsafe macro definitions for `damon_for_each_filter` and `damon_for=
_each_filter_safe`.
- [Low] Typo in the kernel-doc block for `struct damon_filter`.
--

commit 483481d8b5710ceb3aa6769a6360b2dc2305434c
Author: SeongJae Park <sj@kernel.org>
mm/damon/core: introduce damon_filter

This commit defines a new struct damon_filter and embeds it into
struct damon_probe for monitoring purposes. It also implements essential
handling and helpers such as filter allocation, addition, and freeing.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 3ba5a31b51769..9c2576f103767 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
[ ... ]
> @@ -721,12 +721,38 @@ struct damon_intervals_goal {
>  	unsigned long max_sample_us;
>  };
> =20
> +/**
> + * enum damon_filter_type - Type of &struct damon_filter
> + *
> + * @DAMON_FILTER_TYPE_ANON:	Anonymous pages.
> + */
> +enum damon_filter_type {
> +	DAMON_FILTER_TYPE_ANON,
> +};
> +
> +/**
> + * struct damon_filter - DAMON region filter for &struct damon_probe.
> + *
> + * @type:	Type of the region.
> + * @matcing:	Whether this filter is for the type-matching ones.

This isn't a bug, but there's a typo in the kernel-doc block here.
@matcing: should be @matching: to match the struct member name. This could
trigger kernel-doc warnings during compilation.

> + * @allow:	Whether the @type-@matching ones should pass this filter.
> + * @list:	Siblings list.
> + */
> +struct damon_filter {
> +	enum damon_filter_type type;
> +	bool matching;
> +	bool allow;
> +	struct list_head list;
> +};
[ ... ]
> @@ -880,6 +906,12 @@ static inline unsigned long damon_sz_region(struct d=
amon_region *r)
>  	return r->ar.end - r->ar.start;
>  }
> =20
> +#define damon_for_each_filter(f, p) \
> +	list_for_each_entry(f, &p->filters, list)
> +
> +#define damon_for_each_filter_safe(f, next, p) \
> +	list_for_each_entry_safe(f, next, &p->filters, list)

Is it possible this could cause operator precedence issues if a complex
expression or cast is passed for p?

It might be safer to wrap the macro argument p in parentheses, like
&(p)->filters, to avoid potential evaluation errors and compilation
failures in the future.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515004433.1289=
33-1-sj@kernel.org?part=3D3
