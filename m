Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E7F2882AB;
	Sat,  3 Oct 2026 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791059841; cv=none; b=NHYGIkAndLM97vlEXBgLBfYXoq1UvpBY6lXIIoys0g4NDL+xIT9EOgOFz+wy0d6hmS0/FfKdBvw0Lxh3FT7BH1KYkfMOUdSNdJuVDzaOaTrZNt/OlG7fyfx6N2bFL4nmbU1r/+BpJ5x9yPPHjctx10CeYQg1eUxR1G+bogSOVQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791059841; c=relaxed/simple;
	bh=Q4zXgaN1W621F/wREqZrOC503LneQ5G8e93IlHF0weM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YRBcWxPOPj3tBhXjG/4Qk5NPMDL7fCGtOs0V3YDocPZBcYf8d1n6qUguX3qBcakQ8Hsh9rK4aNLA9ENpuw2nKUWfwnHD9365t27BHcKHvE9DgCYGQi+PUTQJx/hR7bZmgseGIHlqWiNcCqT0pQDawX0FsbzsMNQcwCwsF3mCNHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9PaxJla; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9PaxJla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B5B1F0089B;
	Sat,  3 Oct 2026 20:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791059839;
	bh=tLM/2VtROjUXOH4IDRfFuMdFs5DedyiohZR8Hz2jWCM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V9PaxJlaJlE4xK3rJMJqBzowRxIW1w0DjQmVge4siHFMDlxjtPHPIGIchlYURRV96
	 vD/r9RdZIFbmBHqrg3G0CXCl+Nxyb0C69L1cSUsDOHjxMhRRhTZyw63Yzul8A6yuDT
	 QSpN1mOtXadxJcdZzg87+AO+gz7Df2fTVKtLPbc2w0vZrHmckRZMz1YhMEev+JE0Fr
	 ZbCF+uIA54TZgIZBY/r3GejRNSXPghmB2DkSBaDy5a6rV9HxR95dxM2AEaYDdKN/V2
	 J9K9ZHyuIVfZ+B188Z3tvFCrHq2s5RgRdUCtDJmp1xLy1SCBybIJQxJSXf3uNRsBTu
	 naQ1GhAWbIroQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon: add damos_node_eligible_mem_bp tracepoint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261003202727.3673-1-ravis.opensrc@gmail.com>
References: <20261003202727.3673-1-ravis.opensrc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 20:37:18 +0000
Message-Id: <20261003203719.66B5B1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Add a tracepoint for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP quota goal
> evaluation.  The tracepoint fires once per quota-score computation when
> the goal metric is DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP, exposing
> context_idx, scheme_idx, nid, target_value, and current_value.
> current_value is reported as the quota tuning sees it, after the goal's
> complement setting is applied.
>=20
> The DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP metric expresses node memory
> occupancy as basis points of eligible bytes.  This information is not
> exposed through any existing external interface (perf stat, /proc, or
> sysfs), so the tracepoint is the only way for userspace to observe the
> target and current eligible-memory basis point values at quota-scoring
> time.
>=20
> Link: https://lore.kernel.org/linux-mm/20260428030520.701-1-ravis.opensrc=
@gmail.com/
> Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003202727.3673=
-1-ravis.opensrc@gmail.com?part=3D1

