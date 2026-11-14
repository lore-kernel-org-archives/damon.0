Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640759;
	b=oR5vz8L/Rsfkt3MX+dXAPpKx9trnYq99RH8GtVUtty6XoUtMaqtrBfG6+8OB3Z3uiF8c
	 vt0Fmwgf6F7echhp+DMoAaP155dwsJyWmGx7ZE4k8+g5FDOqz0EfqHHOL0gCSpXfpYWe2
	 6DbHebZPOBjUTvOFgoHjQ7mu07kCHRtZmRgp3+QiHRIhM3oqTI3szaV1AQCng9MGf8b+S
	 gAmA+zpRTuz1JObLA7SCz87O6GaSKkQ/ERy633TaoxHQ7NDCKmmku4K9W5MqQLitkxbdv
	 4Kyj+Htacgt1/crUUWeKLPHacon0gwm8R4BcduaqspCY4zjFLJ49Ejbq73XE5tx9AhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640759;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xhefCx7KNy+llkhCuRZ9UrKV5SXJ8w2e2gQbdtK79BY=;
	b=0c9Fzrzmv+kz2NQrTWjNt+9+6eYdYuOR2qT0w6gsN+93ri1E21+2KUCQsZecwpjMXAvW
	 Q9+d6kMQaKxxsDaO3wqE+5heEltmKILgv2eGzmT1lDeNmihQiQlFYnXZtF4WKCw6v38fh
	 P3tk0PtsvmI7qmiTSuIlxCsIg6qzaSOKgmPoFpgdCwDeg9tt2xcD9t4SXIXqvdH20Vc7C
	 QzAslddxYf+3Njcfiert4CyKI2MFiXi69aMVhRBUCjtSGy6XVACdwcD8+VoGRXKT3rmYu
	 LHf1JsmvuM6L7IfavBgdabKUhGQW/Lx+TntyIkkAp9ij/ekI2tUqJ9hPzvs9ky8bT1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0xFBTnk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF99606A329;
	Sat, 14 Nov 2026 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0xFBTnk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96B61F000C4;
	Sat, 14 Nov 2026 07:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794640759;
	bh=xhefCx7KNy+llkhCuRZ9UrKV5SXJ8w2e2gQbdtK79BY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D0xFBTnkCwRC2fRMptmAUYu8NeBKDBg5U5BVwStFGmvlNPBRms43J8JON90yPx1VG
	 13xakdcHO4MNcPz5ygBWka/fqJMV10HEtFAyb4fZQ0O+Qb5SlMjXxlVCw0sBvLqIRk
	 bpmR+yolV/nKivGNYxYxB17/0l9DrUY/zLQMSsjzDz9WE5dczzxQtRnIhJ848AgV30
	 ZiKy+Qv345I7JPij2XOMFFVrjbhp9jow/fxMqnC3qI1s09VSrIzZ2mD05uihkIrF4n
	 dBMjVH3v8aFeMq+er675zxoA+IEbkkgmmmihladBMP/ys1Imepu4Gm3cY9GzdnYAzj
	 uf038xHkWclnA==
Message-ID: <sashiko-outbox-214252@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/22] mm/oom_kill: compare OOM constraints against
 common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: linux-serial@vger.kernel.org, damon@lists.linux.dev
In-Reply-To: <20261114070959.3490008-16-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-16-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 07:19:18 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Ordinary allocations reach only common-memory zonelists. Compare policy
> and cpuset constraints against N_MEMORY_COMMON, so nodes outside it
> neither make an otherwise global policy appear constrained nor inflate
> the constrained capacity.
>=20
> All memory is common at this point, so behavior is unchanged.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114070959.3490=
008-1-gourry@gourry.net?part=3D15

