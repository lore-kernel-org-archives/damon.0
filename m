Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1D1577E3B;
	Tue, 22 Sep 2026 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097788; cv=none; b=CK/2XvQzYVDybkLduKW6lHwwTWkkoPAPPTQEVpHzPbm95F/rKsnjZ0Dee6VsYsC9/s+/81P33BMpWyRRC6IbwHTIsoQFP9RnoxgLt1Ou5hQDsKAgVH2VK6rA1vdVtytzztgmiwG1fkrqYYnnz95cok6nxSj2eGnnIhS7kBgNi84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097788; c=relaxed/simple;
	bh=FVOP20CywOlOscX6m2SDY5nX87BWQA9RNgIT4wRKV8U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iypqPsrWN1Oq2NeGED/fMXA6083Tl8r6+KgTNq+3QgijllrfqcY1N+alvlbCzScBY1RVxo42BqcIsIrczp5xyeF7oz/f3Nt8wRBIoA7cufuKbjj2WoZSAeJujQVFYVsMdXkiZpnXfHXbwZoL8AEg8GDLQOBwKBS11Dh/WeooXFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvEZ3ZR1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvEZ3ZR1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270351F000FF;
	Tue, 22 Sep 2026 17:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790097784;
	bh=FVOP20CywOlOscX6m2SDY5nX87BWQA9RNgIT4wRKV8U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NvEZ3ZR1W88GHhCGwSiECzXDi7Bo1GfHgA6kyq1vMkQsSgOn0UMpebsSBtStaSHdY
	 050AnFfezmAfLnrgn5yZhQa5nGF2/mYNuvH47l0iouQReOrMRlHUSwaZEjeCDOEdOn
	 tRc0ETValrxXhT/wjt/LphBS8+HXyEqtgho/3Z44YynYa5sMLcL+Tc4m5aFuNF1tUp
	 qVdj0z4udi773I/9DYS4rxQBG1z/AllvIGDP5wRY+Qk0hnq7Xxm4g90n3bKUkuB3XN
	 +ws3BrBo4o/LsRsi7qfZqOOawwDMyrXgw1St9MNGQ2x8pGTVWlciJUmdw6mlLdWAs4
	 MGuihCb/WmFDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/9] drm/i915: use hw_pte_t for PTE range callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: damon@lists.linux.dev, bpf@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260922-pte0-v3-8-5670b8cb9059@arm.com>
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
 <20260922-pte0-v3-8-5670b8cb9059@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:23:03 +0000
Message-Id: <20260922172304.270351F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> apply_to_page_range() now passes PTE table storage to its callback as
> hw_pte_t *. Update the i915 remap and selftest callbacks to match the new
> type.
>=20
> Continue to use ptep_get() for software PTE values and set_pte_at() for
> updates.
> The type remains an alias of pte_t on x86 until that architecture opts in.
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-pte0-v3-0-=
5670b8cb9059@arm.com?part=3D8

