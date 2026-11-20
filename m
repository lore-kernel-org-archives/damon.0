Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795155111;
	b=KiVvc1Ctpf0xNpEnBG/zyOaMRtd7+BgoR8JF2xAOd8cRPr8wPb/LvR5Er1+dbGiP72cc
	 Dh8oHQho3mJJNgkmOLxH+CJACB62E48lo5BJmcmvKtYCavtzdUCXosRRqfXs8FFbgglFC
	 lATILj6qO20tCSbEtvPxELq0RvA6bxPpmHKByWxylAOlxevUKL6k6qbUEQl4u6jwa7n6l
	 MdTJU45Xxp0JkI7/59YnU2KWRqgX0GgdPlzcWbmnLSopiqqTU/A5lbeoy0li7w7XIWdSB
	 W9H0hgVuTMmWT/6AFbymAc6W7vHO/FUfM6d4opEzysYCFgldzVeZR3WDwJIsx5j4GCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155111;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oQzuhhxubNvSaHipctEKR+p4fvuxBflS+65RhjKyI1U=;
	b=mbk0zZjH1wgdYBGIu/Gio6jVSVl1UoQOJD5lF2ctRfBhdlkS/+ti2h29MvqD3DNReemJ
	 XYCcOOyFTTQcn09tU3Jox4SgE1bcNBpqiHzsZUiOdiplJW1snNlq1zWaWayR02WOC/eWX
	 WcrgI7s9xTe3hUepv8dYEi3QvNlx27xWRI8wfZ+ST4HXO4QaB9sJl1QSefxDr/HHXZABq
	 aGYQwZtvm/eErXwTszCnJ0sHLB9Wnt4sKwnsmekA7Bnr5MvY8Dt+SwtayAItzxq4YiNvx
	 y8pFbxXkguSTe1sMqgbWF22JzwLcHMGFcozNJE/B2EPI83VfVTx254/rxrnKnXSgh9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOLm8Ykq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9171A606A51F
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 06:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOLm8Ykq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356E41F000D0;
	Fri, 20 Nov 2026 06:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795155111;
	bh=oQzuhhxubNvSaHipctEKR+p4fvuxBflS+65RhjKyI1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hOLm8Ykq7ed0RiyAA7ZmkjhL/zmYNOJlCvhyBhJCvVTC+gHZIJGdTi++Sa5CL2fMg
	 aYC9yFg4u9RWze35PpJHxRV5EMdEh/Hy6vMBOdPDGEi2ahAL/qlpzhP1AKIvIzGVe7
	 CmSXtib+by/Yhhb0pzh/F3vmrJJQc4Qm83mSHbU/+1AdTu1uUMCRlK5YkNAVJTc77Q
	 mrKoGMVr4t+7Z0wA49+ikwXyGrv/Egaj4hx98DXgyHMpmwBS+q3rWeTt/t8bFuLIC3
	 uxFEukLtZe8SM7v78YCINI2X41HMn6aUNMOYHL3I/4FgyuxnjTuakam/A+uE6Twn2I
	 hzADXjHWOmgww==
Message-ID: <sashiko-outbox-224541@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/4] mm/damon/reclaim: disable watermarks by default
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120060741.92121-4-sj@kernel.org>
References: <20261120060741.92121-1-sj@kernel.org>
 <20261120060741.92121-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 06:11:50 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> DAMON_RECLAIM's free memory based watermarks features were introduced as
> a safe guard for wrongly-tuned coldness threshold (min_age).  The
> default watermark values were chosen to let users easily understand how
> those can be set and tuned.  The default values are never meant to be
> used as are.  DAMON_RECLAIM is later updated to enable PSI-driven
> coldness threshold auto-tuning by default.  When the auto-tuning is
> enabled, having the watermarks with the default values makes no sense.
> Disable the watermarks by default.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120060741.9212=
1-1-sj@kernel.org?part=3D3

