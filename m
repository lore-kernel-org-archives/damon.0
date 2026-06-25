Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DE721773D
	for <damon@lists.linux.dev>; Thu, 25 Jun 2026 05:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364432; cv=none; b=qYVsLtjEKIiE2m2tBlKKttcr3/s5nJELOWPc5f4/K/QGiQjI3OemRQFtP8JxEWzUHJpVzDpHOQ/mLp3PcM5Qh0y8mz8fx9YZ0+dpOCyqh1Kie7VwExe1lR/y0dvDDisfUpPNMJVtrEAJQWAtHbRfoAlNElFoz7McY33EhJEwsTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364432; c=relaxed/simple;
	bh=huUEHgL/JqkjIMZKbhn1gbkt0tdh6AEfPDymqvmKbXw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GjbxYmvtrax09a7idxO/1NGmEGSz4dBaeZkpBcZYTs0ID8oH112YmSEAo5OLKh57c1UAWbNZkoILrNxIkaPcLqhbpImc79MvBZ2HR7zxIjg0rCi0lTjc5xZKg0CuOafuiiPO9yHTjov2S+Druq/zlIrw/ubGGypKfYfsC+yytmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eT9Ph/V5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eT9Ph/V5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419A51F000E9;
	Thu, 25 Jun 2026 05:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782364431;
	bh=GjFYOp27KwRQ1B3dWIFeUOVJ4HwDEEIVVy1EjY2dXlc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eT9Ph/V5BGAtDesADaNbsBeupp0KKccTEFX+W2b97PEdRB78aqEzEFNzAKVJkt49X
	 fYjKX7DGJWdwPIWVgcy5dlm+jCTU2o2ast1SftluVDIZEdQnb7YSOtyDAoLBjNCl5u
	 JOtvGBf1jivROOKOg+A/1lLdgGQeD1dGIhtaEawa0UBeXhpPamY26GEbJeyQfxcFSr
	 fBf1mQTQwKGzk5cg2xE2O4UEy5nTYNyu91OvhubGfk239KYDg6lfFUiO+sOk2HDbuE
	 TY9nblk1xMQ6FvqGaWoBc7DsksziBgzaDQYlysrwaVYnywS9JS2P+roRdsB/U/wQuM
	 4i+6NKo7XmJxw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 01/11] Docs/mm/damon/design: update for
 DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260625050756.91115-2-sj@kernel.org>
References: <20260625050756.91115-1-sj@kernel.org>
 <20260625050756.91115-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 05:13:50 +0000
Message-Id: <20260625051351.419A51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces an internal inconsistency in the design docume=
nt by documenting the `node_eligible_mem_bp` metric but failing to update t=
he adjacent sentence that lists which metrics require the `nid` parameter.
--

commit 77a1ee91d398d22fd9a42b16bbf085e55f72a94a
Author: SeongJae Park <sj@kernel.org>
Docs/mm/damon/design: update for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP

This commit updates the DAMON design document to include the
node_eligible_mem_bp goal metric that was introduced in an earlier commit.

> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/d=
esign.rst
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -686,6 +686,8 @@ mechanism tries to make ``current_value`` of ``target=
_metric`` be same to
>    (1/10,000).
>  - ``inactive_mem_bp``: Inactive to active + inactive (LRU) memory size r=
atio in
>    bp (1/10,000).
> +- ``node_eligible_mem_bp``: Scheme target access pattern-eligible memory=
 ratio
> +  of a node in bp (1/10,000).
> =20
>  ``nid`` is optionally required for only ``node_mem_used_bp``,
>  ``node_mem_free_bp``, ``node_memcg_used_bp`` and ``node_memcg_free_bp`` =
to

[Severity: Low]
Since node_eligible_mem_bp is a node-specific metric, should it also be
added to this list of metrics that optionally require nid? As currently
written, the use of the word "only" implies that node_eligible_mem_bp does
not use an nid parameter, which could be misleading for users trying to
configure this metric.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625050756.9111=
5-1-sj@kernel.org?part=3D1
