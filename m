Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409835349DB
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 18:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088995; cv=none; b=cJ6yiXJ/teF2TKJ99UwdFAJJiiXsW9YBUMCZIhdO/D9Mjv2102AlDMBFhkwrSu0XzrevAzvhagzpxI04e5j4eLNhO7u7LXFKtG1qSX537bWoXs490YRW1a20sxKmiuKylBFpFYZgr23C7Hy9O+dkqodCAvBps3EuXrjrGgly48I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088995; c=relaxed/simple;
	bh=6NsrBOneqUeB6LhmPBCZuoCr3bbqJG6FOxcsPXbx7mE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CqxyBqngGkgeQ/1YG6ycbiw/fYvPyRm/6J775hW4DB0saUfCe6F2J3fDzufhcim2C5HOMnyI2sNOaCkDC1GV8/4qOFth2oDYovUvmDiHHD5DShvIQgSHC6s9zA/F0tcUrww71QOZYZ2vtUpCM/PS/xhCw7loJmnngde8vsA+KmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTczBEGs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTczBEGs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F061F000C4;
	Thu, 15 Oct 2026 18:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792088993;
	bh=WOkaKHvUBqqfPv1WaPp8T/dLdnXylu7KwWtuEHyuc4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZTczBEGsIgShJgAgnGhNQpjYpCL/hT10IM1S8TvIPTTH8Y5bZcRMRsJWcjegYncof
	 5l7Qa2mNgrCtUne3G52ud9ADEZ05BNaN4rJTfAeR5AkecGPxZ/fZUVfOOpGVin/lIc
	 2y8DMmPZumEv/uQMhHERgSwArWjScLE73aLmt+5865fY0PMtubAeYe+mH3CAD5BvHR
	 92mq5Jj4RhUEAbEpYBEbXwH0AQfL5jUHURTFN/MzURAk2XDqAD2SAMC6y58coZ7Gz+
	 Um1sSfbS7U0Peec8DSeu08taos6zEHsYzScft2ON44NFNFVI85Dmx08PfuvXdz25t5
	 fkG9B4/2FOXfQ==
Message-ID: <sashiko-outbox-173298@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/17] mm/khugepaged: convert to LRU refs based
 operations for MGLRU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261016-mglru-fg-v4-10-2106750c0bfa@tencent.com>
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016-mglru-fg-v4-10-2106750c0bfa@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:29:53 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Kairui Song <kasong@tencent.com>
>=20
> For MGLRU, PG_referenced is only the lowest bit of the folio LRU refs
> count, so folios with a higher refs count no longer have the bit set.
> folio_pte_referenced() testing the raw bit misses hot folios at
> refs >=3D 2, under-counting the referenced folios of a candidate range
> and aborting otherwise good collapses with SCAN_LACK_REFERENCED_PAGE.
>=20
> Test the refs count directly when MGLRU is enabled, mirroring the
> smaps conversion.  The classical LRU keeps the plain bit test.
>=20
> Tested-by: zhaozhengzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-mglru-fg-v=
4-0-2106750c0bfa@tencent.com?part=3D10

