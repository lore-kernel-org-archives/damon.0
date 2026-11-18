Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036254;
	b=MwsY/mqYj/lU70ZAkV/mO2Jr+PnRnDqBya5jwpu1MUCNWdB38TxFI5w4b6oepFvkIxUV
	 LnSIL8qLjHdwIZXy25oiz3cE1c8KfGrLOCtjbDJqxBo4q647oyeGURfmKCp4NZbOXd7A6
	 vuSA1BX+yDDlZT1q4jcDzu8xPdko3xy04AezamgEk8K04OeFFsnP+eltVjlqAZI12X5xw
	 z2QgdDB9pfPjTO2/bJJv6u8hKlsE38BrJVJI7XBM50p2aIwjIZ4QmzRfEN7DXM4SCpR7E
	 ZBy3V9p8EpY0/I74Af0xdaXSo7O2BD7tlB2jzf2GVf1uA79b97BeGnMq9yrh4guwpDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036254;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PsBOfTouGgz2vhOsFpdm/dFzJU4YK7pJsVJgVvq/VzY=;
	b=lh1aB+xDEenQe0pp/TYJNhJbZQCu/jhj54IlNdPq/Cv1uYmzwhhj2PrNEW5uU9kX+09n
	 5VUx6sEX4qB7elnSa1iGycOxIBP4OMk0tqiLhRLJCm0pgEzDuwCYnLYzOYgRVKHytMko9
	 ZUmpb1K35dwWpDMA+45Eu2iEtcGfSsTUhd+J0L85GnQubuwAaKV4+qEQU7cydjrjlqs/Q
	 l65bnQUWtCUddzOOEiC32XDlX2iKwAk6pxuintgNr9HxskLwYKhD5UEw8XCWCZSPOYhal
	 A3S7D7Isyg5u6UrBv0PXYTS3wZacvbHAcmCmvLIvw7k8yH1ShebzVVMmYJ6Nd9at6Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MrUkUG/v";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E464606A332
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrUkUG/v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4E51F000C5;
	Wed, 18 Nov 2026 21:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795036254;
	bh=PsBOfTouGgz2vhOsFpdm/dFzJU4YK7pJsVJgVvq/VzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MrUkUG/vJZqGKutXdTCtuFkG8+BYi8Bm9gvJig1krUh+hVFmUG8uzyeukt7Uf1ynM
	 vNsFNF+g3Bn0mzUGxa5f9cMx/IoE+ztHFLZ9+J5nF+qexmlJ8HfYqwS/Smd7lWJRNp
	 L5eAQ2H2ePJetyma69M6hMznVjwxfjsLHTetcgKCtQh2vmpTGdAB9etAYR7JYC3WkZ
	 oX+PFOHLuxgCxyNC+ZfJMdRkSvjzud3bJVvUBQ74bZH/n62Jd7bUl6IInBYsbu/4Gz
	 Po058LUyw9+x7xMtLleQ21PLl+P9znOBnSdlNm7hXwKcxlcvfvKVwqai+v6aZ1fP9G
	 AGUHLGZ2v3rhQ==
Message-ID: <sashiko-outbox-221975@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/17] mm/khugepaged: convert to LRU refs based
 operations for MGLRU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261119-mglru-fg-v5-12-9eee2fe97a2d@tencent.com>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
 <20261119-mglru-fg-v5-12-9eee2fe97a2d@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:10:53 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Kairui Song <kasong@tencent.com>
>=20
> For MGLRU, PG_referenced is only the lowest bit of the folio LRU refs
> count, so folios with nonzero even refs no longer have the bit set.
> folio_pte_referenced() testing the raw bit misses hot folios at
> refs 2, 4 or 6, under-counting the referenced folios of a candidate range
> and aborting otherwise good collapses with SCAN_LACK_REFERENCED_PAGE.
>=20
> Test the refs count directly when MGLRU is enabled, mirroring the
> smaps conversion.  The classical LRU keeps the plain bit test.
>=20
> Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-mglru-fg-v=
5-0-9eee2fe97a2d@tencent.com?part=3D12

