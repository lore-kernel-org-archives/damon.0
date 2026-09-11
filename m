Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E62930BF70
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089340; cv=none; b=kJI/4JdhMjQ/2re5FLmsuWJJN5byO3NMH6usJ78fTbvPXlN1wn+tDIsZDQ5PjuLMgRp/7vJ1cKoNGxMcQIvu/qKxM0zaq+rgy5jGnffb7k7UtdaNpwiukonnLuKF+VRJMg4sWbkO6duoQZqHpv4hIr6KQzMbk9/kmgNpfSTJ4xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089340; c=relaxed/simple;
	bh=/vCWafNfU2Pk++miU3kWUt/FrQUQwptFybcTXlZuLO0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pc3FL0SF3PY3AlxScZq4z0otgrxVbwaBepvUFKvSE8gx6wP3I/l7HIO+yjr+5sny7WrPfr5dnuNFbxxjoIoiim9EghC7dSx8RHZ9gBMT/cxbPIxAbEE2FcFJEDuc6tejs6OsvacOCMmlFDWMvblWC8E/yFzNmK/HhUgIxyFIfSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wc6TAUwQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wc6TAUwQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC941F000FF;
	Fri, 11 Sep 2026 01:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089339;
	bh=/vCWafNfU2Pk++miU3kWUt/FrQUQwptFybcTXlZuLO0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wc6TAUwQ7Xlc1vxlt6UCzMgrJRCFjh5d2lkzJ9WTaFzmhhxrNyEYPmt5Q5wxjfrxG
	 /GjFa5wFnv7cR7tHNCkOtztdhqew1otHkABBrOAGcd0PGiI4ibccn5eeyk+DQkhxNU
	 by3MhW0Mv06FwRlo7mHtFEu+6vmFjU3JjhnWEuMy0Cw8UeSYy/cljYu8gYPLTHLMaw
	 fxudjySTE5E7nK/C1a10RCfmlORc+x+ggKLBlEgjrIP6ttPxrnFm9cDR2dyjUIrpZ3
	 3vt98/pfJKftQqsa6VsdK8FRL6aVQhBMXRELK2YyRcuozWerTfBVLc2col6ew/aPjz
	 ovW7oERrpTlzw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 7/7] Docs/admin-guide/mm/damon/usage: update
 for probe_hits_wsum DAMOS filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260911011330.93678-8-sj@kernel.org>
References: <20260911011330.93678-1-sj@kernel.org>
 <20260911011330.93678-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 01:15:38 +0000
Message-Id: <20260911011538.DDC941F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON usage document for the newly added probe hits weighted sum
> based DAMOS core filter type.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911011330.9367=
8-1-sj@kernel.org?part=3D7

