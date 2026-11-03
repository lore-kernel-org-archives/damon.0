Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667691;
	b=dJDbPBf2h5LascJPatMyx46CtLw9f1EcEZveQsrbXE+YBGJ/XUMPfVxxmmjEVVWE04QA
	 rEkrL+nlNFq9R34vma8AoiPBPaakx+KQKwATSvoirja4gEb+9njckZVFtIWSIi1F7oP11
	 8j4PN0h6IaljPjykT4/eYF2F5S3YKJJ71BFTSB3D/iu65JfCXW7Jkq35vU4MN4JBCSZrm
	 WxxQ/pcAuq9WsYwjUsY2IZO3FGJxg75a3DOERsWunc5f/zTv5UsnYw4/qi95+pU9s8q0s
	 7O1N6WISOGZGiVaNubF27OhECt7X0KWpVJ3Dyl6bLHknICFgqLhz2BWD5pphGmCIexg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667691;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TKCm/O2OwGdXuWk6ok4aXCijJMvGssuxDlTkN9QH/1Q=;
	b=4Vz3t4d5ouMukfZTMCC/jfSUfelCoFeoApDJgnMy8x9auBgMSZ1WQl1SBGr8OfYU2jz0
	 QhQzUBb42LAZEQkJQYtYImm/bLbdVPe5HbxzFwQMWjeBVVZ9T5qCB7dgxNiGHiaGINPLT
	 j9YijIo/sp04smtemmJSqs2HdUve8nUT01iCbX+Q7/JfEHEC2KYU4g4d++WSXWHArW7T1
	 qVHtySTGwiqWshohugnYiw3w4+nu7s6cnILYcyXEuN9ERewt5FuyaoAwLkbpyBsZ0v/rf
	 NDEMxS5dumsnhaCgzqiJrUaWBZHysESwL3iHfBYbJz/vPwyrUtCBAVHPDTqAaoErYfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAkark0e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37931606A324
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 01:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAkark0e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8731F00919;
	Tue,  3 Nov 2026 01:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793667690;
	bh=TKCm/O2OwGdXuWk6ok4aXCijJMvGssuxDlTkN9QH/1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cAkark0e/S2FiB5dBTukXan5dtvEIMwsYL1o3OJbGUWOSd1kacWeGMZ+2Ijx8RRmS
	 TjXAIUtPHGc9hQIJR+VDV/gTDdxV4SkYWc8Q2KQfmbOdAFGRu9OGCCkgY/QAW/el6e
	 Zb9PL62rJP1ZTF1QpTdofWBWZkep86H6pUtCsTJ+GyT4Xt6iUxT2KMDHWqIeuOyIWO
	 miNjCrHNeiuLiwK50nRb/KTlwG8S5FbtRfHJsmoQ+VtMQCsiFuzs0a8hfeY84pe2pl
	 3UsMpjvJ3/lRknm4u/0wNAR4zW6XOtBxmyGxgThI/sZXye+iM7e7dmU9plUpF/diFD
	 FS5c2ZS9zvvWA==
Message-ID: <sashiko-outbox-194410@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/8] Docs/admin-guide/mm/damon/usage: fix grammar
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261103005940.91432-4-sj@kernel.org>
References: <20261103005940.91432-1-sj@kernel.org>
 <20261103005940.91432-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 01:01:30 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Aveline Noir <jm5905938@gmail.com>
>=20
> Fix a handful of grammar mistakes in the usage doc, mostly
> subject-verb agreement and a missing or extra "be".  Also turn "Below
> commands applies" into "The commands below apply", which I think reads
> better.  Rewrap where the lines got too long.
>=20
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Manuel Ebner <manuelebnerli@mailbox.org>
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103005940.9143=
2-1-sj@kernel.org?part=3D3

