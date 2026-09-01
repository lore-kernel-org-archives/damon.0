Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E5C36B06A
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269688; cv=none; b=QEcFj/hiPAX0/wopj9O19+pB55elAYgGN0R2U4sgjtLPCN5uEMydP/ZQ7Ee7aw/9lwiEWU3BKTRUtsflQYtcjZ8D8P8Ix28p9fC1KGaC52T70MRNKdXyaW1B6XuJk9gGeESufZKKV12gYsLQ03ZvgfemX9mf62cwTRwz3cytxWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269688; c=relaxed/simple;
	bh=KUeHQuBj91rz3CTcQW14kH1Tq6EQfCoZec++Cn5yl9Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oVg+2H7cC/WOPOISxJEKyOx8sj/VKUDby8uRpq9NWXTGGJFpfAfHJklUq5KuLUTyMC/UE7iVlh4SswWTl0onlNKUTG/7otRvTrmrFlE1NtlQdIg6kLNM/oUm3q80AccWFoXBZt5Q75yd2zrJTyKVruBxngk0t1wosqiUTRcICB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzmLhvwK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzmLhvwK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AC61F000E9;
	Tue,  1 Sep 2026 13:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269687;
	bh=KUeHQuBj91rz3CTcQW14kH1Tq6EQfCoZec++Cn5yl9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dzmLhvwKVj2aWvwoTz6OKfEABVFlcF2HqoatncjS4xtzy2rNvRYvbBoXgQhAtPSqP
	 z/uSNztgPJUGIVxAaf+tjbNCiz4qyKwIb4oEpbdt4yXpMo7B05UeTzpNpBMo5BGG9K
	 quVQm34eWf4QXZvyqM2Z+/2Q0iAwMFQLs1xkaL2MMcNVuwWK/Up0srVPqNeQ6m02LN
	 a16hAs8kcVkA+VeMKFwvI1Y08oA1N7eSeIvps4+RtPmOsIKjrp2EYJL0zwz2P4GBIK
	 0ZZ20tvN4rCEBuV4UHdq7NUUNT0XD9IWU1z2zkz96e5/shjVo/m5BcCC2xtVlnjcR1
	 XXjzQVxQooSTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1.1 03/17] mm/damon/sysfs: support pgidle_unset probe
 filter type
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901132506.99243-4-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
 <20260901132506.99243-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:34:46 +0000
Message-Id: <20260901133446.F2AC61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Extend DAMON sysfs interface to allow users to set
> DAMON_FILTER_TYPE_PGIDLE_UNSET by writing 'pgidle_unset' to the probe
> filter type file.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901132506.9924=
3-1-sj@kernel.org?part=3D3

