Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D569F233923
	for <damon@lists.linux.dev>; Tue, 18 Aug 2026 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787034680; cv=none; b=p6PtgTi531cOLCZtGjeHFFHVTRMhUzNMR1DpIBbwZdxH2qVL1ck5Zn1phLhO/Dccrw7b+ejlXvav2JlK0iKFbDDgzaV+eG+GRpcYfMINeB9ZN2OOTILwTNNwrJ//dJ+sJaxNCGJy74d+On+qua/9uSyZWsZbxowffZX5kHtSo0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787034680; c=relaxed/simple;
	bh=EsKGFjtvT+SUL2EO96hiGADR1oILtAeLDy7N4dVN/dw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WQIxcasz6AOtJQ+qKs1pvNEC7NHnBuuXDllI797c+nv2xvUunrE3aLTSWXZYuyMei/v/7cWcWF2eTFbGZ9nKBclqspy1fHD3tUkkPdjPgZ5DUo2i33Q2yUF6do51s/9RhJH6k7xN2OTQnv0yvCRkP0yDX0ABOFnI3TpqX8PdLhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAtLFlT2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAtLFlT2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627141F000E9;
	Tue, 18 Aug 2026 06:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787034678;
	bh=teDrpxx6LJX+yoE+GhEojJmgElRxZ8g/rHoAvp4/Zyk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KAtLFlT2o6WI0gNqcUUI+CrESfxAdb4mm3+fiaYTz5btUrShIF7hEpcKDUKMBI0bn
	 TpYnxI0KD8w0R9xeMCcS/mLkyoonLYjj6xk8FuWU5UXUY14icT81jxgt6OvJP75Xem
	 u+U9pfRHrSjyZSWd74UcUx5BFXqeKhI67Y/D7VtrmwGsyd3IQKcAcsq6HC3JrUsiY5
	 TiuIeTWlTVN/AT2T2oqE/GZKo9yquV8AC5UJxq4iANfiDwh1J9BY1ydKpfW44n6q7T
	 jaAoDW8QR1ISNB7EaLG6GCjDtjitbXG6VPN2uLGXMePvXeRwdxP124COgDugkl5O8j
	 t6az+mmhZ8weg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] mm/damon/ops-common: putback folios on invalid
 migrate nid
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260818062518.91960-1-sj@kernel.org>
References: <2026081721-strainer-detract-6eed@gregkh>
 <20260818062518.91960-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 06:31:17 +0000
Message-Id: <20260818063118.627141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: liyouhong <liyouhong@kylinos.cn>
>=20
> damon_pa_migrate() and damos_va_migrate() isolate folios into a local list
> and then call damon_migrate_pages().  When target_nid is invalid
> (including the scheme default NUMA_NO_NODE / -1), damon_migrate_pages()
> returns early without putting the folios back to the LRU.
>=20
> Callers then discard the list head while those folios remain isolated with
> an extra reference taken by folio_isolate_lru().  The pages stay off the
> LRU for as long as the mapping exists (anon active+inactive counts drop
> while RSS does not), and the leftover references can pin the pages after
> the mapping is gone.
>=20
> Put the folios back on the invalid-nid path so ignored migration requests
> still return them to the LRU.
>=20
> Link: https://lore.kernel.org/20260726014815.1280757-1-dayou5941@163.com
> Fixes: 7e6c3130690a ("mm/damon/ops-common: ignore migration request to in=
valid nodes")
> Assisted-by: Cursor:grok-4.5
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: liyouhong <liyouhong@kylinos.cn>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 5deb65c34e682e7c5f5df417a70e223e8fcc5f5a)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818062518.9196=
0-1-sj@kernel.org?part=3D1

