Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166279;
	b=EgsypMT8ZgnjMyf/Cue9O+hVTLETOYjizORLGhU5quWY1Pd5pps3YN/EQzgESKm58lfg
	 y2FrwlDAhB2tIiYfiahKzucuFrX/61AI0ylM1jsaSNNoDDJO5WOEFBDv06czahDS4n4u4
	 CusNDVDu3wRytUOoIo8Ab4t00nz912+ksYrNYrsaP7JSu3P1k9sf60OtVa8W8q7jJeccz
	 xGYqNz9Qf6mDT68jOgab54utUfPTKojxLqDHB7FrZCvzKdU1UofuIO3Akfu/eJTZwWqSG
	 gKTdQ3QH65Ktv9GpjHRcFA/Of/m5q6BUhIGTc2s6smMbkblxTk9uPUn16NXs6V6zo3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166279;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BB3A9xh2PwWiMuZdlCcP7QL1sFk/1dQfwvriK/6BS2g=;
	b=wLMX8VwN3WPARO9/kNubGda3LEeAPv/atDESq/KWqNRtCceaRNu+3Nhn+RsSbXAAq0Os
	 uEZFZ3A6OeH++0q/p6RU1yiYQcVxuJXkAO61js0KCkofcQGiqYBfNM1GVHkrR8NPJSIql
	 mrSNW/kXlFXUD5utn4YUARLMOILSnxLK8WH7RMdIqDuQvUSEQwJbD8iqU7pU9tzg+2NCU
	 YlXReyztcMqhDm8p+uG4J8eou6F8UfrNtoRVBG8W0JEckfPdMzl11gkRnqRwyl1AfYMuO
	 W8Xm2oKSWncmdh7ur8gTi705d5eDUHfMU+9KbXI2ggvMb4r8JIiyVgTZWF7m9WJvPrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=njzFSdbL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4EF606A320
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=njzFSdbL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E006B1F0089F;
	Sun,  8 Nov 2026 19:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794166279;
	bh=BB3A9xh2PwWiMuZdlCcP7QL1sFk/1dQfwvriK/6BS2g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=njzFSdbLsNVTrFsqXxqItD5d9N+tHWl106IBzcswDSyN4NZrQ2b3BkMlMQnhLDU+Y
	 boDk2oQ+31Tm9iRoOw4gxln1Uk4u7vy2fgEPHSIRxYqph3XERRIXTrVC0HS2wMH1ON
	 8VRWOyZUac7eF2jv0VMPS1ZxooOnMuTfDX9TnCA1LcnFRg+qgyxHd3tHEDwVGAyFfK
	 ntPrYCI6NynAzTOsPABnQQjFhuOTKpVUYnK+bVAcT7I9VLu66J4lQwWthspOxclmrl
	 rz8rHUmPDFHjUrwSmlRtVMa9hxmB3Tn8Q/0hRmoTds1zF8Xpts/7pKtUmtNBqiiULu
	 3Vc29s0Gvosbg==
Message-ID: <sashiko-outbox-203955@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y 2/5] mm/damon/core: handle uninitialized
 damos_quota_goal->last_psi_total
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261108192221.114362-3-sj@kernel.org>
References: <20261108192221.114362-1-sj@kernel.org>
 <20261108192221.114362-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 19:31:18 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> When DAMOS_QUOTA_SOME_MEM_PSI_US metric damos quota goal is set, the PSI
> delta for the feedback loop is calculated using
> damos_quota_goal->last_psi_total.  However, it is initialized only after
> the first feedback loop.  The first iteration of the loop uses the
> uninitialized value.  As a result, the feedback loop can change the
> effective quota in an unexpected way at the first iteration.
>=20
> The user impact of the issue is not big, because the issue impacts only
> the first iteration of the feedback loop.  The feedback loop also has an
> internal cap of the quota adjustment.  The wrong adjustment will soon be
> corrected over a few iterations.  For this reason, doing no initialization
> at commit time was intentional.  It is also explicitly commented.  That
> said, nobody likes behaviors that are unexpected or difficult to be
> expected.
>=20
> [ ... ]
> Cc: David Gow <davidgow@davidgow.net>
> Cc: Quanmin Yan <yanquanmin1@huawei.com>
> Cc: <stable@vger.kernel.org> # 6.9.x
> (cherry picked from commit 29c6084658af41b5b1fefd873d26d441830ced34)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108192221.1143=
62-1-sj@kernel.org?part=3D2

