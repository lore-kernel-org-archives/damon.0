Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842198;
	b=HR3dddpsarIvF88hAS5KIN7LokgbDAXPab/5Sm0kal0l3N4KPUVPye1DT0NwOCyTXr0B
	 xiByKTgIuqdbU+arEfadD6DgF/LT3zr3ULug5YEx/5mDzJ+M17P0RN46LX2WJnfwDCXPv
	 TJLBE15yr/9xn+01K52l9W+/s4OpUDuBPDwAjhM2VUABNlNDpNFL5ix8gZBlArEPxBSTV
	 UguUxiQaa38EtfT40Uw/S8R1CzKHOsefP8JQXGci5RawuA4MYQurCap4/EoOiQhObKzS6
	 u8t2b3euk01hi1RnAfOnrCZJ5CA9Arqr5F6gABnSbE0g2tkjqqEBKev264pqJcn2QzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842198;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3LuavZJ3iQnK39rejxEoyB+D1tKZrDl/PQaChyGF4KQ=;
	b=tHBSYSBKpsliTLmHU6Rp7RYJUwjoqY8DmjwoLPxR6T2xHe9QKBBw2u1BaUt96yPJpDej
	 PRJ3tHluPZCvN9adYmxRI0Rg3n3gEk+19tNOW8vtUDKgcs0G0cXk4DPE04Oy1DcnaJyI1
	 Ek4u+wYgFswwva8gc07NyIo9+wM+Gr0Y+KYJZTYFbUG15QANsjPyHtyS8xr0tAg+bX7l9
	 4+hB7LvpOmrJhJB8skr7rcx2dCeui8M/C7NzOAWUNlqGc8IR4zr99dZcb3rZl6IfFWlEZ
	 XaqNU4jKzp10Gwmz0mQJOPfK3YmCLaafA4pFqd8vP6SlkVbfDHuNuclzxB2iB22Fg7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BpXf/Jtj";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32B5606A31C
	for <damon@lists.linux.dev>; Mon, 16 Nov 2026 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BpXf/Jtj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581E71F000C4;
	Mon, 16 Nov 2026 15:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794842197;
	bh=3LuavZJ3iQnK39rejxEoyB+D1tKZrDl/PQaChyGF4KQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BpXf/JtjR91M/tVyotVjwFvLNDSsVXHT3wjcoq6vDObQHwKSdXq/iCjCz06seoCDY
	 qvRz67p8eT2SnIIGwWav8zk4FbiJGCipEoUxEwr+MHCcTkUpDl8qOJpvMnkmO7l6W3
	 WhTkae2G+KUtPfmDZTuBaRIF7MXV8HI9rJr+x8P1p2ZzcSd0lT1AyRzcON+5/JMjcU
	 dusORXngu7q/C+YdkWBid+NPvcZgzFvYUrsVknKroTxq0TVKC/Y+T1VyNHwJxoWyuh
	 a0Ohv7P9OBQx8m0L2CV9mGS5f2OZdW1D27hUpppCP6PR0gZUblK5WCDSb5butKqSlZ
	 YUyuUq6ElDU7Q==
Message-ID: <sashiko-outbox-217248@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] mm/damon/paddr: add KUnit tests for addr_unit
 conversion
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261116151057.81692-2-sj@kernel.org>
References: <20261116151057.81692-1-sj@kernel.org>
 <20261116151057.81692-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:16:36 +0000
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
> damon_pa_phys_addr() and damon_pa_core_addr() convert between DAMON core
> addresses and physical addresses using addr_unit.  addr_unit lets 32-bit
> kernels with a 64-bit phys_addr_t monitor physical memory above 4 GiB,
> but no test covers the conversions.
>=20
> Add a KUnit suite for both helpers, including a case for addresses above
> 4 GiB that is skipped when phys_addr_t is 32-bit.
>=20
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116151057.8169=
2-1-sj@kernel.org?part=3D1

