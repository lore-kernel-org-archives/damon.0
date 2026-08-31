Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E054247043A
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200298; cv=none; b=iSQMNN5+JwCHrprqAL+PHmljWXoxMSdBqvnfC6e/RDeb4fJ2ozesjkSMeXcaoeGZDLcRb6oJIeS4pmXxPxBy0xqQ9GOo5hVRHJ5Hw8q4RrCpQ2AIDwGe2OjkpeIjsG0AiEDhjNKb5zMiD4iE30OyCVvHBr+hZsvtu/RuJFI6l6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200298; c=relaxed/simple;
	bh=prqxAFkUVMlLxaCb9BkuKL3hFcciP+B4avFUnaHduNE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G29XFCnuhBIjYWGc8hyqSMG08UxiYwd39Ebq/Wc2k+FVJI8Rj+X8PbH2GOeCwpjksgYyFLK/0MxS/uDqbM9rEEBhAFsbfUTHBURm7lI1MvoWefgpxf2ayTUrxuiw8D1ctiMyQyZHopuZxrMTp19wO2VX2hUuxDKjdhVqCw49OKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eS5lQI1S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eS5lQI1S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930EE1F000E9;
	Mon, 31 Aug 2026 18:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788200296;
	bh=Us0h0tXI/hgaxEV4gQVPHVL2tzT0nvR6zt340jeeaAg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eS5lQI1SXzoh/SCZSOqlJBC4bBXmVtCWrqynnyp8So5GMZRSwbgsrUzCuqMgLYMoJ
	 IWM4gYPCeJR3MCX/o4/pWizq0qmQ/NhaJDWCFnm+MiKRzSv0NYamYtygxQWkyJXNDT
	 1HgesnlDqbgFENUqT4qE/U2zqCUtc7FYXQ24GmAuKwMT28hXt9lpUULbtyW4/T0Qby
	 4F7T2lM0X8oArgMDJsQMgKYG5j9dYh+pPFBSy9oFR0OPOltck+dLFTFW9EY/TC4+Re
	 TEQrjl0/onOiVT7QqqmXl0aqst9IcZ0D7sAtm51XLmgnN5Jcas4ygnSL02OoHtSAqi
	 CBrri3SwAJHcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] samples/damon/mtier: add comment for struct
 region_range
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831142611.77572-8-sj@kernel.org>
References: <20260831142611.77572-1-sj@kernel.org>
 <20260831142611.77572-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:18:16 +0000
Message-Id: <20260831181816.930EE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Enze Li <lienze@kylinos.cn>
>=20
> The mtier sample defines a local struct region_range using phys_addr_t
> instead of damon_addr_range which uses unsigned long.  Add a comment
> explaining the rationale: on 32-bit systems with more than 4GiB memory,
> phys_addr_t will be 64-bit while unsigned long is 32-bit.
>=20
> Signed-off-by: Enze Li <lienze@kylinos.cn>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831142611.7757=
2-1-sj@kernel.org?part=3D7

