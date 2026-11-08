Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794170331;
	b=fCPitZNCKxQDNkSz+PadAppLHdlqUQUXKE45OUuPeqSpq6iyPwuvvPcl9g5bIlMkAPtY
	 vTZR5yDZqX6X5n9Et2k+9cg6T29U9alfZ93LxiedHb0aizn4ektmibNAGcr+f8oKCtyA+
	 vjLYhlYO0VJR2QpJI73ZnAU2VbNrWw/hTXVnXN2vL9110suPTF3A8k699X0lkENRQiFEf
	 Eu19ZYHP78svlMCMN3LQulV0RSclyYqwkFTYJH7ebbUyACVECGn7xnXR74diqjz7Z18Nx
	 HjGnJz9VlnO4AZmQtBdmxfQlY38ZTUiBGiEte0fQVITIHEcg3C9vgnfoDhchCibD87w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794170331;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1lSGQQz1iRjxFl7OGaNvg5LU9IUkbkTzIdL2PLJiZ2Q=;
	b=jG3WxgnIkpA9BHLDOqcMZNs8p3TVpCET0Jlvd8HQ+lytLdPXUIl1rr2hLsTgigJBYLIc
	 joxRNKsFHBzuuAsC2yZbh47xdKhtdrlV+RFAVeJmzERmHfeIpWY2Yf/hfUW9ZUhjN0zu5
	 Ey0dfLu7WXoVyVam/iZ5TIkOkG0o9kDHxJWwlG/t5OzF6HJBYIEt3E308B0GTuqanI6PJ
	 WxB2sQzmnRqnaRhfTfennmiJwVCRGXfPnUBaiuFv4qxoCTHpKcn7pwvmA7WH6xbopSDDr
	 XUOqpdhPlyY5kzSwbcWLnf+SAvifst5SIn/9k+i7xFw5cnm7sDqxBgX6buknCRqSLyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJBqlOYq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E3606A31C
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 20:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJBqlOYq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCDF1F008A3;
	Sun,  8 Nov 2026 20:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794170331;
	bh=1lSGQQz1iRjxFl7OGaNvg5LU9IUkbkTzIdL2PLJiZ2Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FJBqlOYqOCNZZRVaMEwewqU9cxcWDR8zRcBtyyx73bZjPDsCkY6tmGipiW7QydWf9
	 qkAxZ0coq+f/oxj9jrifCBSE1+/s3N8zLblAvPBTwo5YP94QP0Eiwjq6reRvtY/L7k
	 oP6G+cU40ark/Rk22FGkXQHWBRjFdKm+SjMow0tOmT5fO9rvlNjorH4PqMsU/gqA8F
	 Nqcc2X5+Cf6MOETuPO88YL6TvXqgcRVPHYHcH1SucKc7WzgxLoplnVKyfHO505ynGF
	 ALv61Ca34olw0Lx8/86NZdz/iLrE/nDAt6Pcfprq8HCcuUFTdWL+olui/Fi5PizSAm
	 uP1cxXM4PHdkg==
Message-ID: <sashiko-outbox-204021@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y 2/2] mm/damon/core: remove unreachable damos
 charge_{target,addr}_from
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261108202759.117377-3-sj@kernel.org>
References: <20261108202759.117377-1-sj@kernel.org>
 <20261108202759.117377-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 20:38:50 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damos_quota->charge_{target,addr}_from saves the target and region the
> scheme's quota limit is reached.  damos_skip_charged_region() skips the
> target and regions before the point.  The target that was assigned to
> charge_target_from could be dynamically removed from the context by the
> runtime parameters update (aka commit) feature.  In this case,
> damos_skip_charged_region() cannot find if the point is passed or not,
> so the scheme is effectively disabled.
>=20
> Similarly, the user could also remove all the regions of the target
> using the runtime parameters update feature.  It would be uncommon to do
> that, but it is a supported feature.  Because the skip pointer detection
> logic (damos_skip_charged_region()) works for each region of targets,
> this result in the logic is entirely skipped and the scheme is
> effectively disabled again.
>=20
> The user impact is that the DAMOS scheme could suddenly stop working
> under certain uses of the runtime parameters update feature.  It could
> surprise users. No crash or leak happens though.  Users could also
> simply work around by re-installing the scheme.
>=20
> Catch the corner cases in damos_adjust_quota() and reset the pointers.
>=20
> Link: https://lore.kernel.org/20261020023958.108276-1-sj@kernel.org
> Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Closes: https://sashiko.dev/#/bug/linux-cd0c55fc-0cc8-45d8-9637-3334811c4=
9b8
> Cc: <stable@vger.kernel.org> # 5.19.x
> (cherry picked from commit 5695abc4e742b947f586bfb6a080a80ad9957e5d)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108202759.1173=
77-1-sj@kernel.org?part=3D2

