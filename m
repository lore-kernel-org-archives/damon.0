Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640803;
	b=nR9AidkNBgPlhLxmxbZKO1N1xlvmmP10JniHqXZ+iqKVM44+bZM7w6BSSQRqg4liJ/1J
	 p9ZwcWGeMEh71cmTYwGiNSL3OsPi3t2IfSa6s+7tHel0yZE6zafg8OFr8zy/OMQIktUWh
	 Wo8BMeBTrw6kIqiE14igeo6MPn0r7jdMlAakHeQ4PUmMgpgF8k/tZil+mYvgR2ipeHcZ2
	 5f86pCifFtKloAnvlig0Bzojy6UqSRecS0MaBmN9Wt+CCO893OCSqG7Nr2otN9vH9oOQT
	 zMGvSzxXBF2B3QGHmJZJhFZBHBoH4cUx05nGEUZT8x47CgwaM/kXWTayF1CQcKuVZBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640803;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5wQN1xCjwszgf8qizSC91EcT0EZqW1qSCAahWGGrxUU=;
	b=MpLZ9x81SFxckajI6DKWSo/JBVSsVIFcvYQ7HoVVujacPvOHB8pndu71Gi8+diUx8bVJ
	 FIx4O+kTvSLhz654YdrrUJYx6Fq3pE3KcF/ZlZRWRRfiTjQY7pQpHZDSenrgrxgipQwO+
	 pL11aGPyw3N6zXrrD5/l/pwC2cJafcVS3qmMK8H1HTMhOHTz+RyCHwQnK+KmYnQAakZZN
	 gOuHY1cf+bRyTcDp7qh4p/ujtxGXmL/9C1EA5kT/c9KaR7vkETEVyiMI7gy/sPtxguZXq
	 vIQ931ttwmnkFYGrQWBDM5lbCR++vk/mW6UtHZg0kLrETYDox6/wUtoISCEjFcpB8Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMnAdfZP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07984606A32E;
	Sat, 14 Nov 2026 07:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMnAdfZP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655EE1F000C4;
	Sat, 14 Nov 2026 07:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794640802;
	bh=5wQN1xCjwszgf8qizSC91EcT0EZqW1qSCAahWGGrxUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YMnAdfZPT7sjEvX/gYOXpIPa3qakOAXQjnzbiLtqgwtooeWoZ/ZM8uHMzz5FaaEgm
	 0vrlv85N+hW5lnqVJSqn0/EwfgGd3G14U0H8Qn89GVeyNUmtl1crxYo/sITI/ta8at
	 DhvXQTU2m831Yxg+qvAvcJiKSk8xJbZrfNEWNXCad6lroDWkirBdIN5HLusiIBLNTq
	 KLnSrYcPhM2dXxytSKqcp1MUIY3Vp2z54VwDX3nX1pXiLMGcy/IYrFFVjuP8tRH8S8
	 IsFb6KXfrpbSVbomCTrsFzdQjZ4e6eMJDEDH7G3FVe6+C+K9WPh6nEq+s/kj1/xqW0
	 o4vkIOGVenQGQ==
Message-ID: <sashiko-outbox-214257@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/22] mm/migrate: restrict move_pages() destinations to
 common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: linux-serial@vger.kernel.org, damon@lists.linux.dev
In-Reply-To: <20261114070959.3490008-20-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-20-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 07:20:01 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> move_pages(2) places user memory on a node the caller picks. As with
> memory policies, the destination should be general purpose memory.
>=20
> Reject a destination outside N_MEMORY_COMMON with -ENODEV, exactly
> the same as a node without memory is rejected today.
>=20
> All memory is common at this point, so behavior is unchanged.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114070959.3490=
008-1-gourry@gourry.net?part=3D19

