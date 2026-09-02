Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A35387345
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 05:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328517; cv=none; b=MzTVt/ij6tzQtBAItiIssb46haRAgJ3APxzbtEk37DPqZJGignGhnp3psLQVzv3ptc6oJB4+zstSQiujR79OE6KUYovje9dhtlDjinHVP8GXJPy8yfQXahmGL4uU+ecFtQyUP61UA1rmqUm0AbwDGwA0uL3cWEUKaJWKVv2Go6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328517; c=relaxed/simple;
	bh=f5o1nM6K173OmHuzWm3SsGOeh3jNB/mKlG4S0Fw/kD4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r80dMkdKKw0tjDWuo46WLdTDn0vqRMIqYOxxE5n6XOZk2DiFZxLgNB0UO7C1GpTlpTwd7pZF/O1Ypocmwa6z+PSo0U11TJy6RvmRohcIDdiPyGnLBuEFPpO7+X0ODGl7haErZbOlRvKIKKSLHcZsh9WhKPnC2GTaMSgo3m7faZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6oh6V72; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6oh6V72"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DD81F000E9;
	Wed,  2 Sep 2026 05:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328516;
	bh=AvCGBkzmcnFVzkiZpZ/6xu5Sjj5F92DMdH8sl6/xQxo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k6oh6V7207PnHGkNAUkO6ftJjWGuPVfy0HQscoUfF6rMWqMhdZsPckwz9pPoOv3Qr
	 vYXw9SImU/o+mosMCbgnxY5qaT+y/yVzbAMnInB29Vejq/Zr6TV8HsEG3ro0C09SX7
	 sFS/S0EeAWSbpKoZRm3Ou+nO7UkVOhOMsa+rujMWV5DemDTrwkR9oGqrKiaBlTC/CR
	 iRUR8oPUCryKbPD8BqpFc+IBF6+OfeWymUXDmbryFdUsFeaHteSb2kSQneddj8DwQr
	 4a9EEYJ3idW9vkW+DvOCNw7LLCC8ncxjQ5Jjx0SJHwSnfsZECGAm4Wg8IgYScDpbzU
	 ycBn5LoL7KWRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/12] Docs/ABI/damon: recommend subsystem doc instead
 of admin-guide
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902054747.99370-13-sj@kernel.org>
References: <20260902054747.99370-1-sj@kernel.org>
 <20260902054747.99370-13-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 05:55:15 +0000
Message-Id: <20260902055515.C7DD81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON ABI doc is recommending DAMON admin-guide for people who are
> willing to know further about DAMON.  Nowadays the subsystem doc
> (Documentation/mm/damon) is a more recommended place for even beginners.
> Recommend the subsystem doc over admin-guide.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902054747.9937=
0-1-sj@kernel.org?part=3D12

