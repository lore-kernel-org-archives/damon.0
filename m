Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795812067;
	b=0hm2RyOIr+ub4hfM08Fa+rJPuMJqUeQtOGlIwN7RfX9bB4jOYE/UDm7l4VwyfRmHSisF
	 tBXyR1lC54fn+zh4JlbKRfUgqGEfcMh5JxaBIF1+U3Gs7dla4Qadm1Prsa5+pUb2afLOE
	 Q8k8+OWZhmiGQ5MkM+tZZucwLpIun/d+4ix313/qlcD+DWBq0JVxBJ7nxrGXYAxpbTuGg
	 k8DsjvBhMmFQT3chujz0uYvA7de+HiYvm9rJsqCOSRYg1kKFLGm41NlRwf26gLyHquNzX
	 yTzDCnZikTuxH98vSRlniOFahqH+oD66ZDZjpc11e9Xy0GjqBEAW48y2xOQO4IkBTkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795812067;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/QnSsinwrJ9wIM0R4Swv1HXlkWqlkSi2iQrfbAkFwl0=;
	b=M1/Ab5zmwxgVgZs9Z+sCuvCGwPoKMU58zusDDyE74DbRta47NLvXd7NBn096o6AV52m6
	 R4MuAcmcWd9x/jgEOWUrzVxBcYP+S31oWi2NYJ0ZrxCa0O68AOOe11wMzwLzUmBfb6fA2
	 2uVYKYwSZnodX4RIVLRa+DDJL7g93reMonRZiI8PuSKcyl+4Rr5F5Lzo4cQ+0QG6/bs0O
	 HketTELdsH5I8OzyWCugLpgRiXPxUGfnWlDPcgHc8YzA2azg27u04qJIhZbckan8k3ls3
	 ScO48HA/1pedo5JIbgzE0FEb9sv+4f9y5OVr37d7PAwWvOIE2DfC+WQ5SoFSWAQ3Sug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKSJHTIt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D111606A31C
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 20:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKSJHTIt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971171F00893;
	Fri, 27 Nov 2026 20:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795812066;
	bh=/QnSsinwrJ9wIM0R4Swv1HXlkWqlkSi2iQrfbAkFwl0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AKSJHTItHg4q/VYoY/AH/C/x2U7hZ7xFS6AygKktSn1y7cX0Av6tkNvgtlxHNqLN3
	 mgbmkcubFox9pJ/tInxNf1874geU8pKYroydWzVCDd0b/iA6lKX/vSwH+huj0MtqJn
	 SVSjtCSKi35PkOte+RAtvwg8PvJCbJ8UikDQsJSywXRYE2sTmHb0uNLnXFRKibeemG
	 Eef9QTQjL5WBBXRV2EN/ZlbUxQEmUUQLINnNsM0qPz9bEiVWzYEonFE0qIFvqtJA9M
	 NkW+rrmFn1gxGxhM1x8rbFEOwmipN/a7JIls7Mfms16hpY0NixHY+d4OU3k2qj1ta4
	 QkN0ezt10ulrQ==
Message-ID: <sashiko-outbox-238269@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mm-hotfixes-unstable] mm/damon/core: cleanup
 damos->walk_completed in damos_walk_cancel()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261127203116.92895-1-sj@kernel.org>
References: <20261127203116.92895-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 20:41:06 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> DAMOS walk could be unexpectedly only partially performed.  It can
> happen when there are multiple schemes and the walk is requested after
> the previous walk is canceled.
>=20
> The expectation of DAMOS walk for a setup that has multiple schemes is
> that it will walk for one snapshot for all schemes.  To know if the walk
> for the one snapshot of a given scheme is done, each damos struct has
> the walk_completed field.  It is set when the walk for the given scheme
> is completed.  The walk skips schemes having the field set.  It is reset
> for all schemes when all the schemes get it set.
>=20
> damos_walk_cancel() cancels all existing walks.  But it does not reset
> the walk_completed field.  damos_walk_cancel() can be called at any
> kdamond loop iteration.  For example, due to DAMON context pause or
> DAMOS watermarks-caused deactivation.  It means that the function can be
> [ ... ]
>=20
> Closes: https://sashiko.dev/#/bug/linux-228a4c52-0545-4c1f-90ce-41114d827=
2e9
> Fixes: bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")
> Cc: <stable@vger.kernel.org> # 6.14.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127203116.9289=
5-1-sj@kernel.org?part=3D1
