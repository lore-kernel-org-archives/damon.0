Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18891D9A5F
	for <damon@lists.linux.dev>; Sat,  5 Sep 2026 20:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788640288; cv=none; b=KwrnXku8Gvn0GssOPLH+Y2AK0wo18TShVaz9AhoabK1DE5WwjQ9qLT8VW2GoXYpSR051v67TfM8YXp/XPph2Ot1YB4Xy3gq+9iYsElkVVzBYSVCoHyhsRaD+rmSc71JFoAiwjWoUtzCYcgfym/EB+3CUE/nMUbnuMXLsJC1iIzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788640288; c=relaxed/simple;
	bh=ECwimMzBwgzlZv4QdHmZV6Msio/jQRviFrqgZKNFTUU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Og740CdxLNIImuY44jtWyPApogGEqqy9GO26rC1/GnoFyeTK2pmCpqg3nonoWgHRXMTTCwOCRjgihy7r5bCkpd3RlATuNp3TG+jJeiGgRGTrPUTDEYp//NirkX9vYw6BC9V8CSzKRdU4NKw7bdlOAp3q75cTp11EOvMl2tqQdVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRuaru6M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRuaru6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C34D1F00A3A;
	Sat,  5 Sep 2026 20:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788640286;
	bh=UYyid+zeF//q0diLjcUBajngWTkdosMwxS9fLITpfcQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jRuaru6MJB7YPJGeglM3yfehpOLghBoWcTxpwT29uqe+nI4GXisLMkxrnxiowIQFb
	 038tAqvWPXiSpbJb9uDUx5u/4JhOxH9/Ichlxvc/PQ1GgKIO2RBpMdDTiWumFdCO+y
	 VuKmzPOZlFVo02teDETfo73gAY1YSYWKdE3GMxDdx0P1h77GKLVbvybEI8G/uKczdF
	 uU6yNkIe9G/CeKLOMBrXLYRrxV4HJbjfqU9ywLXnLgcQgzL/2YvfeQV4E05xc7e9Nj
	 YdFryh5NPW9lxYvghztjDRsMAjEwVNpysz9Xv+hvCg9erO3ljoYvJrr4O9LyKRTxqK
	 epQbynzN+ThOQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/5] mm/damon/paddr: move probe filter handling to
 ops-common
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260905202634.88102-3-sj@kernel.org>
References: <20260905202634.88102-1-sj@kernel.org>
 <20260905202634.88102-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 20:31:25 +0000
Message-Id: <20260905203126.7C34D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Probe filter matching logic for anon and memcg type filters in DAMON's
> physical address space operation set (paddr) can be reused by virtual
> address space operation set (vaddr) in future.  Prepare the future by
> moving the code to ops-common.c
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905202634.8810=
2-1-sj@kernel.org?part=3D2

