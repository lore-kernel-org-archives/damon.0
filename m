Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898DC58497E
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963130; cv=none; b=tOJhlpIgt76EiWno8PhU6kefYUbe4fgwAZi8PgV54KwUsJ0baLfg8DWvId72Eeyp00trnLaaEgoAiY1heDEsnj415tHQuMx3tnlYoZCgaD8aSDXcvOvm4hwCl/mhCYDoOnh0bPJm4q2dwk1GBquMojO/7FVWHDLIZ35P+hSr85A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963130; c=relaxed/simple;
	bh=LND2H6Fi7D/sCNKl3St/RD24Qdj6ZQNilef57jZDvN0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pVDfh0BYns9CESXgKvXQuPo+JuME4fIy5lqzj6MCKOrHo3XD77+f1aCIAIHMpJNwWJUmUsQxGL0n1M4SdwcueymOcs3BtDFqir0otk79zm2Jt8VLWOL7qRSeVgZfdiuiCNsP8UiLdV49pnInFzJqHO/zbA8p7Kgn86uTVCKjGiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMAdRr8L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMAdRr8L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95AA1F00A3A;
	Wed,  9 Sep 2026 14:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963129;
	bh=ITa5FH8w3utluuZhNAF/svz62wGBLJfrJlxfOvlJUGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YMAdRr8LUIXbDDeZIrta4Ks3Qzg//HLHVubtIs1hvGfB2/LWUhlrJf51153iKlZ8M
	 Rzc482sMgJ5wGPYrPsBfwIVrFwxJTL4vBDIz2nzg1RsaazQTawLTbyDlzmcYpGXjEi
	 XhT6LGjEBFJDHhEWUmrGhCqRi+cmBuawf/Nq8jsf62ZG0iZrCCBuUmK6KwMSarTeSc
	 3X16VfdpgOwEAWAB6aG7xPlsFQWFZ7mMcJOpk6PhPNz7gAiIRmvgaccyYaH7a4Khgu
	 SJBPOASgA8B5m/boNgycea0oSsF4l0sg3KZdIrhtQSfiSaD/GTSS5tPrZBnTQlQ9rA
	 k9Fd5btx4bqWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH REPOST 1/5] mm/damon/vaddr: support prep_probes
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909140408.104699-2-sj@kernel.org>
References: <20260909140408.104699-1-sj@kernel.org>
 <20260909140408.104699-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:12:08 +0000
Message-Id: <20260909141208.E95AA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON virtual address space operation set (vaddr) is not supporting
> prep_probes.  Add the support.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909140408.1046=
99-1-sj@kernel.org?part=3D1

