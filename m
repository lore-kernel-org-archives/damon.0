Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794088174;
	b=yB7kDVEjiV1tWzQRpXhHt+QrdGDubZZlee1ppvvOvm4joRhIiFgkLJVY6ipoT55ebhN8
	 tGMuLOddfbZ140NbSTv5yuo/1w/OUG/CdKtXPbVVBO5GqdGqXITJKR5DfKZ/q8lYMZCNN
	 nN9QpoE/HEnFZDfBmW6jIQDMF2hwlfPwZLtuFQbHw5EfcXs4AF3WezBh+Qsvh5hqiaR3/
	 7i/nRlk4pxH+cH6WMlXq4C8ixpm3MSh3H1PUeE+XwRVS9zeMo2y78UEFFFyCJ5sDaJ9cY
	 AkUI6m9jOMxv5HrD/t8q4Db4/9L7oJq/Q0g/qlGrE7Vx114cwrFnc4Qb74YCAYwF4LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794088174;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MZslxdqopPBAiWcZm5zOrWMKUBuG9UUIkkLg6NCqOTI=;
	b=RC6ooy3Sc0eLLv0w4RivwvieSNiZV7XYtY5/70/9yDgj3nrdvawBLASxnuz3stZKPrZQ
	 8B2qhDz2rMtHQ07xUl+w7VdeJsEQSxehxdrCDRXu1wqtkBN6auo8j7c1yrQEaRkCNMMDm
	 k+y0fjZsPvnSlXMS9+IFSoLPeNwAZ911XJCOmCu4uCKkTF31Og0YSqDd1UAdTpHhUq9pD
	 TgAtyv16XfEFOCQkBCU4fBcNyh/TPQT56j6cAK9sHe8V6TZayHkCoSPWPL2qvzSd/gIhm
	 Ry1axL36whQ5Xlf5+HethcsOPt/Mfjag2USSxIX7Qvlkxdi7WDH0begxVicfb/66bag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QlnZhkS9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D569606A326
	for <damon@lists.linux.dev>; Sat,  7 Nov 2026 21:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QlnZhkS9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBFB1F0089F;
	Sat,  7 Nov 2026 21:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794088173;
	bh=MZslxdqopPBAiWcZm5zOrWMKUBuG9UUIkkLg6NCqOTI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QlnZhkS9ywa4MbUtZAR5HC5g3ksLlMQQfV9yi+wG6c1TBu0KixEXcIl0JwbIqJFoD
	 PY3zndiAcnc8w8RQE+5AZ2p7vdRRsrM+Vul0951Y72Z14xTPdw5cLVYJ0BzELOJ+2n
	 rpBo9BtYRJNS12XuvYiArsRvG5EqkZrymzfFyXR4+y3qe7Uy44J4DnRhXK7rmetLUH
	 eSn/sjvw/zZvUFrt4QuuehQk/EGeJPhXK+uiz5cRI6cAjQ0srNZ3/nymzAi+L07Izd
	 JsKEbEAU4RIwEeATipPtUs9JE435qwfsIfCaBcdaAp/o+Pnq3o9fHMr5eaLA5vkSuF
	 rXiJfg+YZpvqg==
Message-ID: <sashiko-outbox-203345@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.12.y 2/5] mm/damon/paddr: respect folio end for
 DAMOS actions except STAT
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261107214525.304638-3-sj@kernel.org>
References: <20261107214525.304638-1-sj@kernel.org>
 <20261107214525.304638-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 21:49:32 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> A few functions for applying DAMOS actions including pageout, lru_[de]prio
> and migrate_{hot,cold} in DAMON physical address space operation set
> (paddr) collect folios of the given region by getting the folios of
> region-internal addresses.  Then, those functions apply the action to the
> collected folios at once.  The collection starts from the region start
> address and advances the address by the size of the folio of the address
> until it goes out of the region.  If the start address is in the middle of
> a large folio, and if the next folios are small, some of the next folios
> could be skipped.  Fix the issue by advancing the address to exactly the
> start address of the next folio.
>=20
> The user impact is that DAMOS action is applied to less than expected
> amount of memory.  Given the best effort nature of DAMON, it is no big
> problem, but it is clearly a bug that is better to be fixed.
>=20
> The issue was discovered [1] by Sashiko.
>=20
> Link: https://lore.kernel.org/20260901131850.98037-4-sj@kernel.org
> Link: https://lore.kernel.org/20260517234112.89245-1-sj@kernel.org [1]
> Fixes: 3a06696305e7 ("mm/damon/ops: have damon_get_folio return folio eve=
n for tail pages")
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107214525.3046=
38-1-sj@kernel.org?part=3D2

