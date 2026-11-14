Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640813;
	b=Ty8aIhzVUibvHRCE3fQLkZt8PO/32qIPHIedLsv3bVlgA9S70+19VT/3vRlRwZGxU326
	 /hMlOd6bmZ3X/E0W4JUDlXVlig4gFjhrq40KpX/sQWauiO60sCpiS7tNzGjlzzg1izzr2
	 kss9AwFQWwM3gXtu5FTqWSa10X/1rsSofB+/HouQ4A92K7ajuU0CPggR3pUwOvC09SRw6
	 +mvpMprDdn0J69zsCIvTHFjn/AYoYkNz7y3N2uGA1KrKmjYJJp8sX0QBu49HXtxj3pE37
	 MS8jLK9tIcz3lBN/Yy5jp9uOdmuDfoWTZUHHpVJ/IOqhMtGBsnThNJEWK8hQvBFUeuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640813;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JeIcZpTFmdwsOHEynK4fz9/NUHIjOazszxXVPkHNK4s=;
	b=y/Kcb8PdmiVzGQ66opB0E355uwAh/giEY5qHaLX2y24CYnbUIM4y8xjjGflF+e7Mqsqg
	 IuQBPV/MHH1Ytahcf0xy4cQlkRqlYktTt2ljmF95Y7CVeGAMUAuxuTZD85SWRfPZQxYeA
	 05IkbhZZNHBhTdbSJpch6mLK5jbXSapq/SiyG7wwQihTkiN+diCnr5KT21SbmSkdDpjs9
	 KzDS1ENkXnSh0EoRUaCnlxEk+Ryo7IDobXq03BKMtywkGbSsfth0SqBlyaJg81eymH15S
	 L2aVGRmNu0ECrZyV4m60UnxDt2ZRTwovLsQVAjGD97w63O/OMx/lbhRuohNREEpssTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KR7A5QR/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F48606A323;
	Sat, 14 Nov 2026 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KR7A5QR/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8F31F000C4;
	Sat, 14 Nov 2026 07:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794640813;
	bh=JeIcZpTFmdwsOHEynK4fz9/NUHIjOazszxXVPkHNK4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KR7A5QR/RKG8Z+y3jl/0U5Aw71t2TEMI3xBS19EC+O8OhbzLE9vHZfYSsBWQ9Lxf2
	 NLQskDeQLNDvuQtrMZZrhYs+I88F9czeQVvq1LWlvFbFNyOOvm3pKbSFdTtxPnop/u
	 IwMrepYIkPfQw5fdAhK0Z0tBhQKS4ZBkcUk9DQmVO5aybVtDcOvf3Cww75vIz4wvmt
	 CHgv7Usd7sfHxiFprS90iHQ9AWwIMwoB35N9bchpNqvrtW8KhGjMTVyRtSPu7Pbs8U
	 ernU//9xbw2zlL0KEa8Fy2xWRAt/GpbquOT3APVwbeoich2A92FystfKhdLt6QmBoL
	 iDGqjX5GkxrtA==
Message-ID: <sashiko-outbox-214258@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 21/22] mm/khugepaged: base the recommended
 min_free_kbytes on common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: linux-serial@vger.kernel.org, damon@lists.linux.dev
In-Reply-To: <20261114070959.3490008-22-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-22-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 07:20:12 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> set_recommended_min_free_kbytes() reserves two pageblocks per populated
> zone to help THP allocations avoid fragmentation. The reserve serves
> ordinary allocations, which use only common memory, so count only the
> zones on N_MEMORY_COMMON nodes.
>=20
> Every node with memory is common, so the recommendation is unchanged.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114070959.3490=
008-1-gourry@gourry.net?part=3D21

