Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631055;
	b=m4MVzWWcfVfDbYeXVA/hM+TKI0ZBFpS1Ksv21D/HMQDjvz6iXU9Ahg9MIz71ZVxcFB3/
	 TjNKH0CM3FTyEtRY/ggX/CITq2hpUOU8HEftqKxNXssLbti5A9KH2b7KRK4I68qx0M1b2
	 NkCKMt7Z84CT2SoW9GyClAW5ttPLlq50vpUktQkgbE0FcpdlbfCB2QyCQ0bTSN7jrZpOi
	 0an2bRKiZaHOWAHm44ocnXLntes5Vtw2lovRiANfd5INoyaLwIMKew3XQhBrXL+vwHfGn
	 ieWUaWD1NurqVVN0zclHGnxeux0GU/NOJ50tPHrOPHFShI7eEZAi/5tsFkahGuUyEYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631055;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LeCYwJ+pKIIQ0aVl0SNFzHO7+RmNY3iDYrhP6aRMp8w=;
	b=rtaXJZF27l+m/fXvb4iN5iq+iZaQFoE3QhgGA1A8sehwqfOazYIrnTRSEMXvFMtyvuAm
	 Vok5sNTRDPzQ4BRpV22pCFBs3M+WgWBQXtf5Y9fiXqRh4u+uVF9QIz6fNieOg0UZJ2GgN
	 zRHQf/eY9t7s4WMGWLh03W2njVjtadmj8casDknjqpOjJ5bqte2C5pRtU09Y0QEjFzDrV
	 Mu4/uDqg+YGWJ8FciFRgHNnNQTl6SFO8JAZaW8/CgWnT5/q7yLDF7KDHFXN3XBUE/ifek
	 1C8yk0eti+rcoFsjBxHI736efmDENCtPLBMyb7lJvc79kOi0OWIKCkVL0fP/VXnsA3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RfN8C7V0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E9C606B92A
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RfN8C7V0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137C11F00A18;
	Mon,  2 Nov 2026 14:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793631055;
	bh=LeCYwJ+pKIIQ0aVl0SNFzHO7+RmNY3iDYrhP6aRMp8w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RfN8C7V0jXTl1JyzzBsBU3MK1+pvtPJk6QVICON6bFGcaRZvCC2GvG6VsnkKLxL9E
	 aOhQ4Pf/9pBREzBfrQJj5E5S1rsj6S6fVAZmKYwNC0VkKYlN9tDayDIG1ERgOxkm1f
	 Rrtv/nDI0ZbvVwL86j55TZAnMwbPy8aEqM5RtFIKrvkO62pvJ2MFUHKyKs1Bvmi9tW
	 VYd/nzq4lAy9o8wuc47UHaonnzmg9UaAlkmH68wKJ+AOOaediauNZ++NawWtduARls
	 8mq6WPas0cm1kEiNvLZH1zugVNeGJdz5ZSAlDoWobbx9pPYNSORTwsZejQk1W3u5qN
	 EW7mZcBe4/5CQ==
Message-ID: <sashiko-outbox-193608@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mm-hotfixes-unstable 2/3] mm/damon/tests/sysfs-kunit:
 fix leaked pid reference in add_targets test
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261102144627.88843-3-sj@kernel.org>
References: <20261102144627.88843-1-sj@kernel.org>
 <20261102144627.88843-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 14:50:54 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>
>=20
> damon_sysfs_test_add_targets() creates its monitoring context with
> damon_new_ctx(), which leaves ctx->ops zero-initialized.  Since
> DAMON_OPS_VADDR is zero, damon_target_has_pid() returns true for the
> context, and damon_sysfs_add_targets() therefore calls
> damon_set_target_pid() for each target it adds.  That function grabs a
> reference to the target's struct pid via find_get_pid().
>=20
> The test then tears the context down with damon_destroy_ctx(), which
> releases such a reference from ctx->ops.cleanup_target().  For the vaddr
> operations set that callback is damon_va_cleanup_target(), and it is the
> only place where the reference is put.  The test never selects an
> operations set, though, so cleanup_target is NULL and both references --
> one for each of the two damon_sysfs_add_targets() calls -- are leaked on
> [ ... ]
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: "Liam R. Howlett" <liam@infradead.org>
> Signed-off-by: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102144627.8884=
3-1-sj@kernel.org?part=3D2

