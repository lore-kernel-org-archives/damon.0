Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1C247CC8F
	for <damon@lists.linux.dev>; Mon, 28 Sep 2026 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585121; cv=none; b=cnqYPtakwAX+pwq+6J+Eyhoc6j9Yqj6nN+qOIXHvR5cd7lAIn7EbgZeZc+z2NZR8igXUbgfAdCKUIg2ep/GVCqVC07OLBwi0VBh84+aFvU32aGndqkvOOjw4TyDTU7tkKgNHypBKWQRqr6IW/GleK+APz18VWfV4/ibTot8jzOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585121; c=relaxed/simple;
	bh=fjntdoEUF8f+Afv4foJbjSNEaY5G4BA+IWnGOlsjq7E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WyK75xkK9NKXVi0T4FBZeLEuWj7x51yNTE81QqlwAbLh15KlTrHiPmLIxwAZo7BROkqcGJ32v0/5GErnSIJUw+h9DRYgmtMPmqyYZZHRoZy/ZKBATMfrFMtxHeViLivof3sa/6yn1/RJ3Gbvruj9iTbNm3egMblckPlK27BUeTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LE3Tdv8d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LE3Tdv8d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51841F000FF;
	Mon, 28 Sep 2026 08:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585120;
	bh=H8aXtSpTAMw/kS0D/Ag+iRF9UtO5bOZQ3cJN98+xiGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LE3Tdv8duBVk5n6tlU1Tmrz9SKcLCoZd/TWdOClJPuJDVRYbU7ay/0oqXwkSClhsF
	 xHTl85nCQsif3+NbU5LAgpuUpC+lDKoqNmdtnUxMwZO1xMZ7hHZDi1WUxWU6j7L9tz
	 GLfgdzSiTtwUxRzhNIP6AFtaX6DKxT8uBM8522TpD0ag/Dg+F6xXey0/I1SupqSHhU
	 pIGEktufouOUliCx/PaUqCYlYGbf2oGYUySmxFUHPURA/1v6aS8nJjFmiXoBpF/Vkf
	 TAZFZkr2y0Py3+CIx9ijAnExvAyYQvAzXCXfKALl59OOqH8aJIGP+3aZs9I0CFjFFh
	 Q/hWL/rVYTKNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] mm/damon/core: reduce stack usage further
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260928083959.4030-3-sj@kernel.org>
References: <20260928083959.4030-1-sj@kernel.org>
 <20260928083959.4030-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:45:19 +0000
Message-Id: <20260928084519.E51841F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> In a previous patch, I had annotated kdamond_tune_intervals() as
> noinline_for_stack in order to not exceed the stack frame warning
> limit. Unfortunately, my current linux-next randconfig builds show
> a similar problem again with clang-21:
>=20
> mm/damon/core.c:3953:12: error: stack frame size (1288) exceeds limit (12=
80) in 'kdamond_fn' [-Werror,-Wframe-larger-than]
>  3953 | static int kdamond_fn(void *data)
>=20
> Do the same thing with kdamond_apply_schemes(), kdamond_merge_regions(),
> and kdamond_split_regions(), which also have individually large stacks.
> This should work to keep the deepest total stack depth down much more
> as well as avoid the warning.
>=20
> I also tried to reduce the complexity of kdamond_fn() itself by splitting
> out the while() loop into a separate function. While this arguably led
> to slightly more readable code, it had no effect on the total stack
> usage and just made the new function the largest stack user and had
> a nonzero risk of me getting the conversion wrong.
>=20
> Fixes: 5a00cae64de1 ("mm/damon/core: reduce kernel stack usage")
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928083959.4030=
-1-sj@kernel.org?part=3D2

