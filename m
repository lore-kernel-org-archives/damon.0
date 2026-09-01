Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6399147CC61
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269270; cv=none; b=LqsOdlGgey1njWdU9HB+N2CtDQ7zToqHTxeZTA51BFeqNHf3BTceWB90M7jM33mP83OmS2MzYWXKol1jXckVKAngVb+41uG19dO+zOY+ktzf922RVxb7pI46ykhh04+Gy8CES8YLSte7e6xCAQnpkI6zp9CmzVPlY+XQzn8LtVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269270; c=relaxed/simple;
	bh=cdx23+DPn5IbPU6AH7X2J7yrY2HqYgKIiRsKY0VVgFk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EvH1ccjqXb0CcVc4HUOCMtPvQ7Oz0m8kG3hNqvt4ut0q/PNmkRJhbzdGuCc3RJSvNN5444mAlw5Lw1StewAkM5/DHoudWoXyF1ou0eGDJUXUMico+8e9XTt0JTStydY0x1teA2+0Ac7xWCTxGNgnuqp3scJ7K+K2WLQ3RJveByI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QogPQ3+J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QogPQ3+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6701F00A3D;
	Tue,  1 Sep 2026 13:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269269;
	bh=hLzhyOHjQgkslb6jM/V3EJb5XO0IdOisPrJ9DXMhvnQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QogPQ3+J6/CbJ0WLcQ+jo+INsrEBuTL/B0TUtkUM5Bjqkqoldr/WOOm9csLzVHe+X
	 G6iXpjDzWTY0ngybNn4CdxjmLbDNJIujoQu6NT+lrgHSFnfoybejQ501PNurFkrioD
	 iPwx0A5bu13eOItWoCbCljrJgxgMxvdFJp7AS9GZc4EQ4sg5ZjJuDmRY0RXku2BoEX
	 PicI/Vfz0TsycNEYHPnufgJ69tucMJoGwERGR0bt3lJxN+lJtfWI1NPf+aQoju/T/V
	 YFAlBXiQUqNNyVsRu5df9aDI5My6Chd2u3y7zmE+I/T5ph9IejKVJKeFngDqTIR9Z0
	 leXAciA5sEbzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] mm/damon/paddr: respect folio end for DAMOS actions
 except STAT
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901131850.98037-4-sj@kernel.org>
References: <20260901131850.98037-1-sj@kernel.org>
 <20260901131850.98037-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:27:48 +0000
Message-Id: <20260901132748.EB6701F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> A few functions for applying DAMOS actions including pageout,
> lru_[de]prio and migrate_{hot,cold} in DAMON physical address space
> operation set (paddr) collect folios of the given region by getting the
> folios of region-internal addresses.  Then, those functions apply the
> action to the collected folios at once.  The collection starts from the
> region start address and advances the address by the size of the folio
> of the address until it goes out of the region.  If the start address is
> in the middle of a large folio, and if the next folios are small, some
> of the next folios could be skipped.  Fix the issue by advancing the
> address to exactly the start address of the next folio.
>=20
> The user impact is that DAMOS action is applied to less than expected
> amount of memory.  Given the best effort nature of DAMON, it is no big
> problem, but it is clearly a bug that is better to be fixed.
>=20
> The issue was discovered [1] by Sashiko.
>=20
> [1] https://lore.kernel.org/20260517234112.89245-1-sj@kernel.org
>=20
> Fixes: 3a06696305e7 ("mm/damon/ops: have damon_get_folio return folio eve=
n for tail pages")
> Cc: <stable@vger.kernel.org> # 6.15.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901131850.9803=
7-1-sj@kernel.org?part=3D3

