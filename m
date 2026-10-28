Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197656;
	b=Q5pPYdkfD2JgAZPUV90VvdnJlu7jpglnIZC5EFktour+Va6wWJCuZ1FACONxkfpEU+8M
	 9Z0ADr6gr60m9qJwH4/f7XU90VW0fBc/O+b9k/uBfB8yVPywM8bNeNln5PTvAjA1nTC97
	 GtOruZBH+cqO0c3gegFInlG0IuT1Omf2SzxrIwG5UcU1e7odK6Hmd/HBAKm+OGA8MoouN
	 sZctrKXsxw24MJrzqVtRTAwJbRT8d+57vjGNq354ps1Nw9K9XBJFWVwvhDNSyEtsYT2br
	 eUblslsAzkJkBjSNPzlnYnW7v0Up9TF8hVOyK0ToJkjWDBR2IOugOG+hbvxcIHGQu2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197656;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KGL5WDneleHQ4XR8dNBguhvuPVCJcmEUuvI3NFiMOdw=;
	b=1k8ASXNzYzaw5IROU2dLjzCJ+GtL4GBAGpSuIqR/Qb4UNhSH+EJGfIR8zMDP1HTGXPkD
	 Rhqmo3FY/6DSW44P/PesXemCGceborz/C620l5WeAulpB0ZpMgG7oviyeRgz+cCbSZFsV
	 2MR2bk0DHKKWGl16iVe+U8r35lDb5DG0ZYo55ADs9kZnXTwrpi0TJrfr+AAitZqOYc9Ov
	 sBjkOqB2O8d6i9dk7lLtAsoatymsA1nC9Ad4Fcdre5Aoowliu5bjultQcheKnhmNmixbR
	 +STWS4hDl0Grc2S5U8KCab1qUeov4CJ0yBqHa39qn6vJBPO7m4yFndVIXebJIh2oGrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q+upBfg1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D840A606A320
	for <damon@lists.linux.dev>; Wed, 28 Oct 2026 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q+upBfg1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B47F1F01825;
	Wed, 28 Oct 2026 14:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793197655;
	bh=KGL5WDneleHQ4XR8dNBguhvuPVCJcmEUuvI3NFiMOdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q+upBfg1vDPcnY7FLkK4ptGTeizXsbBdjqetpzF/xn5TTdjWWJZ3f+zEoEOJGkniB
	 +hOBHtiEvOZCQ5byXUSd93zqqrQNnfP4K4953eYYq4ao1uR7eWLOf2fvsrgEcKo/4Y
	 imThCen6iXbTwW3dzv0KktMRjttwCu75rXuOFTMEE/WftN3ZGNig1aW8KxAeTiGNZf
	 WXcGCVvuyPXs3Zoz2V6MrIZf2+P+ii/gPbp8gjyilWRNuo8lXQoB8KXjZGKWCv/1CY
	 ZMQfPA8UfrmC5IUbvNyQveTm56yamblqujhZ26X1YLXlypSxUDrenFjjwl95j2tOpg
	 oa90pFlTUbawg==
Message-ID: <sashiko-outbox-187978@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y 1/2] mm/damon/sysfs: put target pids for
 damon_start() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261028141430.161175-2-sj@kernel.org>
References: <20261028141430.161175-1-sj@kernel.org>
 <20261028141430.161175-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 14:27:35 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damon_sysfs_turn_damon_on() allocates and sets up damon_ctx to start.
> If it is for virtual address space monitoring, the setup increases the
> reference counts of the target pids.  After the setup, the function
> invokes damon_start().  If damon_start() fails, it deallocates the
> damon_ctx object without decreasing the reference counts of target pids.
> As a result, pids can be leaked.
>=20
> Fix the leak by putting pids using damon_sysfs_destroy_targets() before
> deallocating the damon_ctx object.
>=20
> Fixes: a61ea561c871 ("mm/damon/sysfs: link DAMON for virtual address spac=
es monitoring")
> Cc: <stable@vger.kernel.org> # 5.18.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028141430.1611=
75-1-sj@kernel.org?part=3D1

