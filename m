Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794969098;
	b=WVBc1g4hjLb6S9hOO/6NHP9nC/prDjB05JJmI2jslgswRwd8m+rm0qMuAPkmDu4LfPGD
	 V0+cZ42Bavu3yZwbNzc6tbuoJSBN3Ts3hzWhZYr62LqKKVz6m6W1LF31FXUgz3qAwLNvj
	 iZe8b+t0T2l/PIAEzvsW98NP6ttw+GWzXpCm8u1uKKTxwUzCsDV3Sn1KpJ77vvl7dnAs/
	 6eJ1DJpqkDgnC31CRNrq2JEdzIpSbL9/HLeri4YUJVufkFCpZL8TglR/HsbTjyBKs74lS
	 xWGZlOD+5VL4HWKgZOZWEamq/ohzxNMhfDRyYdPztcn9yqlBpZR1gRqkNhdKD7MU9Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794969098;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JDXqWa5U2tWQmnHBv9lG8VFZQOCZRn/7MIkUm8eJM+g=;
	b=RJ88d1SBbIgGQbEKC6YfgUWW3iy6XM7De6iJEtlsdJbv7tFZSSB22I5O2Z07FaIjCusn
	 kjuAsyVJeOGA84HXWi5f4CqKhELP/nhoi+VhZGBbOSQG5Yq0gpRxxg9DNELgs+Dt3stYn
	 SMeu5eBroFix88nUdUfwMbo+SvD8UHJPup4+xJN+2RsWLQnjsSBcku9bXU70ijOawJypR
	 f8waLniHuo9dBhTDD75FQwt21EtypzZ5a6jKBjcI3+SWuWGizZ2jDmNrERYbHGgRnqe/L
	 AXNv5/+OBz/6WyqoIsveRv98q8w8Cun5aDxA6WPRU58yU3HVGZY3F2TA1RWVeX5lmEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mzOftNWZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0CE606A32C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mzOftNWZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBCD1F000C6;
	Wed, 18 Nov 2026 02:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794969097;
	bh=JDXqWa5U2tWQmnHBv9lG8VFZQOCZRn/7MIkUm8eJM+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mzOftNWZTV/ZlBKglk8wPa7rXlJXd3wbamEcVp7yqtBn63byPkIVGTqNwRgcJ1Ppy
	 ChwbWHkY9f1inhkNpzHNXvzQ8V/G5quIvmCA2J+rp+fQUBdjjJb/sWUERwIIHo5u03
	 zSrHpZMEAtUE6p6ZFs+97gXsJB4RxLsGK3iIYXeDyMQ3/5n6Na52RUN3h4C1RCao8B
	 k/jCmADT2n9Jo3x831K+A3R4r3JEHaJUdpJNYuiGx0oyxARfQsfa8Q1AXo6wOu8B5u
	 bOgoiiR9477cr7QOKBpm3/oYU5/k4taxkia5yDOvSrgHaHDvJ1sQSDVfcPBRXL7B9n
	 7JPPVT+nhlyGA==
Message-ID: <sashiko-outbox-219966@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 23/27] mm/damon/sysfs: implement submit command
 for report producer
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-24-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-24-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:31:34 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Let users manually submit a report of a data attribute for a given
> address range of memory.  Let producer_state receive "submit" input for
> that.  For the input, generate the report based on user inputs that are
> written to the appropriate sysfs files and submit to DAMON using the
> core API, damon_submit_report().
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D23

