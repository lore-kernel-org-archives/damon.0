Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640861;
	b=1B30Ep7cf3LxRxW8R0qqELGDzkZmd2G0kYae0JTsktMUP2rMJx+/lRdW/Ot/79l9Bw0F
	 e+wVO3f6pww1yqtJHpw0HKGo3sPk7AYq6UXrah+TriOoSdeLwOP6/ueO2RSjSVYS2wQtM
	 7v3E57VH1sWcsvO20QfA4lPBqXin8BDjOmfzkwhLm7cM3nZeRX3IffIzfmK6MjKTRQsIM
	 LgZQ579y4ofIqTlmTjdBCzQejnul+eC+2ANPRYpMA1IiDRc060a9eE/biMbATdTbm+h5J
	 CelMN+VcT7HLFjb3XAlu+h1NgqICwdaB1e8Vextpx6GAO5CERnY8G+4MfJqdb/8bYAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640861;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q8YuCvMV0lgBFcapQ5q6aiM0/fJeuHHoWmi4HM0d8/Y=;
	b=EXN/gSedbvovwjqN0UGkt4CDmlWqW2/6336tW80J/Ww1bSQ3SlNqvFjkmhM4M2BqjbmQ
	 vvmBo9UgyyCSbR1zW8GybEaHzbM5M81k4ujIAvKAEPJ1iuEhY3memXlOGH7YYGAblRU64
	 eoeXp5LF2EqL0hUzBMAyL6kI7T3GAHCyzYKHJYeq+j507Xiqv/cLLyqQAt2yWbs0oHWuz
	 rngWQVjNBgkw7lF08wv5vUSkRxZ03nACnh4reasIX6ypPC6k3NYvMg/UlunojUuirBaHa
	 m/CPyBx6KaPN35CalbJNJ0w3tsnLy5/x9XoSwnGnf8IGcM7Dlt1mZ3WVlAu+g4xtjMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SeLPd1Go;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DB8606A327;
	Sat, 14 Nov 2026 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SeLPd1Go
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6807F1F000C4;
	Sat, 14 Nov 2026 07:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794640860;
	bh=q8YuCvMV0lgBFcapQ5q6aiM0/fJeuHHoWmi4HM0d8/Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SeLPd1Go6TACPcVODjxC9ESdSeRh67wdEivwVyXlofiC9Ibk9W1Pi2Ch6F76ADUVh
	 7mkUv3SxOF8MMqBYmJ6UZKnTocYoA6DMDYLdXnqVqsw04XmeAS2rVfvhhtzO0Hi1EP
	 r9co3LyUZnGde/i1mdjO+kdqgd/OtixFzcFuHHLthdjxCqj0XWcLVtUEJyxGRpOvH4
	 CHUasSh6ychfxKL9fHGQs8dafiSDGuVyAVFqBje1cbeMI5e7cnna0fUPxsda7aJ4+P
	 DiyBfOH90LvZUiZ0nDrSXjfhAXxhuHzpQTZyZ0l2zzUYhqaYxqAU0IrD//hqwFqO3q
	 C/ewKnXQr/N+Q==
Message-ID: <sashiko-outbox-214260@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/22] mm/ksm: restrict merging to common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: linux-serial@vger.kernel.org, damon@lists.linux.dev
In-Reply-To: <20261114070959.3490008-10-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-10-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 07:20:59 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> KSM is an opportunistic MM service and should leave memory outside
> the ordinary memory pool alone - as it already does for ZONE_DEVICE
> folios at each acquisition point.
>=20
> Use folio_is_common_memory() at those same sites, which still rejects
> ZONE_DEVICE folios.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114070959.3490=
008-1-gourry@gourry.net?part=3D9

