Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633673;
	b=Q18k2TILwxWrHT5QFNVDOW+2gcmGsHNwh3Cwf97sC8/JvzQq3hRqpYtuKLWu44Jv+8ml
	 3rn3sksPityG60TO18XALacfyVNa0n0+DGDUDjvUxET26uwMOKj62MLAMpHkMyVy3pREu
	 +iGsn85pbNQ1FH8Xq/lGEumCIDoF2xrxqMNPbYqpb2II3DGIR4ThaE3kvSSMjTYp6eCDe
	 8j0dliVPndm5mkz9inn9884UJaNDVyJhuRkRgStTIJqQbwwXFYWhxCSN3ZgPDO2vkfpdH
	 0XmsoCttkH8buzIZlrWcREcpljCS41ZweGC3Oc773fDuSBH6DQDVdvVAzHhAT97Wqdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633673;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=73TzOmtzp0G4r5aHqhtod8X//PH8wmb4FUvIkyvMvrs=;
	b=Qe5EGXOpROezVwKFYdBdoP8FrSFEi0hSNNLsi5mbnZd6+TzKf280DdcHC0pHYx7sDqHY
	 O+dQP1KgznTjHU//dxlyJ+8EG89np3VJ/Ze7ugYpsdvpBJ96VF1JcadJ9/kWYvLHqWw+Q
	 5IKstlQK9v49cVnvnbWSkY/iIRNqGyjdLy51Gl9dz/Mh/VHeo954NvPrLFTbRC76oOest
	 rTwado0FgtnLbhCPH9yjVM0PieXBZcySfeN+juzyeEL/WDr8/XJVqenw9F2ea30tNagzo
	 KIZv8CVbCA0iKT08a2KrRL92T99cjy5C/dZAugMyJXRX9g2Jc8fry/4oR2EplH8Y4lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nNTAWSt4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E61606B0D9
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nNTAWSt4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12221F00A18;
	Mon,  2 Nov 2026 15:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633673;
	bh=73TzOmtzp0G4r5aHqhtod8X//PH8wmb4FUvIkyvMvrs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nNTAWSt4m2UQnz43ra/hEW7I5sQ21NSKnk5aLvI4zU5If+G6t0ORaHxQUMiJ3Ighb
	 gYJ9OH/5O904RcQe3ZXk1w7Zr3O7TiiMXTsBTV5i6J2F2JKF/PnSDGBYF90UlwDGPH
	 XibVJZ4Uw6S82cIRw8P0hcVJj11nMWyPW7y6r2SFOpFZ2ct516a9v0xjT1Oxt8X7jq
	 tQtJ/cXQgK00srlrhuItoe6pz+hZsFFCeQ0br0mtDlbFqkOuN3ZgDRshy+0lJ7CqXJ
	 nHS7f74jCPQ/Me/E/gCLx1aKoA62eQWNU+gbeKbUPkhB4YVEhzlDO/rZJgFngx8eB6
	 VanCfsjy6M+LQ==
Message-ID: <sashiko-outbox-193673@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/9] selftests/damon/sysfs.py: stop obsolete_target
 shells hanging the test
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261102150757.93058-7-sj@kernel.org>
References: <20261102150757.93058-1-sj@kernel.org>
 <20261102150757.93058-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 15:34:32 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>
>=20
> The obsolete_target test spawns three 'sh' processes as monitoring
> targets.  The processes inherit stdin from the test.  When the test is
> run via 'make run_tests' from an interactive terminal, the kselftest
> runner executes it under 'timeout', which puts it in a background
> process group.  The 'sh' processes then try to read the terminal, so
> the kernel sends SIGTTIN to the whole process group.  This stops the
> 'sh' processes, and also the child the test has just forked to spawn
> the next 'sh', before it can run 'sh'.  The test then waits on that
> child forever, until the kselftest runner kills it after 45 seconds.
> The test passes when run directly.
>=20
> Fix this by passing stdin=3Dsubprocess.PIPE when spawning the processes.
> The processes then read from a pipe that never receives input, so they
> stay alive and idle as the test expects.
>=20
> Assisted-by: LLM
> Signed-off-by: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Tested-by: Aveline Noir <jm5905938@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102150757.9305=
8-1-sj@kernel.org?part=3D6

