Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793073479;
	b=rF3jqUEu1v+ONyTUIsBf+RF7nWBiWd4hMW0o9h7BmGIqrKn60NZn08ZkYSFjYqZMxaK/
	 LDGsxJcyyb7UiBdqavSLTTKPk5NzhhGupvVavh8ntCuTXqXXYl0oSZZxeAeEd31Cl65rM
	 ORTG+Sx7ABHWrjPv8P+ZCpDY4vt27Kuwkyta3+P/OtMFjHxKcQHacdTAju4IgDgOrc3tb
	 /jjbM9lgUQnJPZysXUAEMYjlioiM8NHlwidU1ZRLMDVxXCZMcSasbBRiIPxaoQaz7sa7e
	 07S41jYVpeFHhX8pIhkITk5f89e8V8HBPENW/ly71zExc5YQ0W2dA3zfMCrg41vskHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793073479;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gPlEgKJy0mL6Mc52536i4BPGulIl4tPkpk7SV3mIqZA=;
	b=XOHdEkPFC1zgy4fTJb2CQ+EaEsFvxRdw2ccARGDuAWsGKcVGj+Hei7w5ZwyIbt1B0/Xe
	 WLrXkYJMKnJX2TbwVuz6bAdz2wy5/w0rG8QTVyfTSv2keGOP8KSFmGgAZYrvlED9eaEHh
	 G0O5cSIFLZ9y4bqXUGp1ULX0aez7aUF8YRVeVaAKwfQ5HDWewK+a2RH/YvkkhT2QLaPho
	 31prlR4K5F4L2IxnFcFBE+PezXE/44DA4orIozBbbNlgrEvyEtpcUmG+T6lnlC/yXRlhg
	 MKjVcBP8FfWOMEwNmuutGMZlMHOjoPmb492zMGeWAiQwCQlbwaTOqz316tkz37WXcKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O9N9CvYk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B79606A31A
	for <damon@lists.linux.dev>; Tue, 27 Oct 2026 03:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O9N9CvYk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44481F01825;
	Tue, 27 Oct 2026 03:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793073479;
	bh=gPlEgKJy0mL6Mc52536i4BPGulIl4tPkpk7SV3mIqZA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=O9N9CvYkVJNHKBSMGVESJ9AihGj7vajBhEY4zLvADQ52Ovh2qzy2KCL5BlBBejTxd
	 TYUL2I+oQF59prwpYDa2uFt6KNuUd5EUu3aaTnUDeshG6JXASF/UCYi6qFj742LKwL
	 x2TmluH269Vl1dobc6utFu5/juZO0SnCuBjtaHOdB+un9haqVc0QkcfPKwirqzPBW7
	 GGftLce8ewpFyYvO3pslHv/qEpMq06DmGeU2wzpROOOiMeZZ/AwsLZ11Z36R/fGFTY
	 EuzKj/cJ4iHnRZkQKV1QYFUkFOaoMfa4qMNZhOsoqxtgKBhW16MVV6HEZYUgK+Pqcd
	 2WZQLym6EpehQ==
Message-ID: <sashiko-outbox-186062@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/vaddr: preserve migration weights above
 UINT_MAX
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daemyung Kang" <charsyam@gmail.com>, damon@lists.linux.dev
In-Reply-To: <20261027035431.1007584-1-charsyam@gmail.com>
References: <20261027035431.1007584-1-charsyam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 03:57:58 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> DAMOS migration accepts an unsigned int weight for each destination,
> but sums the weights into an unsigned int.  If the total wraps to zero,
> no folio is migrated.  Other wrapped totals select the wrong node.
>=20
> Sum weights into a u64 once per migration walk.  Keep the existing
> 32-bit divisor path for totals up to UINT_MAX and use a 64-bit remainder
> for larger totals.  Add KUnit coverage for the actual summing path and
> for destination selection at the overflow boundary.
>=20
> Fixes: 19c1dc15c859 ("mm/damon/vaddr: use damos->migrate_dests in migrate=
_{hot,cold}")
> Signed-off-by: Daemyung Kang <charsyam@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027035431.1007=
584-1-charsyam@gmail.com?part=3D1

