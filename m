Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793553645;
	b=rjxNMkZkivxK1vGRBUwWgMU2mGl30O7cw5+W4mciuUvg/10uUGMnBcV5/OSjrUX29qHn
	 /g9Fv48XHqyAhynCbLQO+vjAqDwOp1MF9tJdOTfUuzSqQtXBbYkUSGHqr5oyXnyfgVwax
	 XW+tW4yANNhwJpc2YW6Km8aovSb+o3bqcoUu4KBE3330ov9HAEi2hMlaTqP2Dpd0rSS0Q
	 jQZMX7xNRSvS+NW/hP3sZtug0iRRj+aafeA0ZBsIEy16scnCFp2Bbdj+Ps/qX+FQn5kM4
	 YndyDUFEDgK+0te9M0q+rYW0kPxMJO6Ue333+W7lCj/hi+jcrghO9gSnVJhQufDDm6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793553645;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q5zNVXdZQeuxmOn9a/a6AhqjI1cyyUu/Pybufe0UgsU=;
	b=DuoEmzv/7iUsamDyhCB/pwjh+7PCos18/AN+Z/iETy/qLxTCpHBPbqv/WFbAOQYkpcG1
	 9AllBloUHm2jxXKep3GByMdp/IowVDzNFnL6rXLX7Q7fXsrZILO5V0HXIm24+X5MnTt6/
	 aeIf8s88/Bix4qy55zXwo08XDF8kIT0EzynTyNV/l9voqutaBgp7uZNHcg7jqDCaJPrIg
	 muJIYnzMxSV4w3DF6qvm4XI5RUZL/9FVnkm+Lr014uMlRRAllOpt82aY0w+4rAwjNahg7
	 Z6NV6NIuJX4Ckynqj04eLYZ8tqH497Niz1gHyXSLMmDs5bU4ccrmyCT67X96jYnyV2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OxGxrlCy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78B7606A324
	for <damon@lists.linux.dev>; Sun,  1 Nov 2026 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OxGxrlCy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3241F000C1;
	Sun,  1 Nov 2026 17:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793553644;
	bh=Q5zNVXdZQeuxmOn9a/a6AhqjI1cyyUu/Pybufe0UgsU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OxGxrlCyfz40T61O4UEZ9aqBstEnK1sV77j5h72HqmX6fmD7Ywe1IvFxflfC8WEMm
	 U0Vvw5wxeZSVjWGf9yRvB9lCUu7bv1SEIz8AimIyA6ZomarF3T+HpNJUjljr/Mjqmp
	 zxJHXtODXwPlUtyr7IWf3k1wgCHohtidfCiTexdQ3U46HHganHxDU+0XQ+osV6QGNk
	 +2xGjnQXRb/zdjnst1Ez4kGMcngtuAgbT8Ec7S89OG3dhUGNCNVlLQC/ZF26Sq0rVB
	 sc5pbceqJ4Rer4fiLaxcteySB0MgXJZ2Hy0hb0O5LW8I+UVihjVSlWfWL/wP1Yw5Km
	 b2kwuOk5lxfPg==
Message-ID: <sashiko-outbox-192522@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/6] mm/damon/vaddr: advance migration attempt in
 folio level for filter out
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261101171630.81477-2-sj@kernel.org>
References: <20261101171630.81477-1-sj@kernel.org>
 <20261101171630.81477-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 17:20:44 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damos_va_migrate_pmd_entry() finds folios to migrate under the given
> pmd, using a loop for the pmd address range.  The loop advances in page
> size if a given folio is excluded by DAMOS ops filters.  DAMOS ops
> filters work in folio granularity.  Hence it is more efficient and makes
> sense to advance in the folio size.
>=20
> Advance the loop in folio size for the ops filter out decision.  For
> that, do the folio size based loop advancement offset update before
> applying DAMOS ops filters.
>=20
> Closes: https://sashiko.dev/#/bug/linux-67c34df7-6dfb-4e18-9ce0-0d26915e5=
785
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101171630.8147=
7-1-sj@kernel.org?part=3D1

