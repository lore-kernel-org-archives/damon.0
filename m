Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197661;
	b=Fm0A0igY0W2mLX7ipAUtnPp0UfLuWOlTNkxYsjafvFIihCYvs3upZroMobuJbIgi7wJ0
	 bM/OsY7I8ZFRAIxGF0Jsz8fN7OJyMTiCkkSrpYjOnUqcrLrOb+tWcOteO+0o9bbyPCrh6
	 KZtzS1f0TxG3V+BKmuNOav0N6yTmcU0Jt5IxNNh7+J1rLmQmJigS3gTEDXcfQO5mQJQKZ
	 OkgzmDLDiPZZCcSRRXCVZrfzeJaSJc6os5Aan5oLyU/Sj/I0WiCw6Uz8qhKLKn/l0H6Wu
	 vbuAc3Q+SfGRKSUxJcEOtYPqu9pVPaTPTWQTg42a3FqOcXRjm/Hi1wqFXQ79fgK2JRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197661;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LigkDYKppBeW0RPDb4xsrwlVcPSMvuxJdSrs/rqOssY=;
	b=Fr8UYOKJXA5X3yeac3V8Y7WZeG/tvyTxxxZQmchdyl6PvBIKXCDrMrkP+Z4WkewgtMu3
	 IxN+5emPIP+Hs7Sra4r615ZyTGaa2rbLXZJQd2RBognitAfUVBDLZATNN4gdtVDKMkwsT
	 oHI/89SSYo6EK+VRtpD66lJF1umj+gFjY/Fyic2RehB6i/riYYY1eaXo5xwRknse7gxtJ
	 BPyliKm1d+eAzP6wkpl6nrDocobkLAjVOBlXUaUp1MH9KWh1dF0DUjFwRvPEHMnjHanI+
	 QrvUafb59aF1EgIqpdS41OUdxU4ACy8HivDTHWFLp5MSAor+oHSLxZ+zNeG3UvvjoSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CKHqlYKk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAB3606A31A
	for <damon@lists.linux.dev>; Wed, 28 Oct 2026 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CKHqlYKk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5131F01828;
	Wed, 28 Oct 2026 14:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793197661;
	bh=LigkDYKppBeW0RPDb4xsrwlVcPSMvuxJdSrs/rqOssY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CKHqlYKkBHfxNKtyQNIa8p5tfRzjjhG2wqZ/EB2rogtTQU0K7FFW5ekazne4e2g5L
	 7XmTeNrgOpDg8TmIFuLodmX7BrcVwkXUiUJlmh4CiVWtjOyi/uVsu/SBRL59g9cjd+
	 SjYA9eya8ETJLl+/9Z86eZaO4NwDVqqNnrKunw+hqTxFta2nbHyj7khE6SMUPc2HGX
	 vwKRSzjl+2ezQjfRJgU6DsQAU5iJNEWDUVQGwDy4AJF8adBZv2hmhUjgmwXbFzVwoI
	 1FFtApSiq8bi5ce4fzeMW4DesMOwr1OUEfty1reZplW9ENVgArWuzdbyECkDwboNGu
	 MXBV1HOueFiWQ==
Message-ID: <sashiko-outbox-187979@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y 1/2] mm/damon/sysfs: put target pids for
 damon_start() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261028141723.161776-2-sj@kernel.org>
References: <20261028141723.161776-1-sj@kernel.org>
 <20261028141723.161776-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 14:27:40 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028141723.1617=
76-1-sj@kernel.org?part=3D1

