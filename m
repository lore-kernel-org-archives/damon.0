Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547248;
	b=DuTNeQ7zCZ7CbeeJ8aDwgDIgPxvm6YdwoOTkK/tz2Yo3xSe/WEWc6KdRu1iE16ISkJQM
	 ls8R1FGFX5N0AinID2u59LCjujVTsu9AEb1zdAE3CTPGbC/qlaoK0E6U8gBHLzMKBbGjZ
	 k7wyYsyJ7L6wY8sswROGMJSZCVXEGk0tW0i70mTC0GavvAymylX9boj2fzMeVukDwwK/s
	 /6IPx+yX/XynaCbEXvOUWll65dvzS+RX9Ek9+MtX3ErxirVDrIX2ofV9dzOtBg9wrHwkc
	 6JUYOHN400Ip8lZlflZ8eU3qJeLfbTvydixQzxZPOphNROFka6HrrYMbxbIG3prC5QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547248;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RhY66/inlnxrxR5rGdCil1YdU6bksAISOCKVhZ1pKeY=;
	b=rnAY7fQk+tgCmKCsFNCyd8FlhsgjZFepC0Mz5/0/4TJt/+xMhOgWquzERqilgIUnlWKZ
	 fzIxQABLLVPjkPy9vI/4YJcBSgX4FWaZy7ldNMUablN3JthpTHZMmn87kZ4unRI4L2K1H
	 hoWTyarLXmnlwvWG/knyDi4pdSB0951/QmoQmwdahyR1Bjr6O21PeRt49P5nFyufT2uiw
	 9CsT+dNnT33h8+6txGNgKqQlVMveV5boYtvqafHZ1enWgx0tkgeekzpkLA9OYchRiNQhh
	 APTryzM2DQPcVnctcaylj8VUSzTPwRTQuosRz92oa/XjlWoKrmTiufcdFxZwmt9v1WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8yQsjsn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF20B606A321
	for <damon@lists.linux.dev>; Fri, 13 Nov 2026 05:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8yQsjsn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9871F000C4;
	Fri, 13 Nov 2026 05:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794547248;
	bh=RhY66/inlnxrxR5rGdCil1YdU6bksAISOCKVhZ1pKeY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P8yQsjsnpu+wAApXBu59zHIxMC+mAaZyoNVuBO1l/nR+dfJ0+TP/uPmtVRIFcb6aQ
	 15/uyrKKchav0FtcQAsLdkZISWch10KKAHNfmjDrkIKBA1C+elqPHz47ou8DVCvLh0
	 qcKqANNKg+jRowVrYjomHswR2rW+IPWn0g62D90B/ltWdUvruWosQAauSbFO8WWbAk
	 nCtvbmOQVDkIwrri6zq2E+FUDdsWaioksmc78tfBFYD/vBhMhgjuMalAONgf29YIvp
	 5uyHN29U1Q941I4DabBBwzk5YlpjpNwMHgXgCWc6ALy/2AXFSNZALE+CMAsRRM2TvM
	 0EmBc0bFedY9w==
Message-ID: <sashiko-outbox-212221@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] mm/damon/api: define DAMON_FILTER_TYPE_ACTIVE
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261113051711.89274-2-sj@kernel.org>
References: <20261113051711.89274-1-sj@kernel.org>
 <20261113051711.89274-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 05:20:48 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Knowing which memory is on Active LRU lists is useful for understanding
> and optimally operating systems.  Extend the DAMON core layer to be
> ready for support of that.  For that, define a new damon_filter_type,
> DAMON_FILTER_TYPE_ACTIVE.  It has no additional arguments and therefore
> no additional change in the core layer is needed.  Testing if a given
> memory is on an LRU list for the type of filter should be implemented in
> the operation set layer.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113051711.8927=
4-1-sj@kernel.org?part=3D1

