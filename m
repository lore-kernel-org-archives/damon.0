Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272026;
	b=y/7s0YzlmeFg9/nGu51eK6G0akHCyZqTQTzRjEQwHW7DCXYkwSbRiOjhgYXU97p6FRZq
	 iJbWCI0rd5qXLqsoQEmD6WJsPdpdZh20AbdxhO9X0RBGlrAL6kWPhbZBODsaJtqhVcMn/
	 itYIq8bm9bP81LQMM+2PIvm5hXse62DlM0x8MKTYWuJm9eMvjkZ3XRe4uGCKUXz+8vb9R
	 AsAJsdvDshhjsUVeSurbqOTqoQMFaTRPpd+xLCE3neX6K4fZ6OSvUAO0WIxDdjiCGAVLx
	 sz7yhbaP7SJWZ5VkugdZ93gnehIzrYxCUspWJSkOb7bgTHNcbw4x/33/O+dlA8jKw2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272026;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v+KEy9V3CiMDH/HnTTeeDjLAIPGhrSJxAiHDXjanxg0=;
	b=5JgxdwP9GAPn7W22x1oqiDAtVJYvbfGGMrUJSkDxSWsbNDivIWtEACa2ScN8usfIWD+6
	 O82xWz2hgPtezshkhGKoeAKBV7BZtd2gVUTbCkJ8l+QbZGrC1hB8eMyhxyIbrg+FZENUq
	 6CwZ1rFGwPRM1hirPS/eeioWv1cfENdZNnAVe5KGidgRRzs0q5V7ZvZ39QQevpGs4k58s
	 4HbNyNtFLeDKG+M4IPvT9x3LpTySZI4/ZzopW7nLLJyILFAlXZAUUb81H6us5QeKd+FGp
	 D8ILB9gujTGnvjBeY8O2cgp3TlGJZama8su7x0EehECpQyl1ttbC9VpQV8D8KcnjTCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7oei43+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302C4606A31C
	for <damon@lists.linux.dev>; Tue, 10 Nov 2026 00:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7oei43+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A251F0089F;
	Tue, 10 Nov 2026 00:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272026;
	bh=v+KEy9V3CiMDH/HnTTeeDjLAIPGhrSJxAiHDXjanxg0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V7oei43+/UrOxZvxZAX/gRad1TdgkI45+nTOZHTD0XTIgSev2+2dDbnb93gdzzIi1
	 PVcc0EE8L7oYCKjVkY5L8vAJq4bsJtC27UFV2ayQ1B39t8CDvI1SCoyYtekWhdrGht
	 IdqskVfsLeXCyjVu3Q29ovF9DZ+EuwlnYLbqUObb8GCoSTXZVD+K57oRDqg/RE66+T
	 MyVpSCuVP57s/TwCoUKycQsqeekqJWfuxIKZKQHCxLeVvOWM2IGpBu+7fb6C0H1phZ
	 3BTA8c35+/ke1O7WZvGTSGSZDNuZpRSAzaxcNrhH5N+Afm/pQICxYu102GUHCyztAO
	 srt7R0Rt6i3tg==
Message-ID: <sashiko-outbox-205910@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mm-hotfixes-unstable v3] mm/damon/stat: avoid overflow
 in estimated_memory_bandwidth calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261110004816.100066-1-sj@kernel.org>
References: <20261110004816.100066-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 00:53:45 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Wang Guangke <gkwang@linx-info.com>
>=20
> estimated_memory_bandwidth is calculated by access_bytes *
> USEC_PER_MSEC * MSEC_PER_SEC (=3D USEC_PER_SEC) / aggr_interval,
> and users read it via
> /sys/module/damon_stat/parameters/estimated_memory_bandwidth.
>=20
> On 32-bit systems, access_bytes * USEC_PER_SEC overflows unsigned
> long once access_bytes exceeds about 4294 (U32_MAX / USEC_PER_SEC),
> so users get a wrong value.
>=20
> Fix it by doing the calculation in 64-bit and splitting the division
> into quotient and remainder.
>=20
> The issue was reproduced on a 32-bit system (qemu-system-i386): the
> parameter estimated_memory_bandwidth reported 362 instead of the
> expected 1926150; with the fix, the value matches the expectation.
>=20
> Fixes: fabdd1e911da ("mm/damon/stat: calculate and expose estimated memor=
y bandwidth")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Wang Guangke <gkwang@linx-info.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110004816.1000=
66-1-sj@kernel.org?part=3D1

