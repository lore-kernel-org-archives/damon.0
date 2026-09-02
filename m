Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969D5367B65
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 05:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328408; cv=none; b=iYkTs6fBWvZi/bJ0lpTIjylHw1nKpj7K+YwIqpRAMn/7aZrWD3aEsKb2IDEwr/d9GM5nH4LJgZ/YUhANGASHZM27Q7OtnZaH6g038SG8EI39Vyfss/kXR5J2W9OFafoXyxFTRbUxiEG78LWXZc0hRJc8gE8esM07FHwuk9fQZiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328408; c=relaxed/simple;
	bh=4C20B8VG6o1xq84irEYmMnFFFNWZozk7Mu3OBIBZJiw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UtyCMSUa2N26ttBvNepITEecSUAsYz2FI9bv87MVo8SL7sPPU5XMiGlBEmI/9NTxSh4y82WE38o/WNscn6dXBDCjeZhcx3rzDtGqB6aiDtGWQBTMZrP26W+zXmu6Cp6BHhuH+dlyQtqxvCaXt81Q1QPKUagtQrlFPbYGoG2wrEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knlkzIPR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knlkzIPR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2101F000E9;
	Wed,  2 Sep 2026 05:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328407;
	bh=zqUPFuXHSnINsTjoVyfFzRqE34GEA7cnkmLfcCMAHB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=knlkzIPRwA4gVPZb5rhEMmUWXllOTF+596Ai4haGCfhlejE4GDzQc99B9b0qQ2ZUT
	 GEHtNhvGFm6b6pbgO+/yEDbsoR7Q1lKaUBdGXkeqS1JEY+o8B6DZ50cKUYTNRrGG/2
	 K4yLeVgpH/ePgqKpdLAIUEZBNNjxtB14vp66j3T3CGl3HO1xmtEwwhGFRgTsbZwaCi
	 zJcAW3q8Wit797BoeZDKjKhZn24B/k1xpEfjPoZ59EZyMT3LLBWN46IvrUEtbgsk0Q
	 RvBeSTRm4dmDTV5wRcy51u/wMnyHo3Sj1HMxG4uY67Faqyu5rFPml1aW2qqpnT5Ns8
	 /pRGfNvTwI7zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/12] mm/damon/core: use damon_nr_samples_per_aggr()
 for max merge threshold
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902054747.99370-2-sj@kernel.org>
References: <20260902054747.99370-1-sj@kernel.org>
 <20260902054747.99370-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 05:53:27 +0000
Message-Id: <20260902055327.5E2101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> kdamond_merge_regions() open-codes max region merge threshold
> calculation.  What it does is fundamentally the same as
> damon_nr_samples_per_aggr() but missing a few corner cases.  The
> unhandled corner cases should be rare and make only a negligible level
> of monitoring results degradation.  But having the inconsistency could
> increase future maintenance burden.  Use the dedicated function.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902054747.9937=
0-1-sj@kernel.org?part=3D1

