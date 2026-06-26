Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998B5381AF
	for <damon@lists.linux.dev>; Fri, 26 Jun 2026 00:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782433490; cv=none; b=qlwI6cLhb9A5QbtCazr7Qj3THLO672ZmG99Wt5QVEGFJUqzhq95aBJXeb/Lp/qMCwsOyKKDQhUgP6cVNmpiqXFHXhu7I3zwIhDRQWF/mo9XmlzkXSbGkeSPd6R4x2qf8nT70h8d32qqWz9o1ZtSAi0DQ9P22LWZYMzTqAwpJha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782433490; c=relaxed/simple;
	bh=AlIPh9YM1J/Wt1sQFXqXOs2tb402CphdBMbAMUXWL5M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r0SztquhEtAev+xtWeacyqsIY45/xu8+R7xq60PvbFL75aXJqU8hXe/T7wbkDsc+gupq8TVyfT25UB+jzzcNYdNdUeFlafw6ZwbYv/9C7XVSpu6nR9i4G5F00G8QRoWWTFOubLuydjwTYFvJfJSChChIlcFjDtaz7LS6I0ZXiLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqXP89DB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqXP89DB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975E21F000E9;
	Fri, 26 Jun 2026 00:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782433488;
	bh=zdlm//3vbp2Z6CaHzXD3uQWwu3l6C3DemNgkVBTrKoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aqXP89DBKfZyllcOtc0aGqfAp4s6RiP24Lc7pDcAROSlp2rzNOgAhCO8jLxRu7HV9
	 W3PHSRp6l4XygKv7AWz5v8Cq4DH/G2w7ZCjZJT91e0TQBOH6qB/jf8ZMI4O73wmjV2
	 WPflA4LrWLeNNr9vqmkmr54OM3NZX+AtHFQAMM3sO2PGQMk0KE32ocTbfIFHSfdNVp
	 Qzmgo7NUFpihYhxTiK1ZrO+Rm97PEdI0uVPaocLvV+gcO8ernoral95IXHUUUDFy2I
	 rwTpLOa7RKGY+DbR/pdl/UOmlrtEmzYdr8DHZNP2CGF8Bg2R8YKS6Pre5qbX8Ff3Gw
	 3Bom4vo4HhxJg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.3 01/11] Docs/mm/damon/design: update for
 DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260626001644.85825-2-sj@kernel.org>
References: <20260626001644.85825-1-sj@kernel.org>
 <20260626001644.85825-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 00:24:48 +0000
Message-Id: <20260626002448.975E21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Truncation of 64-bit phys_addr_t to 32-bit unsigned long in damos_=
get_node_eligible_mem_bp leads to incorrect metric calculation on 32-bit sy=
stems.
--

commit 569eb38d08bfaf4718faa6440d86cad7ba9478b7
Author: SeongJae Park <sj@kernel.org>

Docs/mm/damon/design: update for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP

Commit 9138e27a3bc3 introduced DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP but forgot
updating the DAMON design document for that. This commit updates the
documentation to include the missing metric.

> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/d=
esign.rst
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -686,9 +686,11 @@ mechanism tries to make ``current_value`` of ``targe=
t_metric`` be same to
>    (1/10,000).
>  - ``inactive_mem_bp``: Inactive to active + inactive (LRU) memory size r=
atio in
>    bp (1/10,000).
> +- ``node_eligible_mem_bp``: Scheme target access pattern-eligible memory=
 ratio
> +  of a node in bp (1/10,000).

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this metric,=
 I
noticed a pre-existing issue in its implementation.

In mm/damon/core.c:damos_get_node_eligible_mem_bp(), 64-bit phys_addr_t byte
counts are cast to 32-bit unsigned long before ratio calculation:

	if (!(unsigned long)total_eligible)
		return 0;

	return mult_frac((unsigned long)node_eligible, 10000,
			(unsigned long)total_eligible);

On 32-bit systems with PAE, if the amount of eligible memory exceeds 4GB,
will this truncation cause the metric to calculate completely incorrect rat=
ios
(e.g., reporting > 10000 basis points) or erroneously return 0 due to modulo
arithmetic?

This could cause the DAMOS quota tuner to adjust quotas wrongly, potentially
resulting in extremely aggressive or completely ineffective memory actions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626001644.8582=
5-1-sj@kernel.org?part=3D1
