Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794969210;
	b=OzoJEP2nMBl65YEZhIZWQt+loISr55Mchw8xe3+tChBs3Zaw+GY474AxzUhZzDM/7a4K
	 W07fr8k70S1+wJb0uRHC09NLKeySZ7Ge1HKX4gtW6/jztDVm0H5bmjCfYZB0ATvzpc+cv
	 IqVLlV7xAHTUNMwQ3AA0Zt4ismDCbkzZbrlRn2Ed7oATXbdmzb+YfgZIxzcCL61J+TZcL
	 QH0gMSmZPEjJWIQXMfVessxx7uPH+E15wrrERaoemz84Qbynx2FJ16/6pdk2Z1YKMrZjz
	 oObgF/agnBnVxow2RC3bTa+LLS14EoJ4IWhlfxSAG41mu5JOmEM0GSeQgv4Fbxt4JEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794969210;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nOcz1dXoYzgIraKXu3f9hBBfDTKJoKN/sPEk0otm5TI=;
	b=2AtRpMPcdPhfprgj4REL3+rcM7odEF9x25txBtkcmyvjaLXpaja4kd4BEXCtHc6Cfj5E
	 2EipIcTUKXwYRVvYbZWjiVXlfW20f2EfvyZRrvrf8zPq6zlqZnI1GbxJMhxnE87NFd/aa
	 l2k8kl7Y2m58UENV1dMnpAySHAslRwKYKdzyY0TVJPyLZ7J819X9A+Vzx+0dd0kISikkN
	 bkurOi/5ilxn/w7EMu0LX0f9TZaV4lc3GqApuPeH/QR5HXWfVOA71ysnAy1CZKHbD9VtL
	 m7A60gKCmSl6igmzCN5j3NvvibjCui7CIwTU1ek26r1p/14DIkywLYKGDqgAW/qEwbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J1dBsGf2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E2B606A325
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J1dBsGf2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1A21F000C5;
	Wed, 18 Nov 2026 02:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794969209;
	bh=nOcz1dXoYzgIraKXu3f9hBBfDTKJoKN/sPEk0otm5TI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J1dBsGf2VK52bHxMhdSvooxM/tDXoBq4U1n8ofNsf+2JEhguevD3UOKZc8QzOwQ2I
	 A3vclzjrhePlMMb1Zt97B3DWlkathAnr0XM3O80VqILrMbCLq0QHU3Dxr6J+kaKxP3
	 RkksiCcC/iIoIY6ggE2m2qU2wwPBrufFfSadBlNC9n7lsFG0R+hizbjgqjehlHKOcI
	 VlaZtu9WD1lRkktUZ9MDqcF3WqGOQkg8mZnjuBwwjNvK6SS2NpnvVj85UOWujOZ0t3
	 D8So2p9jeohxE/14Mv/AvzLXxUvZIwpn9ADPOB2kA/P3UvjJFZyYfiDGu7yWPgqUeB
	 DoyHmVr/xv17g==
Message-ID: <sashiko-outbox-219967@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 08/27] mm/damon/sysfs: implement report producer
 type and state files
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-9-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:33:29 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Implement report_type and producer_state files under the report producer
> directory.  The type file receives the type of the reports that the
> producer will generate and submit to DAMON.  The producer_state file
> enables and disables the producer.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D8

