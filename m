Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC8F3BB100
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200611; cv=none; b=Ok/oby7V+b2zmGW6T1DmPlqgwkn8Yv2LDA3QbZZOt9wf/H9Y7ts+so8a1Rt/1g26RZ8SMTf4DxUyoS72hnGbz4SJ3vu15UEkFrhts4vd5m+yHtu6Y5XSsRAyHikEKlg0ImbsBkG4YIZrODddnvBgMDxXdrj71SQaQwms3InB5Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200611; c=relaxed/simple;
	bh=kfK8qPwvx4P+eyQtXm6rPiP+Z4ls5jYVC7rNTNXEqo0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lQd14h6uKM06Khx2xy/xJOPQFzdgwftqzKk0D4j9N9Fi6rJrRj+XrhztgEV1sS1K5AGpFNv6QJrNxnGYQ6XEAKTUIr8EBOWaMn4IfvpsDMXDR4n62Mj3dYgBxmFylNC58VtUOu4ljuqaovy9+OFRrgDhgekQWpJUvwtqzC+ANSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZqj2oOb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZqj2oOb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB5D1F000E9;
	Mon, 31 Aug 2026 18:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788200610;
	bh=oz8Ny/dgXWaTa2+JizCFZTSIO8nb4Jbqr3zLL4aEgT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YZqj2oObHEbbRbL5qlzhKnmiNNfRe2YtzgI/csW79ngsL+vctPh2LPAJVeSmLcVPy
	 yKwsrw2Y6rno98H/l1dhHtZOXbPdOiT6jBDZnqS1dvDdAjapstFKPkvDP92D05zlXN
	 4WaCU1yGUCH2Y2dOE3zms0WLmQ1ttL5Kol82/vxIJSEy2+5eyN5UEST9/Msx/v4xjT
	 ojH7tboiKgKWEvO/iiKzk15FVjVT2Z4NSSPTRYKy1IQUaCh4ZsBWLB43FFhW1caDHY
	 +iXL4JuBjB1le1HstJiPncUvmpMDkwE6Wb4UTiKLeaxMjO4jqBhI4qKkRnBnrZjD5T
	 LfJ4XmB7YgnXA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 5/8] mm/damon/vaddr: respect folio end for
 DAMOS_MIGRATE_{HOT,COLD}
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831140254.72004-6-sj@kernel.org>
References: <20260831140254.72004-1-sj@kernel.org>
 <20260831140254.72004-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:23:29 +0000
Message-Id: <20260831182330.0EB5D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> For applying DAMOS_MIGRATE_{HOT,COLD} actions to a region, DAMON virtual
> address space operation set (vaddr) calls walk_page_range[_vma]() for
> the region.  The pmd walk entry function, namely
> damon_va_migrate_pmd_entry(), collects folios of addresses of the region
> in the pmd.  It starts from the walking address and advances the address
> by the size of the folio of the address until it goes out of the pmd or
> the region.
>=20
> Let's suppose it is for the first pmd of the region, and the region
> start address is in the middle of a large folio.  Also, the next folios
> are small.  Then, some of the next folios could be skipped.  Fix the
> issue by advancing the address to exactly the start address of the next
> folio.
>=20
> The user impact is that DAMOS action is applied to less than expected
> amount of memory.  Given the best effort nature of DAMON, it is no big
> problem, but it is clearly a bug that is better to be fixed.
>=20
> The issue was discovered [1] by Sashiko.
>=20
> [1] https://lore.kernel.org/20260514015053.149396-1-sj@kernel.org
>=20
> Fixes: 09efc56a3b1c ("mm/damon/vaddr: consistently use only pmd_entry for=
 damos_migrate")
> Cc: <stable@vger.kernel.org> # 6.19.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831140254.7200=
4-1-sj@kernel.org?part=3D5

