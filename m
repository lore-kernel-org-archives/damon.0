Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166467;
	b=XNYFBYwsZkncbiMywdl5XROmz5i11wTXSPaF6I75YaAJafSwsSfUt0Nk9yjA9ie8sc4P
	 ngX/U3nuO5YJZ4SpuTqQ275djfTORlnrw6jF1zwZNlQFTIZJoY5QFuwqOBGAG2MA1SspH
	 MolqXlLOhLr51UhVkHZSVU+K4VQTcE8NztkL4C4AJFf4qEphsGrfEN+TnzijG+p67iKn5
	 B1nfrIAnuzseVCrTjRiSC02z90hxcFcBWiPKiXHc84kY6Ff50wYEKdVLmXMVk3H1DhHnR
	 kY40r/zdpkx4dj32g6/Sd3E0Ba/IpJIr2xaK1fKLux40wfdYVChvv99Kbwp6PYKuirg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166467;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZDy6Qzw7NsX0/9WtUy0lG+YtZGeaWL6Vm0yncxipJqA=;
	b=KySSkgvrtrTaktFUORYSk2KBKHZuBz3z+56QkxKgSJLZqju6I2NGa6s+2qb8wRv12AOc
	 AmIoHZJLl+cOSGmvyyMRgo9q+Qs7L2YHQbBcl/LDJazD4GvRtY3OR+sNSSXc5shk2oArg
	 uNF2W6DTkxUB58euegIU6W4JyIArV0Qf3F8xOvpAYaN91LNq2bzB4xK+HMmXQxd6gQLs3
	 7u2dsTQovX51FBrrW3HXrnkSGGqeKZ9qcVqW0dPMrQX5Ophnn0Sul9QqRVQU0o8xLqXau
	 r6WOQAPsmFAze/I/DvxizCx5GVOXOJx7g+hV8ZW+6GPS+/spt4eqF0/dWFcxe4mtyAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i3Xhy2LP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F01606A31C
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i3Xhy2LP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52471F0089F;
	Sun,  8 Nov 2026 19:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794166466;
	bh=ZDy6Qzw7NsX0/9WtUy0lG+YtZGeaWL6Vm0yncxipJqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i3Xhy2LPRz2jbM79pX2Fo5siel473h+ER5Uwkdpp8+zAEvxcgU7azMmVBZxi0HYs9
	 gd0u1YXmfk6JilVtcJNb7DSI4m9mVVrS/Nbf+faO+6xZrOJgR5KxNt2bSCyXcOwIRH
	 EtA3LoGC/g8reVHBEP0gdM/QPxbID89v+2wP4+2gdBcQKDYTZ3REl6+C1jreoQ3LOa
	 rJhZJjdBHBRmCajtF6VCHJV0h6WORwJOcPY1O7d9Ll/olxbAggG+NZJkjPo1WVudeI
	 7MOfXhaFeEk8xCNH0prlNB12mhBVZYARlhaky0n1URiKx+fyHfJAaaC8Ip8zAdSRnm
	 Nw6cMSwK8NbDQ==
Message-ID: <sashiko-outbox-203966@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y 4/5] mm/damon/core: remove unreachable damos
 charge_{target,addr}_from
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261108192221.114362-5-sj@kernel.org>
References: <20261108192221.114362-1-sj@kernel.org>
 <20261108192221.114362-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 19:34:26 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108192221.1143=
62-1-sj@kernel.org?part=3D4

