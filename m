Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774771;
	b=ruOu+gxHWMXU0CE8lsd9CDrUc9r6JYamSMgUV5nPAqHqvX+4mmHiHCAOnku2WEXTIQbw
	 wz91OOgw87liO9ganvN0iE16JqkAw6I1/w2nhGVTPJ9Mu9doJ3OafW9+AI79QlQejcn5m
	 MHTFh5vzuO1L9IMzfddAEi9zWqiREEZ9Jqu8WL1d7Ns18xGXJWbfRG7/2j/x2mpRAmuAH
	 BHjsDYwX6edhQ18AdOj25vKnW9B/VKcYWo9UqUf0sQ3wUGrdWuXuXuNhF+BSJTydFbwvL
	 Z+qPAeqAe84UDhr1AHc4LRrdCNieg5o1h0oj/7Z7x67eDfQhiGUq8YalwMZiPmgHgaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774771;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LnXpOczQU8EGwtVEUJZQUO42G6rnVOcm5OKxBv3knFM=;
	b=b/v7criVaBG1mr1TrXqsaOdqqSGtqoXxQl6zTGJhgRtpd+mpv+iwtmv4bhAvhc06/Llg
	 fUtnSxXDdV3UqoOSqROgb+13FdoMP5UFyhUPDD/I+EhFGYs2D8vFL0znuVHoxVzWMC8NR
	 XaI+/R0DcZFs5dViEfjL1QitPfh07Rg/W0AzvOi5+mDq/5h1dzDEDpoMbEt5RDP2e9W0s
	 PvtxMBmRKAHY0QesEHAZn1eXfREbLC8BY+eKBSHzr4d328Jh8mimo5xe+2Uwa5KMWX6H4
	 wis6Ff0y2v08u8rHrOMV5rxAQa33KaXd+s7QsS2lBBuIoMqfW3Srv4cm3qrfqcV8TzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ur+/Neql";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B43606A33A
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ur+/Neql
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6AE1F000C4;
	Sun, 15 Nov 2026 20:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774771;
	bh=LnXpOczQU8EGwtVEUJZQUO42G6rnVOcm5OKxBv3knFM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ur+/NeqlQEkC0wUZhdB1tDFf41jdZXPyeW90UWRQ3l6jxKNezBRfTAbaXUDb6Qp/u
	 AtWoo0fIJLCuCcHL+W/+Ahs2r0aKKLFMzh0zoZ+YUjj0u4e+fWblHgslxGDI9f8aXB
	 b7NFV2LxzTmauuEJ6NxLpA57+VWuXltReNUxAIpeam+hVVbKVPzHCU9nfvZc3o6nN+
	 GFviY4wOwWEb+8hvlYVwsCg7gDplv1DXMyyLMnXkp9UQKgN09wP8n5FMXb909Gjr0S
	 53KDDPsJoVhngeHPypaOKtJ549NIDqgI+dPiL/51tGgu5vd2oNfS58DNVfUEHqC2pn
	 KFdVIBBz9CMbQ==
Message-ID: <sashiko-outbox-215829@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 06/27] mm/damon/sysfs: add producers/nr_producers
 file
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261115202849.99134-7-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:32:51 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Implement a new sysfs file, nr_producers, under the producers/
> directory.  The file will be used for generating directories for each
> report producer, in a manner that is similar to the nr_kdamonds file.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D6

