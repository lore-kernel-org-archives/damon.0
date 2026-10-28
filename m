Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164763;
	b=pGbSaTpiauTfqTsxhkMXobkQOWIBwY74j9tB2R5nzkBuairkzH5RUv2iKGoH8Ya7sfT7
	 Z3xO6brW6aRRhWAuVHq78FubQeSfiUmbtFBhtC9FnQEmS8bb3UgFDoMLzd6X7HKlcV5V1
	 RykmhGrega3VIc8b2c9RcafBkqHhqoB9fepThGypdZdKIxZkgyY5Ii1R4GYX9nDfjd6jr
	 9S+0qc7JKJgJ67F7dSiNyRLX7J9mmqbx5i+w9gUJuKkjDlTKo6mwFHx5Pq0kkWepZ5dRH
	 BKUSf1mfBZpcM9Lx+v5uEQqEpG4u7pmCROTE/O8TL3Fvwi2kzki8klFZwL23wUxrRlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164763;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DzF0qfIr7AXTXw2mV+xWG2F64IstHy0Yokzd0VeRIqc=;
	b=3bRih6adWLFByUc0facDu20mwW8BwavjD6bkdtrtTJty50NPpamZNJeT/I+14HuIkGr7
	 BxFNINEXyrg6y7H1/my8PdE2YFiu8gd7NNGHkjEhVJEtkJamxp/5U/C4tpKTnlpZFQj2A
	 6G3yJnISgwciohHZC+ek/+WvN2gpsXscZ69QQUaOTBGMVN8x5hcx4KDdk0Lh60aLfjKzT
	 sOA4QfuGjsEfbRmb70VlY+WMvqPr2tqk1G+j1iVg4KS/OKXW0w7n1oGGuXl/iI3Q+aRCn
	 FXIu42H6//95WzdPj3K/i8rAzrXJUuGQSRCCfuKu66T4yPfxlCfHPfXfb+a33oA0SyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHkDd1Ir;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6704F606A31A
	for <damon@lists.linux.dev>; Wed, 28 Oct 2026 05:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHkDd1Ir
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1481F01825;
	Wed, 28 Oct 2026 05:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793164762;
	bh=DzF0qfIr7AXTXw2mV+xWG2F64IstHy0Yokzd0VeRIqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jHkDd1IrQgUuXKvOe5UKx7Gc7Kcx/BT6iAj/EkIqOPlEPqtsp1DJhz8rLoKWx5pIr
	 oaTsREZ3xxalcF+AE2CYKAMK/x4sPLt6kauQAz0sz0ct5SZS+l7gF2AJhcJPzaBrJl
	 LLZW1CDQQa8Dpiqh3AN3k8A8exwvRclFolDnzQyXbpfrUEUaeeNUTzCStkCtZZ8Vmb
	 vIiqI+cpyRgiOR74OkyC9Kjvl42p4TwIJkiJZc3drbmuSFA+zZj0YpMyevqjH/SEJX
	 b6N6efvml0uUZiQmOyU9lndderEPtJ9oWdzAXgaXcA20u1Pyhry87A6HUC35VDs2eU
	 2oYo+oTI4TzgA==
Message-ID: <sashiko-outbox-187523@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.1.y 2/2] mm/damon/sysfs: put target pids for
 apply_inputs() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261028051104.154232-3-sj@kernel.org>
References: <20261028051104.154232-1-sj@kernel.org>
 <20261028051104.154232-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 05:19:22 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damon_sysfs_build_ctx() invokes damon_sysfs_apply_inputs() for setting
> damon_ctx object with user inputs.  If it is configured for virtual
> address spaces monitoring, the setup also increases reference counts of
> monitoring target pids.  If the setup is failed, damon_sysfs_build_ctx()
> deallocates the damon_ctx object without decreasing the reference counts
> of the pids.  If the failure happened after increasing reference counts
> of pids, the pids can be leaked.
>=20
> Fix the leaks by decreasing the pid reference counts before deallocating
> the damon_ctx object.
>=20
> The issue was discovered [1] by Sashiko.
>=20
> [1] https://lore.kernel.org/20260730040740.140836-1-sj@kernel.org
>=20
> Fixes: 74bd8b7d2f8e ("mm/damon/sysfs: move targets setup code to a separa=
ted function")
> Cc: <stable@vger.kernel.org> # 5.19.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028051104.1542=
32-1-sj@kernel.org?part=3D2

