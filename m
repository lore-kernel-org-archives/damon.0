Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED5925B30D
	for <damon@lists.linux.dev>; Tue,  6 Oct 2026 07:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270046; cv=none; b=IvhZaCzFAX6IBkUimCfHYV3T80G70GEaGakISHQRzlm/0DAD/rax8Ci4u4ZK8cuIFIu3KfsvA6il5+fhsjyIxMGrnTXtQ9pmNtrTTSxsr2IxFEpMHRcsbiHI2aapH7u+WfTYQGOsVTcoeEkLNjJ4CP2m+vpSbXddTbe8Fri51ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270046; c=relaxed/simple;
	bh=1i9IYrvuU95w029kxGyJhHEiJACMKCPX0Q4tHUy8lEM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nFOAESDlzs685A/9Q9XXFKltrrK8DljFLZobeRuVFFfq3IzBKPKI4cxRC0YgxZnMQwxM6v5VeePE/tUvIvK6RRx6smz7uKjGAfTBzXUVIvnrwhR5AJfMEiUeb+lY3WRTijBhjQGWpmoYYuZyOG2W9aykOilkqRUhruuqNJADrFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvXM6I7Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvXM6I7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD771F000FF;
	Tue,  6 Oct 2026 07:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791270045;
	bh=I5XfQaErkrGkRu3RadDn1d+mvx/vhQbGcRVUDTvo+uo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QvXM6I7ZC4MSaML1/Y9tGc7nCy0M50egDtme/vqIeuFh6fNg8EfDtt20OPnLYJ3Qw
	 sczJxxJ3MXlYn6aKUIXyDT1jTQ0YJ6wOoo6CLHwpGfBVq+UPivoiwl09llZ5khSrCH
	 E85yQyqfGDEuTh1QR9m61HeSm4J/pIRaRmCJ0P8HVAXPSZuxd2v1hY27iuvkFWNydN
	 C5SIGTNdFvOnLz47MB3AtUEW8xvv2r4KYfqNWF+XLsbK1nWjTBf0NdCbzv+UtpLbb7
	 gNyLIPEO6x3nkjrHLfJ59Y67JTsfSOhd3DDYPqxoqkNTPpdng0jBtLwu2PDDCpB7ws
	 OaCgv4xAvL/aQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] mm/damon/ops-common: fix age_in_sec overflow on
 32-bit
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261006065209.41507-2-sj@kernel.org>
References: <20261006065209.41507-1-sj@kernel.org>
 <20261006065209.41507-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 07:00:44 +0000
Message-Id: <20261006070045.1FD771F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>
>=20
> damon_hot_score() calculates the age of a region by multiplying r->age
> and the aggregation interval.  On 32-bit architectures, unsigned long
> is 32 bits, so the multiplication overflows once the age exceeds about
> 4295 seconds.  Then old regions are scored as if they were young.
>=20
> Fix it by doing the calculation in 64-bit arithmetic using div_u64().
> Also make age_in_sec u64, so the result is not truncated back to 32
> bits.
>=20
> The issue was discovered [1] by Sashiko.
>=20
> [1] https://lore.kernel.org/20260623011652.1354-1-sj@kernel.org
>=20
> Fixes: 198f0f4c58b9 ("mm/damon/vaddr,paddr: support pageout prioritizatio=
n")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Assisted-by: LLM
> Signed-off-by: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006065209.4150=
7-1-sj@kernel.org?part=3D1

