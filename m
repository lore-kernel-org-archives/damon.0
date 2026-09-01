Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288E32D7398
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269560; cv=none; b=o5yI0jEjUuK2fEZy9GoxHx0J7yH1O3KLXDJh1SKHhz8iveXOdTLLh+aGDtySd+KuyCAfZw/teVJ5DBpMcxaUnbq0p/leR4Je05qlhrSebldres3NwNbN1YXQIkL12iAlMHwxifgMQVbdHwPBALUJRRIcK1FgJuQJAgw1MpTiDiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269560; c=relaxed/simple;
	bh=yEh/5sEQrm61sJGCl2JE+v4RNVZxmVQVgxyFy7+91+Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OYcki6Cg8fjs3qHQhERAEEipHR4RP7x2Zl65pxOcIh0l3Se3p/zu3uy8HuaboD+mvneBLjL1B9dlzYenlyNADMAHM4glZoADqsgnACca2Fxx7k09xBSHvGPBh59qFsUcdGz+NXuJPGc6cD25OxuNvJRWuz7evXNX1Y3IfoF0cN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYadJe0j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYadJe0j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A1B1F000E9;
	Tue,  1 Sep 2026 13:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269558;
	bh=fwlZrZ/D24jHPFKrwXxH8DnKdz2KyrCYaGMY85Ubaqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hYadJe0j7btZ0DPNdBYz5Q1+AAOw2UJlZKa2Utk2v++Tw7Jub5s4w2arfkZTUumpn
	 X8/K85aac2lLOhksw82yp+Y8AB5f2WxN5136sofXf7RXRSYVnmVrFz8tTT9Irn0A2o
	 KOkXGI9wBoH12w3tloyVLoVmoAQ/scKqIkZix9aBoIjlAhDsWvK0/9gubUZTFAiwxy
	 JGYhPzKf30CDZArGMkbzIyUGhjF8DfNU2F7ZhNGwfRcY1fc//3AuZqHEzkXSWxGpRe
	 XeQznlhLT+4Ri4dGZ2kPE0sjGDENhir75ubzm6Ffey3FhIKrq7V3OolukfgSnbINdK
	 JPR5lIQXZ51jA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] mm/damon/vaddr: respect folio end for
 DAMOS_MIGRATE_{HOT,COLD}
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901131326.97615-5-sj@kernel.org>
References: <20260901131326.97615-1-sj@kernel.org>
 <20260901131326.97615-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:32:38 +0000
Message-Id: <20260901133238.A6A1B1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901131326.9761=
5-1-sj@kernel.org?part=3D4

