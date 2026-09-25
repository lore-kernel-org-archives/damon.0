Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9A44749D1
	for <damon@lists.linux.dev>; Fri, 25 Sep 2026 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341630; cv=none; b=QJLv3SjClI+qQEkptISIKaugKDsRXjQ72We2eKS/LHyM/+ZUgjwV+Qxt1zzfeSq5zd7vEEash+8i7O7ACdr/tnKAkAfnrHGjhrPQMXJTTDBupQg5r/8nH/5r8AywlukIw8zw8e8Azg/oyf3do02d05ZF8RYyr4kMtJlOnHdSHRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341630; c=relaxed/simple;
	bh=w45YtsNu+aUJonX9LBTYZ1YTPHc+GgdT4oVuitc8HPc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GxYwIzewrnH5qpHX8omPrCod4/GYpW3tZY+NZA0j665V/iV9158OP1iE6/hCB4Dki67OFifoHncIyhT+9lhbuqu3l43gfdQt+nl0AbL9Ls5RJ0DXozggh/cXbXD5uaeLX544DQDd5CgyEq4TFjqnEZDXaWRulsk8c8vqFk/J4zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvS26/9o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvS26/9o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A251F000FF;
	Fri, 25 Sep 2026 13:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790341629;
	bh=Qa36mFtiaXAMKkwp/la26TiO03VUOFGx31QmRVVkLz8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SvS26/9oQJqUNfDDJgbGpPa4lJCc1a0XF/vgbP4My+HOuOeQ3b1RrZR0TsMP+Sxuq
	 8vGVSdFAlHV1llCKOK+GBPZvr00Df7fzpezY1oC3R7hbHm68gSvlKQm8er+iWpKMGh
	 3qhm0+cEcdASSIiyhMmjdelhiDk0UHVqO5BwfWDCuHsbuZf45IvC7r/TflZSR1JD5N
	 FJvMmgqzDIsxYPByK3Zi25aB9NhXC37AX0bF5wr3pukGdC0MITaILIdXqfabJkqm30
	 FKMfo6Wz2KWZttW3YeZpKl5iNbZ6xDtfRdeZ+9xIZVB68KIBIC3E0vOiDGxGqUujsv
	 /NM5diJz78jvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] damon: reduce stack usage further
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260925130254.4022227-1-arnd@kernel.org>
References: <20260925130254.4022227-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 13:07:08 +0000
Message-Id: <20260925130708.E6A251F000FF@smtp.kernel.org>
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
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925130254.4022=
227-1-arnd@kernel.org?part=3D1

