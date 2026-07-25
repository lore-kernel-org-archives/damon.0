Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332A0302767
	for <damon@lists.linux.dev>; Sat, 25 Jul 2026 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013618; cv=none; b=JpSCUZP47h0Fp84srWNq+uNu+JrIc2le1X1kq5kdRBqe7kDKSlkVNqfSK/fGmoIuplxvS+yFxUZmmVuJNn/4XT/zxE4VHML7wo7OBceXJw14yMXnnr1Tt45ya5MFuakKpNovzNFe1ZFqz50o/rlSfJBSNi05wAMhgvN5MC8bKDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013618; c=relaxed/simple;
	bh=LkocqCfeOIcdRoprUea0tAnQNCia9lxHpyFSW4G5+r0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kVqI32AitGODLHDqi0jGPGxl4+W7G/aieEGfLiFpnZH9cJwn0wfzEIF8S0neEXHdSb/xw3KhRBss7et+xESp55glT8aADUYpQ3xLDaWusfk6y901mxPRG2Lcw7XZrqXHUS7vqjVu5RdTugQgxS4xVbjhGKydvIAu4GRwcqaKPkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh7RTgar; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh7RTgar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A896E1F000E9;
	Sat, 25 Jul 2026 21:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013616;
	bh=LkocqCfeOIcdRoprUea0tAnQNCia9lxHpyFSW4G5+r0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vh7RTgarCXBxzX3pI5HMG4WUgulKRQiLkkPQUUWx2NWSNB2O1DiawhNRzcNyqUXx7
	 p9lviY7Va+itfKsMS1dtm5HmR2mJYJ2Br4YYLYI6gHLDig8BGzCCPx9lcEZFYjejIM
	 cRIwUNg7c1NAZcjhPGt72leuRB4gjRO1jZnkZ88TsitZzeDSy1UKGYaJi4BhoNTSMi
	 ihI5EBG7SHN4aXFqvCPs4RO7ELvl1VVzORl4fFBUBYF86So+OZWM66TYol6rK9p9Mc
	 6bldrJ61isQGKYFfGhvGGkhea8wBoEYThdW8c8Sr59Udnxj44WopIKyrjAmApw1Aei
	 X3MqK2BPZXalQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 15/17] Docs/mm/damon/design: document probe preps
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260725210225.129944-16-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
 <20260725210225.129944-16-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 21:06:56 +0000
Message-Id: <20260725210656.A896E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Typo in the commit message: 'DAMN' instead of 'DAMON'.
--

--- Patch [15]: [RFC PATCH 15/17] Docs/mm/damon/design: document probe prep=
s ---
commit 8a47d1109fc79c6ddb959763fb0ede38e076501a
Author: SJ Park <sj@kernel.org>

Docs/mm/damon/design: document probe preps

This commit updates the DAMON design document to include information about
the newly added probe preps feature.

> Update DAMON design document for the newly added DAMN probe preps
> feature.

[Severity: Low]
This isn't a bug, but there is a typo in the commit message body ("DAMN"=20
instead of "DAMON").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725210225.1299=
44-1-sj@kernel.org?part=3D15
