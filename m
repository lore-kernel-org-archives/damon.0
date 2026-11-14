Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640960;
	b=ae3XhgIYExnDYPT1nc56LUHLY/aGuMA/9UCBkwE23Nfqty/50U1yUcr1gf+AeBDEsjra
	 sjkpvCR5mFWRMZt+KY45Weq3gvABfsH9YHCIjYGNOz1uyOPggDV+8REtCi7l8QRse6wAa
	 WAgSDP+1kio8eqhGFhRzaWlpp9E7S7Ra1U1RzgKBLpGDtcChmY7JW0RfjERRyJd0oGk6K
	 F40Fd0AZ+KvEFNz7eecvtM0Q5QoVtg7S0Fyuo6SUNDMOJZBcLfFtWooUEfwyZh3p3256m
	 mWkACspX4sOGInek8f5CuiDA+ezhoYWZqzAokvTZy2roWLZ1z7gC7RDHtlg9yKvS4dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640960;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=svxq+GFI+9RGsb5O0vtkJXygMy9usl2CZocCz2wQGbQ=;
	b=K4Z8mlhEFo0T07nF5DUFqMyS0H91VcuE+0WBPwU8klV/48GHKmijkfOV72c3Xr7YyjR7
	 3heYQx2aFC2YvSb/DDNNSbYO0Jt9Pqaicv3t3mpUlbriv0jcsnNmy2wrcaDDPf+FPTaJA
	 3xgY6zF4yN0ikdEkGcupk7emeAR1SXab4uN1sq5IqURCkua28D3pxY3BUQn+xs5zfkAN1
	 Kc4pYKpn+c83xG7Pn6aBJV5FT6FsafPDyF088+6o4M6QyunW9GXjJbojKuXXsU5b3ME65
	 YHe6FPTVLv2h9hjEHKT58N9/PFddwf8gqXMb3s1WVBXUJS/dSlaaWIVXMKqWKgpcL6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JfF7J6Yv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC06606A323;
	Sat, 14 Nov 2026 07:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JfF7J6Yv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9335B1F000C4;
	Sat, 14 Nov 2026 07:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794640959;
	bh=svxq+GFI+9RGsb5O0vtkJXygMy9usl2CZocCz2wQGbQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JfF7J6YvHzGqoUb7duGrG8F9mw7D4rJRyxzYrEkSrSunyNqUepE7icKVM5zbr5X8f
	 JgGbqRZbaun6V8nhTUi+9IUsPCVtsRRb61Ekg4rGepcAWJm++1Q4/zT9YYuSdaOAHP
	 J8ydETbMvvODaQSa0mICaxwMVefYdVkvVCEmoSlwJNnRKMeEgOpaZIqoa+GwkUvfWX
	 MCJHUQ4bq4fRIuujMJDdubKPM7LRauiipoepxtK4wRh9seDWx8+fhgVuM5HgWn+Oma
	 0hTB/dMLkTOx7GeMDQaKmHTyQtfShGNb3vKRsV/Wi4RT2id538yvqoEiiT7HZONbwJ
	 uhp9H9G180JYA==
Message-ID: <sashiko-outbox-214262@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/22] mm/vmscan: restrict reclaim to common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: linux-serial@vger.kernel.org, damon@lists.linux.dev
In-Reply-To: <20261114070959.3490008-18-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-18-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 07:22:39 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Reclaim serves the ordinary allocation domain.
>=20
> Restrict it to N_MEMORY_COMMON:
>   - start kswapd only on common nodes, at boot or hotplug.
>   - walk only common zones in direct reclaim and when throttling it,
>     so no reclaimer waits on a node that has no kswapd.
>   - walk common nodes when MGLRU registers an mm and when its debugfs
>     interface iterates or validates nodes, using first_node_state()
>     and next_node_state() in place of first_memory_node and
>     next_memory_node.
>=20
> The fallback zonelists hold only common memory, and all memory is common
> at this point, so behavior is unchanged.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114070959.3490=
008-1-gourry@gourry.net?part=3D17

