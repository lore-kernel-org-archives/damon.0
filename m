Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640657;
	b=RZ/fSC+qrctBJxlMcumfe/PxUs7SBggl6HesyOS+zJI+28UBvia/vFXwZUVaxYE2+xVB
	 nBeK7EjN7+4DtmQk65QajMyvarNurNz6JrrNXfQ6al3b2EA4WXlqQQWFWnjAw+uvdvCZm
	 VG64t6csaHFpy0GEXiyZoibv8SAG815rN9jgqAWVm3J828RCfJG8HnhzVrw3r2sTl+TWz
	 4l6v1liv6gaBFJIuu/aWqDUDLysM1fCv9AynZoGCw3n5PD6ffv+U/qIKQ9AF8Ks3RkDOe
	 cPZ1xscOcbrT0YNaEr26/bJ85lSskmQY1A70IiBVt5TIMTlTQks7EET0jVHMKcFgoMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640657;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3ANzwjkEGv32jfB0lCAOYbszeoY2sj29sBPwMUxJYNc=;
	b=t8pEucObLdu4/X4QYtHhqqzBiosMa2lCQUmY+9Oocf6shBo9NihTErU6u+jVgG+oTRFz
	 miMT3wwAmzNTGwp4JW8PrAN0yrWTmDzxWawV8aRCohi+WS5zFy6i42GpKNvFTRtE4sE9M
	 VBmTbEIKDTmea/BIEgS5pEGjZh/hzk58EBHxKhv1Ha22M61McCEbg98farn9Mso1fQ4YW
	 FACsdE3CQtduQP2WOTpkWQDnND2lIPyLQsAWEKsFcPDEo9dznAALPvZ3JI6aakER7V4f/
	 DaUppRUz5TjMzWGt+2TXdS/9P0umsuspgLWVdQh8pAs2+5aXbpESt1TjgebWltJWd2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PrdKEpV1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F23606A327;
	Sat, 14 Nov 2026 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PrdKEpV1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325DE1F000C4;
	Sat, 14 Nov 2026 07:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794640656;
	bh=3ANzwjkEGv32jfB0lCAOYbszeoY2sj29sBPwMUxJYNc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PrdKEpV1aWG+ytUx6hyvaBZqUgAaZLApma43DEhdeYROf5PtuBOzptohhoT8pMdQ/
	 SKH8L6sC2IDd+vJKtMuTy/I/srQ4Y9rZtY8OmyJG0d2LHaGtjhhwxxz1C/YQbDTzgs
	 sw32jMHRovJcpwn73hFG2UYiFoHoAebqQ7Tyf28wvkO89Fw/f6xRaVZQapeU5Z6UI8
	 I1eVIg4nK2IFQQ89XMdwL80kxRNqrTd6B8P6LkN2Ce6vBIcRDkPUVBekeVkKMsqzzE
	 puG8WkVakh3IMX3D11zXfPm+nvtwUaiw3x7J1VUSiMCwtEgTlBhEXCQYARiFb9WepM
	 hYzyQiSn/qosQ==
Message-ID: <sashiko-outbox-214248@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/22] mm: introduce the common-memory node state
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: linux-serial@vger.kernel.org, damon@lists.linux.dev
In-Reply-To: <20261114070959.3490008-4-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-4-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 07:17:33 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> N_MEMORY is overloaded with two meanings:
>   1) a node has memory.
>   2) a node's memory is reachable via ordinary allocation or
>      an arbitrary MM service may use that memory.
>=20
> Allow N_MEMORY to mean #1, and introduce N_MEMORY_COMMON to mean #2.
>=20
> N_MEMORY_COMMON nodes contain "common memory" capable of being managed
> arbitrarily by the kernel MM based solely on zone membership. Following
> commits convert relevant N_MEMORY users to N_MEMORY_COMMON.
>=20
> Add folio_is_common_memory() and page_is_common_memory() for MM services
> that walk folios. Following commits convert folio_is_zone_device() and
> page_is_zone_device() callers accordingly.
>=20
> Expose the state via `has_common_memory` so userspace can identify
> the memory available to ordinary allocations and common MM services.
>=20
> Add has_memory to the docs while we're here.
>=20
> Every node with memory is common, so N_MEMORY_COMMON equals N_MEMORY
> and there is no behavioral change.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114070959.3490=
008-1-gourry@gourry.net?part=3D3

