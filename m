Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045463A8755
	for <damon@lists.linux.dev>; Thu, 25 Jun 2026 14:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397782; cv=none; b=Hx0/cM2xqJShnaXypekLD/hTbSuc75yk6FK831UjpMMZqXMSNBZWKT3iTu5kv/hWFhZTjoibY9X5nFgtgKNWgH+/KyttLawJlsN35aJiWJiFB7I27TDpsHt2bWs5d80azTx6d16xfWY5S3L0nn+fWOUoCz4vYw7H83RUJiR6V8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397782; c=relaxed/simple;
	bh=O9H1I+aT4kKjSZ7cWyL9vndLD7qi36LCUk4c+2V2Ihs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AT+MxQilOrpzJl5SGR4NCYeC6QB8aaNDdwDYZ06o45vx6JvlItdh8q9hAhVhrvQulAg9VtfDyGem0RRblTmt77UdR9vF9iYswn+z2cWqDVoDYiOJUEB5vfcMQY/OP+njmN6bEq1dXCpi/AMYPRJ/mgshwJNl8dX5BfPxS6djzOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhEGJjbC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhEGJjbC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903F91F000E9;
	Thu, 25 Jun 2026 14:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782397776;
	bh=qo3bnOF4g3AiGUkoJfQ8bapi+bvmlgYBR1j8GAP5neo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UhEGJjbChUxznldq3yU332voz1A/2at6TWzgzUkl8rx/wEZvkQiTSU82WJ2ZHAi0B
	 X2d9ycxo5Qn0zUF/Vs8DXt4pEezMw3BO8yMPoppQpwI5viI4yiaLypum6x1s8z1rfk
	 vsuMahsZjh0qnlaXndzbLl02H9CnvzJFDiC7z/Ly/HOt+wHtj/h/fW3DCiyTw7THxn
	 cDi531gpjpXKgh7rroE/StwEhNsw7tFJn1z1OcwxwRQqwXrMICflAJW792ptm8apbB
	 z3LqJ62cZ9pLtKsOVPbUzQomme/NTnNQE7BV/9LYVAZY3ACfbUMTLjapXp8zU/Vz3b
	 d+gGeKL9dZHMg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 01/11] Docs/mm/damon/design: update for
 DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260625142357.103500-2-sj@kernel.org>
References: <20260625142357.103500-1-sj@kernel.org>
 <20260625142357.103500-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 14:29:36 +0000
Message-Id: <20260625142936.903F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Malformed reStructuredText inline literal syntax introduced for `no=
de_memcg_used_bp` which will cause a Sphinx build warning.
--

commit a9ffce1612fd4b4c8226cfb7a55a1781daa5364d
Author: SeongJae Park <sj@kernel.org>

Docs/mm/damon/design: update for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP

This commit updates the DAMON design document to include the
node_eligible_mem_bp goal metric, which was introduced earlier but
omitted from the design documentation.

> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/d=
esign.rst
> index 2da7ca0d3d17a..9dbace087a329 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -686,9 +686,11 @@ mechanism tries to make ``current_value`` of ``targe=
t_metric`` be same to

[ ... ]

> -``nid`` is optionally required for only ``node_mem_used_bp``,
> -``node_mem_free_bp``, ``node_memcg_used_bp`` and ``node_memcg_free_bp`` =
to
> +``nid`` is optionally required for ``node_mem_used_bp``, ``node_mem_free=
_bp``,
> +``node_memcg_used_bp`,` ``node_memcg_free_bp`` and ``node_eligible_mem_b=
p`` to

[Severity: Low]
Does this malformed reStructuredText inline literal syntax cause a Sphinx b=
uild
warning?

It appears the backticks around node_memcg_used_bp are unbalanced due to a
misplaced backtick before the comma.

>  point the specific NUMA node.
> =20
>  ``path`` is optionally required for only ``node_memcg_used_bp`` and

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625142357.1035=
00-1-sj@kernel.org?part=3D1
