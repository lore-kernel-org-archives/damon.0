Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825FB4BA1D6
	for <damon@lists.linux.dev>; Mon, 21 Sep 2026 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004179; cv=none; b=HhmkMDMVsFffZ6Ftzeu4FFQECFxpsOvqYiR03moK7pacEOLEoVOwwWQmVq7stKlNbQbyPjeSFlC1kZlEmReJQ4CQNgCPCdCxdJW0N3gGuhvYfnV8KGzLzunfvCv9A67SlUnIejQMbOfmavCLSKJh6M32IsiTUr2jrB2Xjy0101k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004179; c=relaxed/simple;
	bh=UFYfXSuucjRW3t9NPuzSvdEYIA/nUPz6Pe1MZqn5VXQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aNCccSJtF+bH70blmQgDq1HEv0K4dDclzLL05Ui3uOIOm/exUzSgtt866NHOMPxKFSZjE3bg/u0M8oMRLI4oFaFAXFWrC/Svy1o2LEKj07JMb+E9R2iJSX5kQMFj+RCCMvuEgiGYzvsqwnAqK6pbACoJqoFsTTHzG7alGiFMA+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yvg2aFC3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yvg2aFC3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8361F000FF;
	Mon, 21 Sep 2026 15:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790004178;
	bh=idwgy5JiU71AvKHdRPoqlfF6KKwBuHEH5QjqhRMJuJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yvg2aFC3uqxz12hAmRZtkKbPEDIRgCyvI82fKzlMAzV2UD4yKVjaePcC8+5DvOEN+
	 MxmcC/GaetBSX8dcR+Y64hPEW9hiGMsYJWsAg64hmA9PByR7X0Fb25FDH8LxNa8LJ0
	 bMSjPteUu3zRJe/UgAKnBg4BXihtCF+p+uYr5eQg+OTac/iNaiFBKx4yLJoLKR4vHG
	 FfX6kCMamMJTbpKRzRrzYcdXCbZ+6hiD7cZ2wao5pPmMFPcaw6KyGhoEf5hoI7pXSl
	 +PacN2BW6hcC2+nGQft4P6/hWomZZdRbl5FLnaJRqJPtoXw1k3hzuXFeajjcmOmiM8
	 HfPMrom9LoC1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] mm/damon/core: skip quota score setup when the
 quota is full
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260921151547.78472-2-sj@kernel.org>
References: <20260921151547.78472-1-sj@kernel.org>
 <20260921151547.78472-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 15:22:57 +0000
Message-Id: <20260921152258.0B8361F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Liew Rui Yan <aethernet65535@gmail.com>
>=20
> In damos_adjust_quota(), the quota could already be full.
>=20
> In this situation, damos_adjust_quota() will still calculates
> quota->min_score.  However, this min_score will not be used in this
> window, because in damon_do_apply_schemes(), damos_quota_is_full() will
> always returns true, preventing the scheme from being applied to any
> region.
>=20
> Therefore, add a short circuit for 'esz < min_region_sz' schemes to
> early return from damos_adjust_quota() before calculating min_score.
>=20
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921151547.7847=
2-1-sj@kernel.org?part=3D1

