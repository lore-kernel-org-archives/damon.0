Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795727564;
	b=eBsRY37DeiQTdqFtuODUOpVaSoeqHtUv+8PYQm6y1oKQbo60X4oOLphCBIp3VyjT9JDf
	 PL7e2putMoCTnSAjwPQ6C7DhNO3981MZNWtjmfqFLArr6yUqIXXXPKGB+XMX/gKwzYbrc
	 1VkUPod8Vrq4pH299I10zder0MKilFduLGdJbG1hhERtEtJbMzGOgZHrdEEIMeAjt2yKS
	 jcurIKIrHHQfqzKltsd+qCQr8ZtoEWQ/D+RvGVJFy3w6IlIaH+8rxhm2U+wFsS3FgVtfK
	 U2rLTRt6Y+W99UTRboGSa7zFXvoi/YIwlx1drAncoriOIfXoUIxvGqi1dCcv6s5rzAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727564;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A7Mi0+BMQa++VeA9/a+piIjLNDc8IssSZ/lk+BxgSGU=;
	b=LvVNqda5WwbnEpQ3ny0osLMJI0XcrqTYZLJVJKsUhksEXwJEX3x22Mt3dkioPy11kq3i
	 VTb3nTLxSFV2FfDT9nhochBSXLU7p9UzyFCbMTYIP+aUV2YodUD3xDJ5TeuJJXfukPbL3
	 /VI3ODpd1dmU9itP3bcMNBnDuUHThvMR73193sXZuJ6F6CD3pYuqpkzZxmCicFWXTJB9k
	 P17zEKwlMSBAjMVyICyjlDwrWjMY9ZVZd1NrUPcDbcTL3LUpQ7ZI7eK3paVxB7dEGjhSE
	 81rTBI9rg0BqnV4yoDAh8Pr4aKDIj+l5gMDyyZ6KVwsKe6AaW829VTrcUPr9N+I/qrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXR+dlI3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B542606A31C
	for <damon@lists.linux.dev>; Thu, 26 Nov 2026 21:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXR+dlI3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7569D1F00898;
	Thu, 26 Nov 2026 21:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795727563;
	bh=A7Mi0+BMQa++VeA9/a+piIjLNDc8IssSZ/lk+BxgSGU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PXR+dlI3ehi91ZunnIuDZlG1hekIASnQWO7vRXYsRafb5EERMGSgIfrozEndAOPd8
	 Xvw2gzR/zy9UJ1TcZMRc8uK9EjDBcy4VFiWndH1Y5kmFNnGUzehkVUiJcHzPnwvR3D
	 pmeJ0S9GbrVKnGTRfHGR4Ve+lAVINaxQ2gD+V6ej7MevxCu6RXGLpN//HOr8wC1kAW
	 yJ5UuOAWKgyjewPbRk0fGSGSKNsCZ6d3T+Ug5EA0gqcgfQnxUD2unf95P3Bkj5iknL
	 HCYSWe43O+MATNNv+XaSu45OKo+4V57X9AIg6UutB9GLYXTurC6X6bsXnpakU3lM7J
	 SygjWxqIX4LyA==
Message-ID: <sashiko-outbox-236217@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 0/4] mm/damon/sysfs: refactor state input matching
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261126210619.97634-1-sj@kernel.org>
References: <20261126210619.97634-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 21:12:43 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Sashiko has reviewed this 4-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126210619.9763=
4-1-sj@kernel.org
