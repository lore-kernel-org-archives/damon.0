Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164032;
	b=PmTo4RgqLlFNUwnaqKsycdw5YISQs0N90NnKwDXFbXghIobIeY5oTabJ9r+6Dqh7T7bT
	 1mHvsmgex4BoxTRiOyTy7i1YSXRCxZhKqLfhGkEvIV0IbSuhZZW5VBJtS7XZWGDnOOytJ
	 QUzNsCE2EOjDiTXR7BO6ecBorlh4mnVTN9JkVmLbhR9ompe4LR5/v+wnLnb3HnhP4I2WA
	 cPEsLIUITzVl54aQODw1PPEDVB1tlW6r4VKKZlJ9e7m+a0uO8zNTJw/ob4No1B46hr1nB
	 hZoaQq+LSoJbY9uSsw6SO9T+Zww1BATm0xNSypVal5hlasvRPMffxSDQvJkI9+TJMAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164032;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iEq0dvI3niER9Pjv8HvtcBKpE9ekMrGDmjPkt4Ul9Cs=;
	b=UNutR6rD/mofkVZ+7DW5IC1D0Hag66Q3Ik9jtHg6SXp1MTND2P7ua91OLZik0uVgJig/
	 pJCAKdxRjk1+B9S5LVQW8KQCISGZALm33Mgi4P/nI43yZL8xoPoLj5cHf/htJS7DfQDFJ
	 iPGw4HteD1wJi1y+o28MEvv+kmrm7h3o2CoKqJckKUBEH8/vombURAanJnDxZkYD14Hev
	 dRwN1PjiibxLFGVyeZEbL/0aBATTxAiLyIZgWiLUkbubcPYDl1ZuModfoO9IMsXWrIJqs
	 jS0oaE/SYlv+eJQRaWotqGNvcKnL+zAVx8E7I/BPVeZ5BPELylSfdmyj9kRgKjht2zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eN1S+xwQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A881606A31A
	for <damon@lists.linux.dev>; Wed, 28 Oct 2026 05:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eN1S+xwQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55821F01828;
	Wed, 28 Oct 2026 05:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793164032;
	bh=iEq0dvI3niER9Pjv8HvtcBKpE9ekMrGDmjPkt4Ul9Cs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eN1S+xwQfiMHfr+OOeOWWcEwK+4t5bzkZSarERL67ViyOxBPMepkjPNBNYX7P9cuH
	 LEXuwJU050hcpvBaoOEqbhFgeVVKCGIUFItN/Ggvy/3drbT1mS3gMs3I2rMX8Tb5GQ
	 4KDmFYzwYSGxbKVzPxpcnlorGNbV5tfvcczwfXWaz6/HfkNw0Lw5n3oCLicdCiKp/6
	 gPDeO9dITBqsj45hh7h7sZGxUiWRWP1eEjsKox3H9rtnWgsdFMMdYTCxMBmD82guQ5
	 TreBY1pvJQYb1ZLi4SssQW+7uK3Tnoh6YT0JC66VnyOJvUHbC9iH3Bgx1moALjpSh5
	 esQHYCgqyLtYg==
Message-ID: <sashiko-outbox-187502@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.6.y 1/2] mm/damon/sysfs: put target pids for
 damon_start() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261028045902.148624-2-sj@kernel.org>
References: <20261028045902.148624-1-sj@kernel.org>
 <20261028045902.148624-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 05:07:11 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damon_sysfs_turn_damon_on() allocates and sets up damon_ctx to start.
> If it is for virtual address space monitoring, the setup increases the
> reference counts of the target pids.  After the setup, the function
> invokes damon_start().  If damon_start() fails, it deallocates the
> damon_ctx object without decreasing the reference counts of target pids.
> As a result, pids can be leaked.
>=20
> Fix the leak by putting pids using damon_sysfs_destroy_targets() before
> deallocating the damon_ctx object.
>=20
> Fixes: a61ea561c871 ("mm/damon/sysfs: link DAMON for virtual address spac=
es monitoring")
> Cc: <stable@vger.kernel.org> # 5.18.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028045902.1486=
24-1-sj@kernel.org?part=3D1

