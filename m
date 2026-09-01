Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023263AC0E5
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 04:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237739; cv=none; b=tkFVZ5UKtImGe9+2s+acZ8/Vr/drOi715lzIsFATPM5Tk4BWB3QUl7GypI/Gw4jrgS2DKz1CUANE8uZtP795ufYqQqkWqb0Zcc0u1+4r3S9WS6tpvUoLA04nojYrz/xAfYaqqc4BPznWGuXG6z8AIB5CYjFgeuV7a6CqTwk4xZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237739; c=relaxed/simple;
	bh=GTOejUA+DUA+tgBN1be7XwzQPfQi901K6nSr6MvMCYM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jqGU7FwSYGbBzE3CosZ9jkiX+lzlYGSD0WFomVcURAuEjoXJqRBsja8j4XnCuiCqZU5IfOYksSCAoGJz6C9/mHCDUlp0UkT/EcXtbpkssIfNtxCyzUAHTOUHnNzg30kIt2uAHQNWqAZDqgkmIAyj/iJiyd8oiowczcv5/vbPYtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOiYqIqK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOiYqIqK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1D81F000E9;
	Tue,  1 Sep 2026 04:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237737;
	bh=pcftcOy+vgmCERHbMdz3u4Eo7/XY08JpI78j+/3CESs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZOiYqIqK/Pq85iyGfg50R1lp8oii5qpAjmGF2WIP4c8cWsel/ZbkEeGnE1Ueq+j73
	 fEoSDcFesZsl/4RSQmfvzVimCrEiHAHyjETKAClZV34K+tHzfyP9uBGo9k5rHQoirv
	 yDdcjIsyP2bp9HtUD9WEuDD97TvDp2BXzpFhHnwg4gcJitroJe6B+M/mlquu39zjNZ
	 fnkYdFzMywpaf2xA+OTS7HhMH/y3lpG3QfI71E3RzWo8Syhaa5yPKNMMXaLGW05KGE
	 HyzcSRTIy33cNeLa6wZl+7cKFpo74IryhtLWWUec906y/1fASoigVOKEyl3Qaz039I
	 p7hocO94Z+1Jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/17] mm/damon/sysfs: implement preps/nr_preps file
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901043417.2165-11-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
 <20260901043417.2165-11-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 04:42:16 +0000
Message-Id: <20260901044217.6F1D81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Implement nr_preps file under the preps directory.  It will be evolved
> to be used for generating sub directories that will represent each probe
> preparation action.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901043417.2165=
-1-sj@kernel.org?part=3D10

