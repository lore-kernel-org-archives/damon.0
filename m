Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE8B43B3C6
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269217; cv=none; b=GKwwd289ROHPV2qrj0/cuuipNRFVNcczyuDzzV42ECpBr8HOkTbeDAgiiSu25RXXf9xrcIOHtL2zoMMuIyPB0RDg8y9WuH6QmwWt/zLyeXn+VuFw12eJ7B9XDFqC03ZwNw9pCV621V8yTXkuKrfjaBNmbaSADHuDs1GQ+78sD9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269217; c=relaxed/simple;
	bh=TWZ7a3aBdLuGRv9RR6vQQHcs/Zv31eXabyieJqtDLUQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OI0FdYH95P71d4KKYgMvD4Ds24FdvF+pfV6gp7+cte45j+hExDj6iHaybUT3GS9ihlJP0aa9wroWj4d/4RkRdVsRy8S74hCZKZ8haiQThY8AWyreJ/c0y6zqjIfEwvd4sCUrCvWU9JWux69UYkNg/GSftNgT0eb88LMIzLgLsPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liZV63NH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liZV63NH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A544B1F000E9;
	Tue,  1 Sep 2026 13:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269215;
	bh=oUtq5HxYBp86YbWTRog5lkXKhCLvUZz46rNdoJtdkr8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=liZV63NHcTfIFcybWmE0LZ8W3LxglkrU6B+JJvBS+zfi5QbWM/pOGzCYFZFOQJwc7
	 0+R744cB/TPlcMfJQ0c4XrXKRBquwukHI91JnQU7yFNdz9I2r2l0HVmhrQJznYIxU/
	 2hwWI5S41UwghCf+3DLvbIaK/thfJep50DqSFZJEWltsHHht3z16X6tIv2Lsw4fgq8
	 MnueuDMwa19rfnSPYPdjVsfTXFdDuBT4O3+cigrLW92TnD3WJmEY3VP3jP8FiE4/hr
	 1X4POrek4dVr6zVk8wLYNGjXGOSxu5ES3MiVx5RyoW/Bcq6GNYND5c15Sr6fXyWm58
	 b4PM6Z44WBi+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] mm/damon/vaddr: respect folio end for
 DAMOS_MIGRATE_{HOT,COLD}
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901131850.98037-6-sj@kernel.org>
References: <20260901131850.98037-1-sj@kernel.org>
 <20260901131850.98037-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:26:55 +0000
Message-Id: <20260901132655.A544B1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901131850.9803=
7-1-sj@kernel.org?part=3D5

