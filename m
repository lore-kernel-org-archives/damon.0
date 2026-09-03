Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9313C296BB8
	for <damon@lists.linux.dev>; Thu,  3 Sep 2026 01:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788397852; cv=none; b=ECPUl3Xj+VfaIYai7EaBwMtwvSu346CAHltZYq62GdjXxwXmyIOMu1IH9yUQAnYXP92X+/pBIpzdIsTP7VQdmSi79EKDx2diLkGHMG5iBTdDqV3AC/ttVL1Iv8TDH82D1pxm7a/h9bshaevH9Fv8RoKlGSBrFU4GtfXJy/SeYE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788397852; c=relaxed/simple;
	bh=q21QsgJilwFe2Ld4xgOA9JCRx7sdtVQ1u5ACReDpH3U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CZMUBQ+avERRBJL+gY440vJdIv9m4XlQu1P5M82s3NmBGKefb81T5qYqyrfWZBKjBsHvsHJ0LU6yHDyE7ao7sDE35HLIZHxWv8AmKcgk26g+MeCob7uk0Q1zLNzeFzqf7RT3Ma6VxO2B/WVx+5QBhYA4L8DvM8/jC4WDBYs517M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fleRvn8v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fleRvn8v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDF91F00A3D;
	Thu,  3 Sep 2026 01:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788397851;
	bh=QjTXiZS+rUaUkLofHIItJyIxlymyrJCIt5AoWuO2zag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fleRvn8vxy/8vUNkOb7Wnrhw2sfi87SuSDzrCmE55Wty4Lw4xAmYE1ISC7Q+m6HGp
	 CPcfqTPdMjy7oceA9q6bZVDoqoPzSJexUo803Uh3SLfJ7xC+mPhaVZIVObWE34mW3x
	 CZslNt/mU+WfrJiUEjWRWg6fMPecMsplcWK0Ih5Wz4CSGEmABe4K4FKVxnfCD3esC8
	 ZqfbkyEsBvUfDqiZpE9DYYY65uTULEFBe6fLqA5JH1uARS/a9VoS1VYRjovsUrUlHp
	 /BJS+izm78caYeJ1kjEdPXeui9cFWRrL4xybA3FoYukGKxmE06s2CeUig8dYGwoEwL
	 2LtW285vl1otw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] mm/damon/reclaim: remove unnecessary damon_call()
 param validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260903010334.93622-4-sj@kernel.org>
References: <20260903010334.93622-1-sj@kernel.org>
 <20260903010334.93622-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 01:10:50 +0000
Message-Id: <20260903011051.3FDF91F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON_RECLAIM avoids passing NULL or unstarted damon_ctx to damon_call()
> with its own validation.  The validation is no longer needed, because
> the DAMON core layer now handles the corner cases itself.  Remove the
> unnecessary check.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903010334.9362=
2-1-sj@kernel.org?part=3D3

