Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968944;
	b=tlA1oYCx5WWtw2JoPgARRGq980cgaXvNX0P4xAMwvRIzip5NyST4iRBODYJ1JeLITrN/
	 IGeBwHK2Q1J15AEFsbZHVH3INB11N/gXoNyjOtEBb//pPjKCo8NC9voZmMCVMSWYI3rjL
	 pdoUfJJDR0WTZRRXQyi4yi3Ni9xSydxaFmXDHdUOGZ0GWCpu8SBjssndPLvl2cKWb/A7V
	 5ekHKQMdhodNtsflTS5duAhfmAHSqy8sWwwQionADVB6sVwNKZWv9h0ipc0k5krYRJDsa
	 cpCpN5vjgpiuMjiTYYqkK7W1wHHMuve0gwtQCNPTyfa0czcciy4bax3XQ+oEVj5bwhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968944;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HIMGfTZKwHX+gc2VlVoioQTVZKChsOf/1srqxBxWZtk=;
	b=m48KBP9Lxxhmq5h/anv6jgzNMzql+x8oOoItGgyGbl6ahTUDVCpU1K0whMcGQX6uCIJC
	 lTUBkE+ZxYl6+Tp6LJcdG1Pw9RvzumZheHVMrMdjxwyr3luTC2kadtXXhGBuqezMnOkpc
	 LvKddbVBMyYMwAirvXfOKcgVMMTX20355UHAs7jJy2giyRCwjasxR7qMRi2b/IPZBjf4k
	 pZIgucQHRp9J3kCtfszNESx4eZjJWKlihUkIEXvk0DJfxsb3z7EVPpBVb4pXd963AhU9Y
	 SfuLbRakhrQPTf9mMQNncIsz0UIRbjDWCrCmCz2AY/i/0fZ4XqLJHMjvdsMrb/5s3ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SEorkUHD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963FF606A325
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SEorkUHD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45341F000C5;
	Wed, 18 Nov 2026 02:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968944;
	bh=HIMGfTZKwHX+gc2VlVoioQTVZKChsOf/1srqxBxWZtk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SEorkUHDaP/v2pzx8bBohLvoZu2Xqp1tf/OsE5Sgw25Oefz34hyaLtK2d+FrUz4+X
	 7wL2H4Xu83P10atCRR9fPWqNK0iPRdtQm8OA3+G6e3OxVFUajdnsJ1DOsnMmuME8e2
	 ieCBp/0FaOEXD9aV8JMcG+tJtKq8YUfGR26/ScH1M9kQR5IAoJqP1sTogQfUl4DdgY
	 I2hi9PTf3bbBf0QvuDJhkjbgR1w8fnFc3waPUbfo0C9j9D2dkNuhS7oWQ/H9+wXJD1
	 TLoVVLHUaPDmnIUsme8sRIiNTYiE/LCEO+qMEyykJw1o6Hl2zAzBsuEmE6K9YbrjWs
	 XXQYpYGza2JLw==
Message-ID: <sashiko-outbox-219955@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 25/27] Docs/mm/damon/design: update for user
 report support
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-26-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-26-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:29:03 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON design document for the newly aded user_report type data
> attribute reports.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D25

