Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11081F942
	for <damon@lists.linux.dev>; Wed, 29 Jul 2026 03:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785296905; cv=none; b=hxDZWEeejdj4HY3B8WZIb+F6QKPcDZ/PEGmdyU/dlVg1cUtITmO6QjJLAn4yq1UlcW8vnLHeZYr+/qc1pj5MOs/6zxmnn9Or12nKXKTPeWmRUVhCK2230Woe/wGvhIamd/CA0U3OlJShnm9FHgIuqzGbLyYDzG9T0XBUESuUDPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785296905; c=relaxed/simple;
	bh=nEPXVSoUQqmSoLBJFFIydh2YN429ihwCKD8eC8D0Yxo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dx9YzfKKlzJEC7k1qKqYQMSHV5djtfZfT6SRnQgRWfVhB6gTJX2vdmqnqnJYo0Fym2BeLc/eg+uuyBzqIyGanc8XQQf3XxXYlXY5ZipwIhXmDb8vzs+Xey9p7WC4stJr9j5VFsMrTObbot8cM/dcRg1khs95TNj2vxpWgAd+5BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+zWCxIC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+zWCxIC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE14B1F000E9;
	Wed, 29 Jul 2026 03:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785296902;
	bh=ldFK0dm9DEpYNSdwPPmeLjZXCjLZ+mxfsbwuZQPfEFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e+zWCxIChhbgEy3gPtlZ14yuOkl9dylwC+cpvXLd/mfkAlKX1Q0j9X7+yUio6mHH9
	 7MWE3uO10hCs6TWlN6N1/p2a/CeGrdoy3LwSEuC6R2ixkvTDAbv7VrJq0xnd2jjMoY
	 21ZHFYlN0Mo+OiAhy6zjQrX0GXeN3RJ/AbvGVTdZYiBrvlgtAk8AAzqbXhMhXMYsfk
	 HBNbui358mNsI+9vaMaZw3Ehvrc77fsfg/TLFYYxaZHjmLaAoUCj1vaQtMzwPyEJOz
	 ip9P2BB/g98S50CQc1H7SIR9QqoShqIM0EYNhv8/q7F6kGydctpQkLFux485K5QMax
	 G+SXMxaRsKfSA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 06/10] mm/damon/tests/core-kunit: test
 overlapping ranges for set_regions()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260729033751.131213-7-sj@kernel.org>
References: <20260729033751.131213-1-sj@kernel.org>
 <20260729033751.131213-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 03:48:22 +0000
Message-Id: <20260729034822.AE14B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Typo in comment: 'alingment' should be 'alignment'.
--

--- Patch [6]: [RFC PATCH v1.1 06/10] mm/damon/tests/core-kunit: test overl=
apping ranges for set_regions() ---
commit 696ade5451511d51ec415451a2df25bef4d15e9d
Author: SJ Park <sj@kernel.org>

mm/damon/tests/core-kunit: test overlapping ranges for set_regions()

This commit adds a kunit test case to verify that passing overlapping input
ranges to damon_set_regions() is properly disallowed.

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index ac15393a7935b..3041b8288ec26 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -606,6 +606,17 @@ static void damon_test_set_regions(struct kunit *tes=
t)
>  			{.start =3D 42, .end =3D 21},
>  			}, 1, 1,
>  			(struct damon_addr_range[]){}, 0, -EINVAL);
> +	/*
> +	 * Regions resulting in same region after alingment should return
                                                  ^^^^^^^^^

[Severity: Low]
This isn't a bug, but there is a typo here (alingment instead of alignment).

> +	 * -EINVAL.
> +	 */
> +	damon_test_set_regions_for(test,
> +			(struct damon_addr_range[]){}, 0,
> +			(struct damon_addr_range[]){
> +			{.start =3D 10, .end =3D 20},
> +			{.start =3D 20, .end =3D 30},
> +			}, 2, 4096,
> +			(struct damon_addr_range[]){}, 0, -EINVAL);
>  }
> =20
>  static void damon_test_update_monitoring_result(struct kunit *test)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729033751.1312=
13-1-sj@kernel.org?part=3D6
