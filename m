Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199470;
	b=gtqH10cxGUtzWWPlfGKkoOgCZPwuLnoazI92bEGyU03ThJq5ui/1t5OGLYM+OwEWmID4
	 O1UasWI5+Tn0Ew9GJxZXxL6s4POFPmLnzZwfGpH6zgkKWVGmGDoRz0OkctpFr25CKI7aw
	 jB4O2jZQxid4n1mDyU1pGIyd/mAwl8E7/sLUEC0PJe1V/oegaDkU5jRREyK4FM0HeNijf
	 HoIxTnGtnT5mna1+KQbVAVl7Bp5TlTZC+ueOScdIzb+fNmmsEdDkax9osOcO0TZuKzTZ6
	 dVlpLk+QlywLT2DwJAQSSKZpZ/5W7pujpgkSHs2XX/A8bJdtWaN21TMEu7Ekny5JodA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199470;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=J8U5jEhJrpcxobok+IjAkxvjPVPQ7zGoqFGdG3K7quQ=;
	b=0xNWaQmiVxW6Fz41gPhHd+D0GZK6ISojmsRQLO+NEaGgu4qwbq9pFz7c5CKiuu8RcHJu
	 vGbaUogjD0DI2fbyK67AgB11MOb+qW7Jq8+RhNtaPy1lIIm5XzMJhiu9EBvT/Mzpys+j7
	 ESnEn8dMbUO8h290eDjMT18XXiVEVfwVtqyQhmw2CjyJxExLFbVUW2Qx3yqshV6dadOMm
	 Fn87Ie5PGXe0iSYyAPqupqtM3cfmz+3VLWZoW9dw5k7cKh2PvHpaXYB8LcIFmzx8wUgDZ
	 cDD18SX79jSBj1gM6z0uG9CtAS1KtdNsNUolsH9KtDmTFlOm2qZzgLcJJ4DngkikssQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LrcB7vsz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76442606A325
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LrcB7vsz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4B81F000C6;
	Fri, 20 Nov 2026 18:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199469;
	bh=J8U5jEhJrpcxobok+IjAkxvjPVPQ7zGoqFGdG3K7quQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LrcB7vsz4rk+/+3qgpxzmciDV/Hn6X5UJurvfwWAlgPNS8ChU2oFWHhy45+4XUspQ
	 YNkKKp+IoMVcFuLuao7jNnFjQTrs96HFgcyjR8ngo7rgObaYrYAccuY/UPgO8Syq8o
	 sPkxjy5C7US9pfqdNH1JZ5C0unoNyLlVd2nsHUpXLRVNKBCI/ew78TKe3MDYCpxVoI
	 hQjq4RjraN9rwuIVZi+d677HmSez0T2TVFfWVZou78gUt4gGBmLe5eXbpJuhDrgbkT
	 lisB7WlNXgQk9JcgsaobElCbcd+80+bq/3MErRnTJsZQaYBmbXmXAnNkFyuW3JmaZD
	 0l/zUFXSdj0qQ==
Message-ID: <sashiko-outbox-225833@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 37/60] mm/page_alloc: keep private memory out of reclaim
 reserves
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-37-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-37-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:31:09 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: "Gregory Price (Meta)" <gourry@gourry.net>
>=20
> Private memory cannot serve general system allocations, so it should not
> contribute to reserves.
>=20
> Exclude private capacity from the lowmem denominator and the global
> reserve total, so the pages_min budget and the system reserve stay on
> common memory. A private node still records its own reserve, which
> its per-node dirty limit subtracts.
>=20
> Zero private zones' watermarks. No kswapd runs for a private node to
> restore them, and the pages below the minimum would be unreachable.
> With no high watermark, a migratetype fallback never boosts them
> either.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D37

