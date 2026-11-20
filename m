Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199722;
	b=XsCnbycTG/9F+018AyNIZHMyrOHDbw2drblRc6bQqrfym/xg2Y3k+rM27VT6JnRj5GRX
	 1bdpsYJKqm6UYaJVqPSBTLBsar616NkWcgUua5EYNdojg1XcJ+anEHyy2ZxxdXq+VXHKJ
	 HRlkZkWT2C9T2J3EcdIGsGNkLj9aTgeDxCSdaYUMkr/BwPeJcrIVMnoRqFC2l+tZboNCE
	 lFfdKzetb0mqv26STJYYQygcXcFkvZNqSLRC0ubhmcb30pu1TeWNfcxGtmJ+iVzMNikCh
	 9pE8dpiy1MzGVPXnTa9wbUmijdVFzIfA//uXqB/yj0vexeZm5bSkcuVXRv0ZXFghAHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199722;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qNYfL/8fKQof6SmSWBe6p8YD8bkENVUo+2mXVDX0bHI=;
	b=lCv13F4qlbb4cEffKy139PXFTx0qcBdsfebH9zzT0QWE86Ux7wdt0rQgO4jQatFd74RF
	 s5ZcZ3Z/yOZFI3ZEja+gl+W4UZZemNc+zNgYwB16PEtrIQf4MLSb2KIGM3I8uA3skDvzk
	 GzAqPXj67Bq8yWrpJuZ/eUZEPZ2MN98IHUQsRGzsvzDVO/OXow0HfO1E0fofTY8V45PUp
	 NOeJRXV9HfoFyMYI2O0PNlzXWIfn/SF/k9P3txnUPZN8TjkzkEwhonGT9qlzScFT54n38
	 ytiV+YEAfOonfPZ5PqFJrE+Wrd8tsj22cer7SNht3dgkffLzLBqkWmP2MJKHYuw/seg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gy+YBxSw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9149360A2608
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gy+YBxSw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044AC1F000C6;
	Fri, 20 Nov 2026 18:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199722;
	bh=qNYfL/8fKQof6SmSWBe6p8YD8bkENVUo+2mXVDX0bHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gy+YBxSwGtcaU2FXLJ0iBo9a7Kwdr5VgHUm/ULMgcOjB0Czy1UvaiCFMkj/j0nvJu
	 VL5f85BIg+/PikQc+qhc9/oxLoswG3GnheSKAgml3fwdDOl/X2LO/xYtVhxU+57lF2
	 D90gjHBolYxIqeMVPTz6+SkAtvFZSpkWvenm/riazoyPvewGi1zDInmhC/W8iCDAAG
	 YLFcUK2Mu3mZTqovuJl29W+S2TvmBzvbHwB0orZ0dj28cOd2ULLAKgxbk6tr1WVFLU
	 3T573WlfVWb+K9YHHEk/fYLdpmFKlx0agExyTrqhKYWXlH0bBPHHDiZWMNRSe5yGXl
	 AllFqNdauGIfg==
Message-ID: <sashiko-outbox-225848@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 34/60] mm/mempolicy: don't rebind policies onto private
 nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-34-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-34-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:35:21 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: "Gregory Price (Meta)" <gourry@gourry.net>
>=20
> A cpuset can allow private nodes, and rebinding a policy to a new cpuset
> mask can move its nodes onto them:
>   - a static policy reapplies the raw user mask.
>   - relative and remapped policies follow node positions in the cpuset
>     mask.
>=20
> Ordinary policies cannot use private nodes.
>=20
> Rebind policies over the cpuset's nodes other than private ones, and
> record the remap base the same way, so adding or removing a private node
> moves no policy.
>=20
> Cpusets keep common memory in every effective mask, so a mask with no
> node left is a bug. Warn, and keep the whole mask rather than leave the
> policy empty.
>=20
> On systems without a private node, rebinding is unchanged.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D34

