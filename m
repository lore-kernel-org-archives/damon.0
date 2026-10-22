Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792681771;
	b=VPaLw8spPN5t1+AhNVJjdzZ+BPxgHXUDgz6m5/6aF23Mg5wmh0wGzOh0r9OJhDaBS/E+
	 AskQfUNWPJHzCmEGe4tLcFZgHFJlzLCT/fp1NzpNNADhJuWsyRVXWxUExW4ZJK1i1UE5/
	 rBqiumeaQhAwz3poDPd2lEdu/G6Z3KpeTGXemsEoq+zppsPFp0WIozyPqkhYW4UML/1Cx
	 ETraht5xYywTBCLEMsOSlS/7+ykOyvlTDbqZKJHzAl1RbqzoV2FXJD3c1IEJzGS1733z0
	 0Ehbxe/lKuZwZj+BwiX4UiywsrdLuUEIDPtz1aF6fe8yaIE/BVPhGr/5OfMU832mZ0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792681771;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A9yApuUc/fp3GCSPhBoVPjkYa8KVBvm9CItdC4Wahls=;
	b=MVGPu76pYLJ5brCg07MV5RGeQcymXrliydg/c0gd9oK9ck1js56OUCFh35P7gQikTa60
	 NwC1V5w6LFoQ0nl4drnBBFhNNew9yk6AfQdql7AWaQl+l+nbL8Me3XxyrXjIXAavHXmUc
	 CR1bh7FEWZdhfPAL49baOFc6pYfBlW9jIXvQd+s7cNLdGOFQUgjwh68f1VBjaD68cQ5Mu
	 4A549rQrL3CU8wUDBO/Sd9NwBJNO7YfOaIgl6QIZhb/4kdNjdfqYLA5BJKNiga6Prdwos
	 ifkCySSYTvae9DfTB/MzqAnDOO33we5GEtc4GDnboVc+95aZTW9EqxVQHNeoojoTjmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=atP5304f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161D360A3809
	for <damon@lists.linux.dev>; Thu, 22 Oct 2026 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=atP5304f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CA41F01825;
	Thu, 22 Oct 2026 15:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792681770;
	bh=A9yApuUc/fp3GCSPhBoVPjkYa8KVBvm9CItdC4Wahls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=atP5304fpl/Yrhwyb5L8UsQr8hiLVeVSwvwMS6bZtomOCPdB+ESsvBGTdbnK55R3J
	 Bcn1YvTJQPHgABPpwRCQgibDm1mEZK9e8HNXWZsa6zLb6AgMQXXXGbUesfV0IDCQTj
	 PqgnONk1zNpxI+vQzuVBO3NBmUg1naUWd1byspOj+W6NIn65RuR0m80I/AICf3NKH/
	 1Sp4e11zAxifP3Ea9p6/Q1o/Sh9cmBjGgxHJBKx1t6Pd/TD0MxXaAuCxcXmkbS2qXE
	 H8S3BPP60iDADoqSr1E7+3CphDlB8b6Xe+YJBSLzDRKexSvzSiYPEkdK8RuajcEECR
	 EcFFoWzvyESeA==
Message-ID: <sashiko-outbox-181671@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon: align MMU notifier range when clearing PMD
 young bit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aveline Noir" <jm5905938@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <179267916870.2.5637290691657871645.damon-pmd-align-draft@gmail.com>
References: <179267916870.2.5637290691657871645.damon-pmd-align-draft@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 15:09:29 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damon_pmdp_mkold() clears the young bit of a PMD but notifies
> [addr, addr + HPAGE_PMD_SIZE), where addr can be an unaligned sampling
> address. This can miss part of the sampled huge page and age secondary
> mappings in the next one.
>=20
> Align addr to HPAGE_PMD_MASK so both operations cover the same huge page.
>=20
> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memo=
ry address spaces")
> Link: https://lore.kernel.org/r/20261021-damon-align-pte-young-notifier-v=
1-1-d0365ac45b66@gentwo.org/
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179267916870.2.5637=
290691657871645.damon-pmd-align-draft@gmail.com?part=3D1

