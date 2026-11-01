Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793556331;
	b=mj9Tvv/V8ty6eK1aF5mqgHcHNN5g7tj0DXP5aL7d5UY/OftXhnYDr28mFmc5V+QyotZ2
	 mFf/Tn9dXPuBnd99JHgMK2kGjSJrtZj15GK95NoEmhbrVPh+nrBa+1ZX04x2jVtWOqHCz
	 j366ZN+pII2q/aMao3w6uvspyauVcg2zkSpKfF0tZ1Fb0Va5eUesvJos35WX2JzGfktXk
	 VBif3SwrkCWGxqzSRBbxpReCGm32lOS1/tV6A78dRuFDyJrlj+pgxudFqFuxXMw9/QcjP
	 rUMjFHjMACYjAyVVMv2NlX9cARsRSo3ZebKCs8wF5y83f1eG1RdB2bA8ePSskzw69bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793556331;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=X+1AKDFm71wP+91bC5hpzyLfGPQpRXRd8C3OdbPu+oA=;
	b=fqVlsE7gJptnNbVGphWfuLeZ35kkUw6kmB9ZklcI4m5TBonHs2iFUAAQiFdXX/NrtlNG
	 ns9AA9CnPcmsjXoD7yL1+GSHGxodSKWwxClXq8x5JhTAvlY4I8x1ROSui3ayfgvTSsqTw
	 5nTm9BYJt1CfmkMsDJbVBsa7Pn/vLxGPWOrClo2oVW1MKbEvDte/+mvu3EZ+t97ca/Zej
	 Vzk3P2I5cLBUy6T78FFZfcPLiBK+KY/Sa4l008k5gkjIKPIBEKp2TGaUzgd7icMJHZzt0
	 g1KAtptcp4oDsMdjKfxH8F8gOhDM1XJfVqTmAPXxNdw8asq1bV1pjaE8xSLIt3RPO8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TN3BXlky;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541BD606A324
	for <damon@lists.linux.dev>; Sun,  1 Nov 2026 18:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TN3BXlky
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741291F000C1;
	Sun,  1 Nov 2026 18:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793556330;
	bh=X+1AKDFm71wP+91bC5hpzyLfGPQpRXRd8C3OdbPu+oA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TN3BXlkyo7JMiNCRlfQ7BZzEN7ecdnv8JM8t+fjwNBkMhg6e1h4PkpTLU8Ag8B++a
	 le/sW9idig4KlkzTeMzSTRp1E9gq12JCp5CsvSeDYP60atukbSa8eYemlkFbo3nYX1
	 2kGg/KPO8NUK7I8ADc8U2/TGi1Me+b+k9Nc2kSm7Q7n8s24ENbV1u+y+dYxW5BROJp
	 UmVcD1capDVA86LwRBNx54RaOGnWyAhqDmL0oMFsGdaqOQdQbh0tR4sm8VXXz/dkOD
	 wSwCkJrGpjUiCxw3bZG638yZFQMCERepssTP+h1J/h4gCRtPqn5WWl1qFogTvsMdox
	 hFeZ7Mm5NR9wQ==
Message-ID: <sashiko-outbox-192557@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/stat: avoid overflow in
 estimated_memory_bandwidth calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Guangke" <gkwang@linx-info.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261101180001.167198-1-gkwang@linx-info.com>
References: <20261101180001.167198-1-gkwang@linx-info.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 18:05:30 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> The calculation of estimated_memory_bandwidth computes
> access_bytes * USEC_PER_MSEC * MSEC_PER_SEC / aggr_interval directly.
> On 32-bit systems, the intermediate product
> access_bytes * USEC_PER_MSEC * MSEC_PER_SEC may overflow before the
> division is performed.
>=20
> Fix it by splitting the division into quotient and remainder,
> multiplying each part separately.
>=20
> Fixes: fabdd1e911da ("mm/damon/stat: calculate and expose estimated
> memory bandwidth")
>=20
> Signed-off-by: Wang Guangke <gkwang@linx-info.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101180001.1671=
98-1-gkwang@linx-info.com?part=3D1

