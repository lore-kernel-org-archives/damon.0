Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0EA4E36CB
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792076738; cv=none; b=BWevM3wiJonymoUPidhkC8nlgakKJVK9GwG7dXqCBpoLFjHp3N6vQTJnVXUhRhDrWsAIrsrgFEp3DzFtyDh6mlmV/Rf+ldcj6NafYqGyUcW1vUSL6/6EYiamo2F+twrSZhPM3mOKP8kk6scGciXStS9lnh7L5VJ5IWxSKkMlzHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792076738; c=relaxed/simple;
	bh=U2MVJpVETcMFwh1tx8KnqKM6k5D1/toVOKzyMB2B0Uk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WgddWG4DKyGoR+qe/haz+zHkNxZfQi+awaJ1OE4Bm/+cKOgVIhfXav8jXd6D5lM7Sa0FWuC8PQXXMphWCkHrtLBiNah+ZduDiVh0h/ulfvC/wjQinJLb8IuwJfnuaDrrufaVSg3UKqj3Wifa2sC6On4YDt2TxkgnKe/+JWguxf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVUx8neg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVUx8neg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2861F000C4;
	Thu, 15 Oct 2026 15:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792076737;
	bh=U2MVJpVETcMFwh1tx8KnqKM6k5D1/toVOKzyMB2B0Uk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EVUx8negGSHuWyB1PUAlBqWulJ/go6HXWUyqHRLlqrLJfBbURQ6rZ8gmQTaKPUKS/
	 EEeztE8GF2B1PaAHQd9jaN5eosXl3DS1OhTu2yn+UvRc9ieObuPcNUAnZ0UxJzIhMp
	 ihM/C1wqQ3N0aviAHKZ2MgrJ8+OB9ffwntWzPgnyz13/bgZC6Yapn3i9l7SrxncjdY
	 w0VFwDbsUsunGVh/BEi1gl+gtdJetiFbnUnPWCpZRLL+OR8ooWYg7MUFgOfMq9QyJu
	 VHpxJaQw9tSfsUX8yK5br27zvWmbxuTI3NBgdu9pFaw/uVfw9+07yK1ZFDhGUm0Ix+
	 eeeQD8pENRmDA==
Message-ID: <sashiko-outbox-173034@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/stat: avoid 32-bit overflow in idle
 percentiles
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aveline Noir" <jm5905938@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <179207592479.3.11595453180868898703@gmail.com>
References: <179207592479.3.11595453180868898703@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:05:36 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> On 32-bit, accounted_bytes * 100 can wrap before division by total_sz.
> Some entries in memory_idle_ms_percentiles then keep their old values
> instead of being updated.
>=20
> For example, a 256 MiB i386 QEMU guest reported p0=3D19200 ms, but p50 and
> p100 were both zero.
>=20
> Cast accounted_bytes to u64 before multiplying and use div64_ul() for
> the division. Compute the percentage once per region.
>=20
> Link: https://lore.kernel.org/r/CANOyQmHad1vamnZT12M5yPrJ69=3D=3DPt1U0+MG=
w6u0MuNtr-DRCw@mail.gmail.com
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179207592479.3.1159=
5453180868898703@gmail.com?part=3D1

