Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197237;
	b=L7k92Sco2cPWSEXj5EqwWmATb6Od5PBf/rolElAYr1vDt5KBG0Ln3ycldtNueumShaZB
	 4HbJdQ5DKbrrGRDPpK8yoQtfWkn1Dw2qboLX3mKiTAY09JWLezY409PTCDx3ReaA7hjYx
	 TkOczABbBlMavRNlk2WzW29E+tWJ/UlNCrbiMGaUO4gSBdSldhIzOOy2hYGY4+9Uzqlww
	 yzUmlZYEijLoQ3KXRhk7gjkRGgi/v663jJ6+jQYQM+W+CFewJ2Jw6fyR+mvGDlB/Ub0oB
	 FtwNgSIqir9P3I8mlgHpsXvDql7ODtUsEd7ktIbO8KSUzWdSYoNHEXGuYtKVG9oY8gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197237;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BTiyOQlNEkWrxScpiV+ty1dbO5Sus3dMs8HJmuuQMsM=;
	b=ZJ/zveOQFNtj/wKCcyjNtiJjmMBvUfuRNJL5baL9rZzaaomkHPYTegqG2CSXAJ6eIMtt
	 xJzWoRNQc+Z2t1+J6kmQDYa2sToJcwGmnUyVhiPgJHiqF4dFAkbMod1bwucmo55AYLst7
	 mzi4ILnamYp+tvfMOGT2Z41FBOsF7e0GcfqM4lIPh9YdjbS17pNWUqyp4FoitXv0aLE5b
	 7wIt4pz85d67rJUtiPm9Y67Z1K9sWKumEyvZlxmQd8Zp5VgP+lkxg2q3Y/EMaKJuHfLIM
	 YgZMecRdhWqplYDrgBwlRBcBfaQXMkVOrN1JWtbesByYGuViQjcqPmodJdlJWoeRzVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OmK50gIH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7116606A326
	for <damon@lists.linux.dev>; Wed, 28 Oct 2026 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OmK50gIH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C691F01825;
	Wed, 28 Oct 2026 14:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793197236;
	bh=BTiyOQlNEkWrxScpiV+ty1dbO5Sus3dMs8HJmuuQMsM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OmK50gIHnvYU6DzRXuomO5enxft//UmqJf7pUWFaacEO06uYp2QHTc6G+6ipVioYJ
	 Mv69p++jbxd3iJIxUZBLGyeLa4AuncLiylPZmClfG+euY530bUbouvyR5tNqArNQEw
	 /tjrcOpwUHv3SZsEukc2ca96VcPWh7o7iE+NudYAj9/QsUbTx4y6lIQcOw5sxV5U3Z
	 AFfhRIKDhYg+7sI3SBuXX/7Sm5fwASLu/pmvFm67KqR3IO16LcKv4oitGhttJHHVVK
	 zv1Va4C4f3/Cu8n6I1gFfz/ezhyATMG1wYR5RuDLwRhRO5E9BfoISwgtR85bAO/yA4
	 6kgfp+HVtZl6g==
Message-ID: <sashiko-outbox-187971@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y 1/2] mm/damon/sysfs: put target pids for
 damon_start() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261028141150.160711-2-sj@kernel.org>
References: <20261028141150.160711-1-sj@kernel.org>
 <20261028141150.160711-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 14:20:35 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028141150.1607=
11-1-sj@kernel.org?part=3D1

