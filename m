Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824381;
	b=uchUxsUV5kxxForuJ0WuMI7L4Z6ZYerURCh0y4MLOsqcx1NMFwat6eA6bjM7Wx1pBgm2
	 5fFfIA1vjDAG5iwNI2m4iiDP4cuXdToKGeUUDPvEdWXG7Powov7/ynViQgQ00nI8KK8za
	 H2BUc4/vwwWvlfUQCvMPSe/BytuYr2uTFIktkmVDWltW2Burq9mi9VIXWYRQlK9G+Cn+O
	 c/XQryBEggf1D90wUF+szPXMdcZ7cmJgrhqbwgh3MtDsHN/0XEg/cZHWpG80Rb0px3jPF
	 xEbkcoanO8pMD3CA6kAs1cCfc460kcftXcBNXconIA5kNBqWcveF+GfXG3aMz4ALS9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824381;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yktu3xGck7lc9qxFIiw/b6zzhB33R8OYjzoKh/tPF2s=;
	b=O6jKv/8V86SSMFGsHaMIMT/EWd3IOcFyXuoihe8SvfIUkGCGwq/jbRpXhB8xCnYACKtF
	 D5NtORdivc8uB+xn3bp731qgX//IzXuK+L9D0B9uZAj9fdZhyunGphjfNeUjhUkyychyu
	 Lri7Sb5p2HDhbyambqQAGjN1LoxhsOE86wMzGSf5/s6LRsk0T9aD6mEPqfOIOQBCeVLYg
	 jZ6fp8yrrUZMjVqHaHUOzN1mmwRgFmtrsGLkG1k+ngFvgXcCfrc69vewAx5vR7Uuz9EKb
	 Jw2qw9LFO6SUjOJiTKKsHNst5spoHd4PWgBOTmFCk5v8fRfvaGMLuFubigc4ssbr8yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iR92ahSJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354FB606A84E
	for <damon@lists.linux.dev>; Wed,  4 Nov 2026 20:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iR92ahSJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52CE1F000C1;
	Wed,  4 Nov 2026 20:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793824380;
	bh=yktu3xGck7lc9qxFIiw/b6zzhB33R8OYjzoKh/tPF2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iR92ahSJvgBCE+8I/CzT6aNHnu12BiAovclboEU+VQU09TRii0e/xOo+EiHihO0nm
	 fQZ5AgDjGhc6GOjHeI3koyx22IZw7q2pPa5DKAFl7YOKg6JDby9ebYyDiCeR/5FAFq
	 wp8Ow8SuX4O7FHa8TKxyuXfNfbuHI/OCv5KU05K1KdvvMDFFMZpOk3kqiOCLvC7/Vi
	 WjdRoYDc3ckJwqRM+q/cIAiun1XL4Awc/mheitWNIoCbu49JNyP20d4znUZC22yRPO
	 nugRv2kRhSTIr1ZwMW9wseHvAklPxz9mRFpgYfrwvBswz01nWKPxt+i9RSsvbKv7mc
	 BKwCURnegc53g==
Message-ID: <sashiko-outbox-198019@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] Docs/admin-guide/mm/damon/lru_sort: fix grammar and
 style
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manuel Ebner" <manuelebnerli@mailbox.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261104202959.128646-2-manuelebnerli@mailbox.org>
References: <20261104202959.128646-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 20:33:00 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Fix tenses. Split long sentences thereby improve readability.  Replace
> 'set as' with 'set to'. Replace [] with () to make the file uniform.
>=20
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104202959.1286=
46-2-manuelebnerli@mailbox.org?part=3D1

