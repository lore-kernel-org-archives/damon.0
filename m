Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794088412;
	b=ZxCXWncoLLxbY/0Rv6no/+N947aUcaPsqWnO98GJGUGeL4Vh0LO9zAL4GIt5N3XVjPNP
	 zGrFCxDyDWzag9yWtmha1+4zfV+/+J8KyI+2VEWMcE01f0RWWpy0dWQ95KiLdHx+jww6D
	 1c9ZkEl1cCWXd0845olDp++rRLtALckg5fFHCCpmoJ5+dl2o8RonRqitkD+su7WE2NsgF
	 2YbwyrEg3aszTaHxhq21r8a6upNAE2HMBU7b59N+A3YN9DM602Fu2JBFgjK2BB/tRm0Ul
	 xLkDTieUTuSH+PRISM425ONUz3Co65ye5ADgkk/yIaCFJh6/0JJfTRBIJnYK2FbkInQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794088412;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8ySQyWpzVUQwlPK0mIdtUAo/slZnp9cE5tLXFw3xRes=;
	b=3E/BOgpOzWC+U+qkivXGb2UV88Wa9NG50svo4I8BtwGjVP9LY+OMyld/I+kcJvgDaXgs
	 Mz3dUTb+XggVCg6uxxxakaI2PciHy1806t1Dr+PCZr5i1Na9YgvAw2d4Z9eCWRj4mZpja
	 PvG0TnexeBoUZgoLRNC9AX5BM7rH0qUza7+BN/6PWun5S4GBzNAQVkNdA8iamclgbKfAH
	 SxOLC16353aLo0F2vOX/sLysYPzyuvCMOCdaCoMgmH6NVt2D0vHiZEvcNVNFNu4c4kbUa
	 gdS+Z0AiY1KIMoMYEiAjH6blnydKsUBGLaPmKxEh48jvuVFY/BAjkRiOneNstPtPq/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SIop3eDl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71073606A32D
	for <damon@lists.linux.dev>; Sat,  7 Nov 2026 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SIop3eDl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327581F0089F;
	Sat,  7 Nov 2026 21:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794088412;
	bh=8ySQyWpzVUQwlPK0mIdtUAo/slZnp9cE5tLXFw3xRes=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SIop3eDlbHiE4xK7e3Bh2YpUI8aRYtdFD6wP43zdNtmf+eISb7qk49hY5slMHplN0
	 SUQJV0XlExofdGeu1ayI3scIe6gvpyh7lCvQk17h217ugFJ3TsC+s6vnnhU9UT1IOQ
	 gc1MsrA8eTYduMAlDok+1ac+CRIksLfaRH0byRdtvIns3SoFH8a85prlVkIlyeq0pp
	 elUNooxCOS78yKq10XdwePVJP1SRUb57/UPAjPXUPCJLXTYxP1hquP+iVJu0k5ZuZz
	 vGYjHtPBsqhQPfSb8sbPaeQ1OtZeUJXx4TMRF0Fc16c/n8WRoZCrjaWwfcOJNR1n/G
	 rAdHQfIAlSAzQ==
Message-ID: <sashiko-outbox-203348@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.12.y 4/5] mm/damon/core: filter out damos address
 filter-split failed region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261107214525.304638-5-sj@kernel.org>
References: <20261107214525.304638-1-sj@kernel.org>
 <20261107214525.304638-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 21:53:31 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> When an address type DAMOS filter is configured, DAMOS tries to split the
> region for the filter range, and apply DAMOS action to the filter-in
> region.  The split operation (damon_split_region_at()) could fail from
> allocation failure under extreme memory pressure.  In the case, DAMOS
> action could be applied more or less than expected, ignoring the address
> filter.
>=20
> The issue only rarely happens under extreme memory pressure.  No crash or
> leak happens.  Occasionally not applying the action to a few regions
> shouldn't be a real problem.  But applying the action to a region that the
> user has excluded via address filter could be a surprise depending on the
> use case.  It is only theoretical.  No such real case is found yet.
>=20
> Filter out the entire region if the split is failed.  Update
> damos_filter_match() signature to receive the error from split.  Also
> update kunit tests for the updated signature.
>=20
> The issue was discovered [1] by sashiko.
>=20
> Link: https://lore.kernel.org/20261020004119.106690-1-sj@kernel.org
> Link: https://lore.kernel.org/20260801203121.117449-1-sj@kernel.org [1]
> Fixes: ab9bda001b68 ("mm/damon/core: introduce address range type damos f=
ilter")
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: <stable@vger.kernel.org> # 6.6.x
> (cherry picked from commit bbeec2d8324d7aac438bb12dd2d22b184e0a8d43)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107214525.3046=
38-1-sj@kernel.org?part=3D4

