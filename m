Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19FA39EB59
	for <damon@lists.linux.dev>; Sat,  3 Oct 2026 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791050176; cv=none; b=K8h+5KQslh5S1THw7bfHayhjtEnjy2wh/L58MK6B/omZy+ww4r+F3rfuCcYybX9e7ZgJuw2nOD9wAVpnGZuOYWPTg2SvMD9hGeiBEiy1IHCJ+/ndOZaU8ihmQq4e1/F/BGordvM2/mtndphG42kkhf6jmBidkPMZ6xNJ09X8xvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791050176; c=relaxed/simple;
	bh=tI8lEs17zz4oeqyY15vV802e48Dvf2FkbmskfsSA8s4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aaWuW9BkwT9lnGp9kUmHk765X+cGBluqeMnF5+46tM7dNIfs9CAqNSLdnNOuIszZoigVSCpaOqKqPEvWBk/bxx3ueL+vBUp2pDDTscrNmc5z526L8R+cmeDopRG31UWVPC/IjKsbC3cMdfl8a0ZrHf37l0Uka/llVvJ02HIQg4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKsrzw5a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKsrzw5a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF5C1F0089E;
	Sat,  3 Oct 2026 17:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791050175;
	bh=3uzE+VhxzAX/4ozg8R2PhBiegWPVgLGsSuE6KgxgA20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MKsrzw5a0DGWWGiJA8f3qLAOJE17ArpzPsBfw2aDo2rkm8wS+Pgkd2kYcNjL7allC
	 wiicVKcDBAM4kBLpqgIQGN37nLGt9zPc4yoizzre0uVsewa4t9PayuMvHsOVGcDJOq
	 iLpDPqTu/znrySWJw10GuJiMNe+pZ+bDTcds5bKC5qatkJPbsma+hUILyHCB2o1r0t
	 YNmFcr//jMz6oB9YozljZT8WJ3AZMT75V+ymcaoZxWlIB1AwzSAnN/JjzhG9gQHWrq
	 TgifOeCuQNQnnWLQzyuxQIgUkT36V+l8VmT/bu8H/BYWdKMWZRr/R0zOp9qnj34QZ9
	 NCI7d8aXtxFuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] mm/damon/core: don't skip damos_adjust_quota()
 while esz is not zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261003154616.22092-1-sj@kernel.org>
References: <2026100358-repayment-destitute-a6a6@gregkh>
 <20261003154616.22092-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:15 +0000
Message-Id: <20261003175615.6AF5C1F0089E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm/damon: commit message claims to use non-existent damos_quota_=
is_set()
--

commit b8bc1e659853d831a5550c37c3c7adcd48423fd1
Author: SJ Park <sj@kernel.org>

mm/damon/core: don't skip damos_adjust_quota() while esz is not zero

This commit fixes an issue where DAMOS stops working unexpectedly when a
user disables quota using the online parameters commit feature. It addresses
this by updating damos_adjust_quota() to not skip its work while the
effective size quota is non-zero.

Link: https://lore.kernel.org/20260916135020.86483-1-sj@kernel.org

>     Other logic for catching that uses damos_quota_is_set(), which unders=
tands
>     the fact and therefore checks the effective size quota in addition to=
 the
>     user setup.  Fix the issue by using damos_quota_is_set() in
>     damos_adjust_quota() to determine if its works should be skipped.

[ ... ]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 32737cc5f877b..2f6d60b9ca0f4 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1677,7 +1677,8 @@ static void damos_adjust_quota(struct damon_ctx *c,=
 struct damos *s)
>  	unsigned long cumulated_sz;
>  	unsigned int score, max_score =3D 0;
> =20
> -	if (!quota->ms && !quota->sz && list_empty(&quota->goals))
> +	if (!quota->esz && !quota->ms && !quota->sz &&
> +			list_empty(&quota->goals))

[Severity: Medium]
The commit message explicitly states the fix uses a helper function
damos_quota_is_set(), but the code implements the check inline here in
damos_adjust_quota() and the helper does not exist in the codebase.

Should the commit message be updated to match the inline check, or is there
a missing patch that introduces the damos_quota_is_set() helper function?

>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003154616.2209=
2-1-sj@kernel.org?part=3D1
