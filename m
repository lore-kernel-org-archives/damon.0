Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1512F3C18
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270080; cv=none; b=mFyyHQAqmNw//lJ1WzE1Ie2DIS4rYfOz+yKa0/1FsxdBPA78yoGHVKdOO3cSQKC4UMhzL5yE6+OORPFomBpmRZBOfcZpAaiI8XCYRu/EZ9zr28OO3jOexWuyK9lI1LlWK+1N9LAIfYyajUgDOVgn3jake068WrrMF0S2W7Xma88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270080; c=relaxed/simple;
	bh=mSJUx2Iz/LQi2JiHikRe+0HfHmPGgvp9bkNuruJWxv4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GfK2RL3srB+4aWi5hnl3jdEbKnaYac8yV1XVvWWJHnWyMRb0csZgZThIxiJn0p7D2rlEfpXi/Gqk4TOS44ruSg5MuHSuc+akBKTJRyMLQKWU5gj49Cw16t5JXsMf1yeaioKgx/F56DRsNSiEVNGuBw89bZ/wQ+XiQ5a8xJGeQxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHbJzusM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHbJzusM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F41A1F000E9;
	Tue,  1 Sep 2026 13:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788270079;
	bh=cROucQ/24xb6eRmLmvAjax8mm590VDSMmdfwrsA2neg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aHbJzusMDovIUUJMtQdwpGx4z6MK6NDtqQcYTYwsxf0IcXDgLT/Hv1Oc6AySoCjNE
	 RX+T3+4uD/ozzRJPmZvENoNF0Ops4T9eCU8PQ5jY5xImi25lqH/9euScLwtIBOgPct
	 hU+69Cl/GSC/LHaVvc28dBcA28WJNBpFVAswXK52b0f00kDApCI5UUcJBB7zIBKUgk
	 mzJ25YF7jVaV9YetasMV6FmPCMG2usEva9IWiTYmKniWkSUNbwMmH/nTw5pi8zxyqz
	 rUXgcuqOt6bxk9l3wBQ0ethJczO8qFjUhicEkPoXjR3kjWWJ3bvTDZLMHEGg/WkTU7
	 kuVo8iEzAItZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] mm/damon/core: handle extreme memory state in
 damon_get_node_mem_bp()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901131326.97615-6-sj@kernel.org>
References: <20260901131326.97615-1-sj@kernel.org>
 <20260901131326.97615-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:41:18 +0000
Message-Id: <20260901134119.4F41A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> In an extreme and unlikely situation, si_meminfo_node() might let the
> caller show zero total ram.  That could cause a divide by zero in
> damon_get_node_mem_bp().  It could also show free memory larger than the
> total memory.  This could cause underflow and make DAMOS temporarily
> make unexpected behavior.  Thanks to safety guards in the auto-tuning
> feedback loop, that should not be a real problem, though.  Fix the
> problems by respectively returning 100% and 0% for used and free memory
> queries in the corner cases.
>=20
> The issue was discovered [1] by Sashiko.
>=20
> [1] https://lore.kernel.org/20260328133216.9697-1-sj@kernel.org
>=20
> Fixes: 0e1c773b501f ("mm/damon/core: introduce damos quota goal metrics f=
or memory node utilization")
> Cc: <stable@vger.kernel.org> # 6.16.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901131326.9761=
5-1-sj@kernel.org?part=3D5

