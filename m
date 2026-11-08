Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169701;
	b=bWF5ouEtQ92AJJUzuZ4K0ynYtHBX4C2cL+lq2U2QwNHVmEV8wuLnxlsRn5w2GS63yMOg
	 E53hjw5Bv5XJPHgqVL6K5EjmhwjAGFrncFfS7+Oi45IseprmvJdKAaVGzORO9fsrvImG3
	 QabANBV8J+6nAzXjOiXv7V4FmjDw5LquYO0S2Dz2C83gd5XOT3Jj6EryFQ8Lp6IiT6U4P
	 fDIqzs2HYiKGpp5OQDxDRoLe0AH5+fG2hWGRfCRySWIULBdQVRR+ZVHsH/BCrvx0/6qFk
	 EqdugkUKtR5Xj90ja/jnHXu1a2okwj8D6KNz8qqTmo1LT080jJorQiD9C7BH+JGK+RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169701;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KZcO9FbWrTnk2NlyN5t7jUVFvBrSuQY/1bRBVrnBuUI=;
	b=tRXdbVT+nXLceBd0XSktxwxigAyoWt0K2lHqeHX8CcZdehGTN6Hh5+/ukEQLZGEFHVkx
	 +7T3jQ9J/n4TG27Z4Xg1VIQGF5ruDanjPoabTlNKop4JNhZ134Ftxpi4xUM0TID6y2oR6
	 LzhkFOMUYZqvqLtjSI42R8lBiGDE7+XM1EYQtPkZeKJdBs0dn4mza+FzZaIOIHAy5DZqj
	 KnSbrWcWLBZgq29SUIjduzMDj6mO5do0QjjvkeVGyiJZJ2Bnl8uz818UB42Qn50KpJtkR
	 4ox8VQuNNuGzKa3Ba4HTeLLFNxika4qbQA033vU7ewA4mU+Ujd1URaY26vPZwbeigRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vh3XkNYt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61497606D830
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vh3XkNYt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204A01F00921;
	Sun,  8 Nov 2026 20:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169701;
	bh=KZcO9FbWrTnk2NlyN5t7jUVFvBrSuQY/1bRBVrnBuUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vh3XkNYtByjWjcWSFGi9SvVQaXFlA8QSjZcCUnRjAAIK+aUjCj2OXD1JJe5hpmJCY
	 aT7jCoPBsYWVbLjuizDuCZAedSNCCuk+7/ppwEwi9mQdCQ8aglpPjxeDNbYJlqYnGb
	 3zzIoxEO+TtBbWg2+baDcYhD+i6xAvNKUJ2VZQa4r8zuIVrw052VhERSz9B5Y1Rhfu
	 9jKM79yWdlzK4uJ10FB1xAD6LHzbQllEIIeAUHCUw5lCPVClhHdwUMocGkMWqEHnaF
	 t9spQ5q1u0286FxBRjLsbJgmBLVgpeoZuIScVu9KjQvD1LbCwVesFN5XRaKKtyPNTr
	 KeVYoCGRtM/mA==
Message-ID: <sashiko-outbox-204015@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y 3/3] mm/damon/core: remove unreachable damos
 charge_{target,addr}_from
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261108201456.116824-4-sj@kernel.org>
References: <20261108201456.116824-1-sj@kernel.org>
 <20261108201456.116824-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 20:28:20 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damos_quota->charge_{target,addr}_from saves the target and region the
> scheme's quota limit is reached.  damos_skip_charged_region() skips the
> target and regions before the point.  The target that was assigned to
> charge_target_from could be dynamically removed from the context by the
> runtime parameters update (aka commit) feature.  In this case,
> damos_skip_charged_region() cannot find if the point is passed or not,
> so the scheme is effectively disabled.
>=20
> Similarly, the user could also remove all the regions of the target
> using the runtime parameters update feature.  It would be uncommon to do
> that, but it is a supported feature.  Because the skip pointer detection
> logic (damos_skip_charged_region()) works for each region of targets,
> this result in the logic is entirely skipped and the scheme is
> effectively disabled again.
>=20
> The user impact is that the DAMOS scheme could suddenly stop working
> under certain uses of the runtime parameters update feature.  It could
> surprise users. No crash or leak happens though.  Users could also
> simply work around by re-installing the scheme.
>=20
> Catch the corner cases in damos_adjust_quota() and reset the pointers.
>=20
> Link: https://lore.kernel.org/20261020023958.108276-1-sj@kernel.org
> Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Closes: https://sashiko.dev/#/bug/linux-cd0c55fc-0cc8-45d8-9637-3334811c4=
9b8
> Cc: <stable@vger.kernel.org> # 5.19.x
> (cherry picked from commit 5695abc4e742b947f586bfb6a080a80ad9957e5d)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108201456.1168=
24-1-sj@kernel.org?part=3D3

